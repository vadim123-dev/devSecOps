#!/bin/bash
set -e  # stop script on any error
exec > /var/log/user_data.log 2>&1  # log everything for debugging

# ── 1. Install EFS utils and mount ───────────────────────────
dnf install -y amazon-efs-utils

mkdir -p /mnt/efs

# Mount by IP - bypasses DNS completely
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 \
  ${efs_mount_ip}:/ /mnt/efs

#simpler mount command version
# mount -t nfs4 ${efs_mount_ip}:/ /mnt/efs

<!--
  EFS Mount Options Comparison:
  
  Option        | Simple mount      | Extended mount
  --------------|-------------------|------------------
  Protocol      | NFS4 default      | NFS 4.1 explicit
  Buffer size   | OS default ~128KB | 1MB (better throughput)
  On disconnect | May give up       | Retries forever
  Use case      | Learning/dev      | Production
 -->

# Persist across reboots
echo "${efs_id}:/ /mnt/efs efs defaults,_netdev,tls 0 0" >> /etc/fstab

# ── 2. Create index.html on EFS (Instance A only does this) ──
# The -e flag means: only create if it doesn't already exist
# This prevents overwriting if instance is replaced/rebooted
if [ ! -f /mnt/efs/index.html ]; then
  cat > /mnt/efs/index.html <<'EOF'
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>My App</title>
  </head>
  <body>
    <h1>Hello from EFS — served by Nginx</h1>
    <p>This file lives on EFS and is shared between instances.</p>
    <img src="${s3_object_url}" alt="S3 Image" style="max-width:600px;" />
  </body>
</html>
EOF
fi

# ── 3. Install Docker ─────────────────────────────────────────
dnf install -y docker
systemctl start docker
systemctl enable docker

# ── 4. Run Nginx container with EFS volume ───────────────────
# -v maps /mnt/efs (on EC2) → /usr/share/nginx/html (in container)
# :ro = read-only inside the container (best practice)
docker run -d \
  --name nginx \
  --restart always \
  -p 80:80 \
  -v /mnt/efs:/usr/share/nginx/html:ro \
  nginx:latest
#!/bin/bash
set -e
exec > /var/log/user_data.log 2>&1

# ── 1. Install EFS utils and mount ───────────────────────────
dnf install -y amazon-efs-utils

mkdir -p /mnt/efs

# Mount by IP - bypasses DNS completely
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 \
  ${efs_mount_ip}:/ /mnt/efs

# Simpler mount command version
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

echo "${efs_id}:/ /mnt/efs efs defaults,_netdev,tls 0 0" >> /etc/fstab

# ── 2. Install Nginx natively ─────────────────────────────────
dnf install -y nginx

# ── 3. Point Nginx root to EFS mount ─────────────────────────
# Strategy: edit the default server block's root directive
sed -i 's|/usr/share/nginx/html|/mnt/efs|g' /etc/nginx/nginx.conf

# Give nginx permission to read the EFS mount
# (amazon-efs-utils mounts as root, nginx runs as nginx user)
chmod 755 /mnt/efs

# ── 4. Start Nginx ────────────────────────────────────────────
systemctl start nginx
systemctl enable nginx
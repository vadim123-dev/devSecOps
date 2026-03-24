# main.tf

# Declare the provider being used, in this case it's AWS.
# This provider supports setting the provider version, AWS credentials as well as the region.
# It can also pull credentials and the region to use from environment variables, which we have set, so we'll use those


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


# declare a resource stanza so we can create something, in this case a key pair
resource "aws_key_pair" "my_key_pair" {
  key_name   = "${var.keyname}KP"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCuvnfLDdm5d0EgW0zYIRiDOfvhLQ7Dzquis6MjG/pIhVRAO0NG9mDimx09cgLNtb0++EQR7KdxPMtZPVJMHHG3A5eEKuF6LmxM5awIS2/8deUFRx2r/8Px9C1MRo3ALT+5U+8MqCqJkc+0WjyTTd3zpjSvugUViS1f8ZzxPY2okVXdHk0Q+n6odh4Lteu4TZ5pQ9jvN2AkzQZkdyTlhTRqNvrlZWWSCij3mx1broCHbiQKe2Sm0Q0n1WB7oROoOmIeMbbAfAjgeEMiVneXSfHD3p7cU4qEqMRrcy9q961xIodUzlPI4vJKGoT/L8tN5yp4NEQiu0sojS0QaR0L3ogV vadim@vadim-Virtual-Machine"
}

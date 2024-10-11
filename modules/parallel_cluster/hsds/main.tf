# Create an ECR repository for the HSDS Docker image
resource "aws_ecr_repository" "hsds" {
  name = "hsds-server"
}

# Execute the local-exec provisioner to generate the file and build Docker image
resource "null_resource" "build_and_push_docker" {
  provisioner "local-exec" {
    command = <<EOT
      # Write the generated .hscfg file to the directory
      echo "${data.template_file.hscfg.rendered}" > ${path.module}/.hscfg

      # Build the Docker image with the generated .hscfg file
      docker build -t hsds-server ${path.module}

      # Log into AWS ECR
      aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin ${aws_ecr_repository.hsds.repository_url}

      # Tag and push the Docker image to ECR
      docker tag hsds-server:latest ${aws_ecr_repository.hsds.repository_url}:latest
      docker push ${aws_ecr_repository.hsds.repository_url}:latest
    EOT
  }
}

# Upload the rendered script to S3 for parallel cluster to use
resource "aws_s3_object" "post_install_script" {
  bucket = var.post_install_bucket
  key = "hsds_post_install.sh"
  content = data.template_file.post_install.rendered
}
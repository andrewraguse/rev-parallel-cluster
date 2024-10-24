# Render the post_install script template with dynamic values
data "template_file" "post_install" {
  template = file("${path.module}/templates/hsds_post_install.tmpl")

  vars = {
    ecr_repository_url = aws_ecr_repository.hsds.repository_url
    AWS_REGION = var.region
  }
}
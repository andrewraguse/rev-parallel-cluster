# Generate the .hscfg file from the template
data "template_file" "hscfg" {
  template = file("${path.module}/templates/.hscfg.tmpl")

  vars = {
    hs_username = var.hs_username
    hs_password = var.hs_password
  }
}

# Render the post_install script template with dynamic values
data "template_file" "post_install" {
  template = file("${path.module}/templates/hsds_post_install.tmpl")

  vars = {
    ecr_repository_url = aws_ecr_repository.hsds.repository_url
    AWS_REGION         = var.region
  }
}
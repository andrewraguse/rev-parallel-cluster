# Render the post_install script template with dynamic values
data "template_file" "post_install" {
  template = file("${path.module}/templates/hsds_post_install.tmpl")

  vars = {
    post_install_bucket_name = var.post_install_bucket
  }
}
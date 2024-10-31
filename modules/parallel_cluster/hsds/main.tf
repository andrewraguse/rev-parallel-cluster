# Upload the rendered script to S3 for parallel cluster to use
resource "aws_s3_object" "post_install_script" {
  bucket = var.post_install_bucket
  key = "hsds_post_install.sh"
  content = data.template_file.post_install.rendered
}

# Upload the rendered script to S3 for parallel cluster to use
resource "aws_s3_object" "runall_custom_script" {
  bucket = var.post_install_bucket
  key = "runall_custom.sh"
  content = file("${path.module}/templates/runall_custom.sh")
}

# Upload the rendered script to S3 for parallel cluster to use
resource "aws_s3_object" "start_hsds_script" {
  bucket = var.post_install_bucket
  key = "start_hsds.sh"
  content = file("${path.module}/templates/start_hsds.sh")
}
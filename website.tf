module "website" {
  source                         = "./modules/s3-cloudfront-website/us-east-1"
  context                        = module.base_labels.context
  label_order                    = var.label_order
  environment                    = var.environment
  name                           = module.base_labels.id
  domain_name                    = "example.com"
  /* zone_id                        = aws_route53_zone.this.zone_id */
  website_cloudfront_min_ttl     = var.website_cloudfront_min_ttl
  website_cloudfront_default_ttl = var.website_cloudfront_default_ttl
  website_cloudfront_max_ttl     = var.website_cloudfront_max_ttl
}

resource "aws_s3_bucket_object" "file_upload" {
  bucket = "my_bucket"
  key    = "my_bucket_key"
  source = "${path.module}/my_files.zip"
  etag   = "${filemd5("${path.module}/my_files.zip")}"
}
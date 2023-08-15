resource "aws_acm_certificate" "my_certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    Name = "ninja certificate"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "acm_validation_record" {
  zone_id = var.hosted_zone_ID
  name    = "_8fdcfa143506b9b3adf2d8c706ff7860.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300
  records = ["_da9167e0f6b91ca336d2d36168b3f40c.nbgfhbpblk.acm-validations.aws."]
}

resource "aws_route53_record" "cloudfront_alias_record" {
  zone_id = var.hosted_zone_ID
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.my_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.my_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_acm_certificate_validation" "my_certificate_validation" {
  certificate_arn         = aws_acm_certificate.my_certificate.arn
  validation_record_fqdns = [aws_route53_record.acm_validation_record.fqdn]
}


resource "aws_cloudfront_distribution" "my_distribution" {
  origin {
    domain_name = var.origin_domain
    origin_id   = data.aws_s3_bucket.ninja-bucket.bucket


    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
  aliases = [var.domain_name]

  enabled             = true
  is_ipv6_enabled     = true
  http_version        = "http2"
  price_class         = "PriceClass_100"
#   default_root_object = "index.html"

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.my_certificate.arn
    ssl_support_method  = "sni-only"
  }

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = data.aws_s3_bucket.ninja-bucket.bucket

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

}

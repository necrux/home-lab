#--------------------------------------------------------------
# DNS Zones
#--------------------------------------------------------------
resource "aws_route53_zone" "necrux" {
  name = var.necrux_domain

  tags = local.tags
}

resource "aws_route53_zone" "weshenderson" {
  name = var.weshenderson_domain

  tags = local.tags
}

resource "aws_route53_zone" "breakfix_training" {
  name = var.breakfix_training_domain

  tags = local.tags
}

resource "aws_route53_zone" "babykalel" {
  name = var.babykalel_domain

  tags = local.tags
}

#--------------------------------------------------------------
# DNS Records
#--------------------------------------------------------------

# necrux.com
resource "aws_route53_record" "necrux_apex_a" {
  zone_id = aws_route53_zone.necrux.zone_id
  name    = var.necrux_domain
  type    = "A"
  ttl     = 1800

  records = [
    "185.199.108.153",
    "185.199.109.153",
    "185.199.110.153",
    "185.199.111.153",
  ]
}

resource "aws_route53_record" "necrux_apex_aaaa" {
  zone_id = aws_route53_zone.necrux.zone_id
  name    = var.necrux_domain
  type    = "AAAA"
  ttl     = 14400

  records = [
    "2606:50c0:8000::153",
    "2606:50c0:8001::153",
    "2606:50c0:8002::153",
    "2606:50c0:8003::153",
  ]
}

resource "aws_route53_record" "necrux_alea_a" {
  zone_id = aws_route53_zone.necrux.zone_id
  name    = "alea.${var.necrux_domain}"
  type    = "A"
  ttl     = 1800

  records = [
    "185.199.108.153",
    "185.199.109.153",
    "185.199.110.153",
    "185.199.111.153",
  ]
}

resource "aws_route53_record" "necrux_alea_aaaa" {
  zone_id = aws_route53_zone.necrux.zone_id
  name    = "alea.${var.necrux_domain}"
  type    = "AAAA"
  ttl     = 14400

  records = [
    "2606:50c0:8000::153",
    "2606:50c0:8001::153",
    "2606:50c0:8002::153",
    "2606:50c0:8003::153",
  ]
}

resource "aws_route53_record" "necrux_kind_hosts" {
  for_each = var.kind_hostnames

  zone_id = aws_route53_zone.necrux.zone_id
  name    = "${each.value}.${var.necrux_domain}"
  type    = "A"
  ttl     = 1800

  records = [
    var.kind_server_ip,
  ]
}

resource "aws_route53_record" "necrux_github_pages" {
  for_each = var.necrux_github_pages_hostnames

  zone_id = aws_route53_zone.necrux.zone_id
  name    = "${each.value}.${var.necrux_domain}"
  type    = "CNAME"
  ttl     = 1800

  records = [
    "www.${var.necrux_domain}",
  ]
}

resource "aws_route53_record" "necrux_printer_a" {
  zone_id = aws_route53_zone.necrux.zone_id
  name    = "printer.${var.necrux_domain}"
  type    = "A"
  ttl     = 1800

  records = [
    "192.168.86.250",
  ]
}

resource "aws_route53_record" "necrux_zen_a" {
  zone_id = aws_route53_zone.necrux.zone_id
  name    = "zen.${var.necrux_domain}"
  type    = "A"
  ttl     = 1800

  records = [
    "192.168.86.68",
  ]
}

resource "aws_route53_record" "necrux_zenbook_cname" {
  zone_id = aws_route53_zone.necrux.zone_id
  name    = "zenbook.${var.necrux_domain}"
  type    = "CNAME"
  ttl     = 1800

  records = [
    "zen.necrux.com",
  ]
}

#resource "aws_route53_record" "necrux_nas_a" {
#  zone_id = aws_route53_zone.necrux.zone_id
#  name    = "nas.${var.necrux_domain}"
#  type    = "A"
#  ttl     = 1800
#
#  records = [
#    "192.168.86.55",
#  ]
#}

resource "aws_route53_record" "necrux_nas_cname" {
  zone_id = aws_route53_zone.necrux.zone_id
  name    = "nas.${var.necrux_domain}"
  type    = "CNAME"
  ttl     = 1800

  records = [
    "truenas.necrux.com",
  ]
}

resource "aws_route53_record" "necrux_www_cname" {
  zone_id = aws_route53_zone.necrux.zone_id
  name    = "www.${var.necrux_domain}"
  type    = "CNAME"
  ttl     = 14400

  records = [
    "necrux-blog.github.io",
  ]
}

resource "aws_route53_record" "necrux_github_pages_challenge" {
  zone_id = aws_route53_zone.necrux.zone_id
  name    = "_github-pages-challenge-necrux.${var.necrux_domain}"
  type    = "TXT"
  ttl     = 14400

  records = [
    "e4283b5562ef870328f3db69591adf",
  ]
}

resource "aws_route53_record" "necrux_alea_github_pages_challenge" {
  zone_id = aws_route53_zone.necrux.zone_id
  name    = "_github-pages-challenge-necrux.alea.${var.necrux_domain}"
  type    = "TXT"
  ttl     = 14400

  records = [
    "12e42d410b12d807804dc5aee740d1",
  ]
}

#resource "aws_route53_record" "necrux_smtp_dkim" {
#  zone_id = aws_route53_zone.necrux.zone_id
#  name    = "smtp._domainkey.${var.necrux_domain}"
#  type    = "TXT"
#  ttl     = 14400
#
#  records = [
#    "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCm52aiUR2zBn1POmbrFUJo91WcSjOwoHkREj6kr5Fbz3ngRHU3n7ElnlJKV1CG5tUmP3Y7K1UhoOm5KA5hF1hA8fyvsY7Qdp/WO2mRaoHjGRwp5rCvW1iY5aT7whhB/gWdQeUcVI2IBngqfxjnleg6ktjo /zZ+r+cqcnFNUypbDwIDAQAB",
#  ]
#}

#resource "aws_route53_record" "necrux_google_verification_cname" {
#  zone_id = aws_route53_zone.necrux.zone_id
#  name    = "r6rzohoo45ms.${var.necrux_domain}"
#  type    = "CNAME"
#  ttl     = 14400
#
#  records = [
#    "gv-cx4bloi4ijgv4a.dv.googlehosted.com",
#  ]
#}

#resource "aws_route53_record" "necrux_acme_challenge" {
#  zone_id = aws_route53_zone.necrux.zone_id
#  name    = "_acme-challenge.${var.necrux_domain}"
#  type    = "TXT"
#  ttl     = 14400
#
#  records = [
#    "46N5rT8ZQ8eac18CJ0ptqQ1vOdsuslUe7AmRpxb5NhY",
#    "nnfkvdkViFFpbIxR6f5ZgB3A2HgkbGQWGqsDjBHViQs",
#  ]
#}

#resource "aws_route53_record" "necrux_3d_a" {
#  zone_id = aws_route53_zone.necrux.zone_id
#  name    = "3d.${var.necrux_domain}"
#  type    = "A"
#  ttl     = 1800
#
#  records = [
#    "192.186.86.83",
#  ]
#}

#resource "aws_route53_record" "necrux_sms_a" {
#  zone_id = aws_route53_zone.necrux.zone_id
#  name    = "sms.${var.necrux_domain}"
#  type    = "A"
#  ttl     = 1800
#
#  records = [
#    "54.210.91.122",
#  ]
#}

#resource "aws_route53_record" "necrux_books_a" {
#  zone_id = aws_route53_zone.necrux.zone_id
#  name    = "books.${var.necrux_domain}"
#  type    = "A"
#  ttl     = 1800
#
#  records = [
#    "54.210.91.122",
#  ]
#}

# weshenderson.info
resource "aws_route53_record" "weshenderson_apex_a" {
  zone_id = aws_route53_zone.weshenderson.zone_id
  name    = var.weshenderson_domain
  type    = "A"
  ttl     = 300

  records = [
    "185.199.108.153",
    "185.199.109.153",
    "185.199.110.153",
    "185.199.111.153",
  ]
}

resource "aws_route53_record" "weshenderson_apex_aaaa" {
  zone_id = aws_route53_zone.weshenderson.zone_id
  name    = var.weshenderson_domain
  type    = "AAAA"
  ttl     = 300

  records = [
    "2606:50c0:8000::153",
    "2606:50c0:8001::153",
    "2606:50c0:8002::153",
    "2606:50c0:8003::153",
  ]
}

resource "aws_route53_record" "weshenderson_www" {
  zone_id = aws_route53_zone.weshenderson.zone_id
  name    = "www.${var.weshenderson_domain}"
  type    = "CNAME"
  ttl     = 300

  records = [
    "weshenderson.github.io",
  ]
}

resource "aws_route53_record" "weshenderson_github_pages_challenge" {
  zone_id = aws_route53_zone.weshenderson.zone_id
  name    = "_github-pages-challenge-weshenderson.${var.weshenderson_domain}"
  type    = "TXT"
  ttl     = 3600

  records = [
    "077ae161235e27b5d8cf55c163fe38",
  ]
}

#resource "aws_route53_record" "weshenderson_email" {
#  zone_id = aws_route53_zone.weshenderson.zone_id
#  name    = "email.${var.weshenderson_domain}"
#  type    = "CNAME"
#  ttl     = 300
#
#  records = [
#    "mailgun.org",
#  ]
#}

#resource "aws_route53_record" "weshenderson_spf" {
#  zone_id = aws_route53_zone.weshenderson.zone_id
#  name    = var.weshenderson_domain
#  type    = "TXT"
#  ttl     = 300
#
#  records = [
#    "v=spf1 include:mailgun.org ~all",
#  ]
#}

#resource "aws_route53_record" "weshenderson_mailgun_dkim" {
#  zone_id = aws_route53_zone.weshenderson.zone_id
#  name    = "krs._domainkey.${var.weshenderson_domain}"
#  type    = "TXT"
#  ttl     = 300
#
#  records = [
#    "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDD5vUu1IXRu6Oemp0kLZI/VvwYTdhXKbWOjFmONXUoeB/qnM5sYJeeFOmHYq6D2gREYTKrnAHGHUwzkcKPZg8fHJHGmgkRUgn4zjXWlFBDExysnNQXczEP+XtrA/jVZJxMUlurGsQGBgaItvGdeC8l9kvl nFOLEcBWw9l8kA6uVQIDAQAB",
#  ]
#}

#resource "aws_route53_record" "weshenderson_google_verification" {
#  zone_id = aws_route53_zone.weshenderson.zone_id
#  name    = "krkjpapxgsuh.${var.weshenderson_domain}"
#  type    = "CNAME"
#  ttl     = 300
#
#  records = [
#    "gv-erjww7ouvrpfwx.dv.googlehosted.com",
#  ]
#}

# breakfix.training
resource "aws_route53_record" "breakfix_training_www" {
  zone_id = aws_route53_zone.breakfix_training.zone_id
  name    = "www.${var.breakfix_training_domain}"
  type    = "CNAME"
  ttl     = 300

  records = [
    "breakfix.training",
  ]
}

# babykalel.com
resource "aws_route53_record" "babykalel_www" {
  zone_id = aws_route53_zone.babykalel.zone_id
  name    = "www.${var.babykalel_domain}"
  type    = "CNAME"
  ttl     = 300

  records = [
    "babykalel.com",
  ]
}
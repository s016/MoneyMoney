#==============================================================
#vpc
resource "aws_vpc" "default" {
  cidr_block           = "10.0.0.0/21"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "MoneyMoney"
  }
}
#==============================================================
#publicサブネット
resource "aws_subnet" "public0" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1a"
  tags = {
    name = "MoneyMoney"
  }
}
resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1c"
  tags = {
    name = "MoneyMoney"
  }
}
#ルートテーブル
resource "aws_route_table" "public" {
  vpc_id = resource.aws_vpc.default.id
  tags = {
    name = "MoneyMoney"
  }
}
#ルート
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.default.id
  destination_cidr_block = "0.0.0.0/0"
}

#publicサブネットとpublicルートテーブルの関連付け
resource "aws_route_table_association" "public0" {
  subnet_id      = aws_subnet.public0.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}
#http通信のセキュリティグループ
module "http_sg" {
  source      = "./modules/security_group"
  name        = "http-sg"
  vpc_id      = aws_vpc.default.id
  port        = "80"
  cidr_blocks = ["0.0.0.0/0"]
}
#==============================================================
#privateサブネット
resource "aws_subnet" "private0" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-1a"
  tags = {
    name = "MoneyMoney"
  }
}

resource "aws_subnet" "private1" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-1c"
  tags = {
    name = "MoneyMoney"
  }
}

#privatesubnetルートテーブル
resource "aws_route_table" "private" {
  vpc_id = resource.aws_vpc.default.id
  tags = {
    name = "MoneyMoney"
  }
}

#provateサブネットとprivateルートテーブルの関連付け
resource "aws_route_table_association" "private0" {
  subnet_id      = aws_subnet.private0.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private.id
}
#==============================================================
#インターネットゲートウェイ
resource "aws_internet_gateway" "default" {
  vpc_id = resource.aws_vpc.default.id
  tags = {
    name = "MoneyMoney"
  }
}
#==============================================================
#ALB
resource "aws_lb" "default" {
  name               = "MoneyMoneyLB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.https_sg.security_group_id]
  subnets = [
    aws_subnet.public0.id,
    aws_subnet.public1.id
  ]
  enable_deletion_protection = false
  #access_logs {
  #  bucket  = aws_s3_bucket.lb_logs.bucket
  #  prefix  = "test-lb"
  #  enabled = true
  tags = {
    name = "MoneyMoney"
  }
}

#https用のセキュリティグループ
module "https_sg" {
  source      = "./modules/security_group"
  name        = "https-sg"
  vpc_id      = aws_vpc.default.id
  port        = "443"
  cidr_blocks = ["0.0.0.0/0"]
}

#https通信用のリスナー
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.default.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.default.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default.arn
  }
}

#httpのリクエストの場合httpsへリダイレクト
resource "aws_lb_listener" "redirect_http_to_https" {
  load_balancer_arn = aws_lb.default.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

#ターゲットグループの作成
resource "aws_lb_target_group" "default" {
  name        = "backend"
  port        = "80"
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.default.id
  depends_on = [
    aws_lb.default
  ]
  health_check {
    enabled             = true
    protocol            = "HTTP"
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 10
    interval            = 180
    matcher             = 200
  }
  tags = {
    name = "MoneyMoney"
  }
}

#=============================================================
#route53
resource "aws_route53_zone" "default" {
  name = "moneymoney.cf"
}

resource "aws_route53_record" "default" {
  zone_id = aws_route53_zone.default.zone_id
  name    = aws_route53_zone.default.name
  type    = "A"
  alias {
    name                   = aws_lb.default.dns_name
    zone_id                = aws_lb.default.zone_id
    evaluate_target_health = true
  }
}
#SSL証明書の発行
resource "aws_acm_certificate" "default" {
  domain_name               = aws_route53_zone.default.name
  subject_alternative_names = ["*.${aws_route53_zone.default.name}"]
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}
#検証用のレコード
resource "aws_route53_record" "certificate_vertify" {
  for_each = {
    for dvo in aws_acm_certificate.default.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.default.zone_id
}
#検証完了まで待機
resource "aws_acm_certificate_validation" "default" {
  certificate_arn         = aws_acm_certificate.default.arn
  validation_record_fqdns = [for record in aws_route53_record.certificate_vertify : record.fqdn]
}
#=============================================================
#ecs
#ecsの実行のIAM呼び出し
module "ecs_task_execution_role" {
  source      = "./modules/iam"
  iam_name    = "ecs-task-execution"
  identifiers = "ecs-tasks.amazonaws.com"
  policy      = data.aws_iam_policy_document.ecs_task_execution.json
}
#参照ポリシー
data "aws_iam_policy" "ecs_task_execution_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
#ECS実行のポリシーにSSMから値を取ってこれる権限を追加
data "aws_iam_policy_document" "ecs_task_execution" {
  source_policy_documents = ["${data.aws_iam_policy.ecs_task_execution_role_policy.policy}"]
  statement {
    effect    = "Allow"
    actions   = ["ssm:GetParameters", "kms:Decrypt"]
    resources = ["*"]
  }
}

#クラスターの定義
resource "aws_ecs_cluster" "default" {
  name = "MoneyMoney"
}

#タスク定義
resource "aws_ecs_task_definition" "default" {
  container_definitions = templatefile("./container_difinitions.json", {
    rails_ecr_url = aws_ecr_repository.rails_ecr.repository_url,
    nginx_ecr_url = aws_ecr_repository.nginx_ecr.repository_url,
    ssm_url       = aws_ssm_parameter.secret.arn
  })
  requires_compatibilities = ["FARGATE"]
  family                   = "MoneyMoney"
  network_mode             = "awsvpc"
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
  cpu                      = "256"
  memory                   = "512"
}

#サービスの定義
resource "aws_ecs_service" "backend" {
  launch_type      = "FARGATE"
  task_definition  = aws_ecs_task_definition.default.arn
  platform_version = "1.3.0"
  cluster          = aws_ecs_cluster.default.id
  name             = "backend"
  desired_count    = 2

  network_configuration {
    subnets = [
      aws_subnet.public0.id,
      aws_subnet.public1.id
    ]
    security_groups  = [module.http_sg.security_group_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.default.arn
    container_name   = "nginx"
    container_port   = 80
  }
}
#ECR
resource "aws_ecr_repository" "rails_ecr" {
  name = "rails"
}
resource "aws_ecr_repository" "nginx_ecr" {
  name = "nginx"
}

#=============================================================
#SSM
resource "aws_ssm_parameter" "secret" {
  name        = "ProductionKey"
  description = "railsのproduction.key"
  type        = "SecureString"
  value       = "production key"
  tags = {
    name = "MoneyMoney"
  }
}
#=============================================================
#cloudwatchログ
resource "aws_cloudwatch_log_group" "for_ecs" {
  name              = "/ecs/MoneyMoney"
  retention_in_days = 180
}
#=============================================================

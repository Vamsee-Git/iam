resource "aws_iam_user" "aws_terraform_user" {
  name = "aws_terraform_user"
}

resource "aws_iam_user_policy_attachment" "admin_policy_attachment" {
  user       = aws_iam_user.aws_terraform_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_access_key" "aws_terraform_user_access_key" {
  user = aws_iam_user.aws_terraform_user.name
}

resource "aws_iam_role" "ec2_s3_access" {
  name = "ec2-s3-access1"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "ec2_s3_access_policy" {
  name   = "EC2S3AccessPolicy"
  role   = aws_iam_role.ec2_s3_access.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "*"
      }
    ]
  })
}

# Output the access key and secret key
output "aws_terraform_user_access_key_id" {
  value = aws_iam_access_key.aws_terraform_user_access_key.id
}

output "aws_terraform_user_secret_access_key" {
  value = aws_iam_access_key.aws_terraform_user_access_key.secret
  sensitive = true
}

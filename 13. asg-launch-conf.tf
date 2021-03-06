resource "aws_launch_configuration" "user30-asg-launch" {
  name_prefix = "user30-autoscaling-web-"

  image_id = var.amazon_linux
  instance_type = "t2.nano"
  key_name = var.user30_keyname
  security_groups = [
    aws_security_group.user30-sg.id,
    aws_default_security_group.user30-default-sg.id,
  ]
  associate_public_ip_address = true
    
user_data = <<USER_DATA
#!/bin/bash
yum update

#### AWS DevOps 샘플로 배포하시는 경우 아래 내용 무시하시고 CodeDeploy Agent만 설치
## 본인 지정 리전코드로 변경작업 필요 
## 예) 
## yum -y install https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/codedeploy-agent.noarch.rpm
## service codedeploy-agent start 


#### ALB만 설정하는 경우 아래 사용
yum -y install httpd
echo "<html>" > /var/www/html/index.html
echo "Hello" >> /var/www/html/index.html
echo "<p> SERVER IP: $(curl http://169.254.169.254/latest/meta-data/local-ipv4) </p>" >> /var/www/html/index.html
echo "<img src=\"CloudFront URL\">" >> /var/www/html/index.html
echo "</html>" >> /var/www/html/index.html

## CodeDeploy용 인스턴스 생성하는 경우 (**** 한 부분은 Region Code로 대체, 예/ us-east-1 )
#wget https://aws-codedeploy-******.s3.amazonaws.com/latest/codedeploy-agent.noarch.rpm
#yum -y install codedeploy-agent.noarch.rpm


## HTTPD 데몬 실행시 Amazon Linux 1세대인 경우
/bin/systemctl start httpd.service
service httpd start
chkconfig --level 2345 httpd on  ## 시스템 시작할 때 데몬 구동

## HTTPD 데몬 실행시 Amazon Linux 2세대인 경우 (아래 주석 제거)
#systemctl start httpd.service
#systemctl enable httpd.service


####
  USER_DATA

  lifecycle {
    create_before_destroy = true
  }
}

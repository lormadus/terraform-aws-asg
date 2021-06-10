# Terraform 으로 AWS ALB 및 AutoScaling Group 생성 예제

## 생성 순서

변수 선언
Region 선택
VPC 구성 -> Subnet 생성
IGW 생성 및 VPC 연결
Routing Table 생성 -> IGW를 위한 라우팅 규칙 추가 -> Subnet과 연결
인스턴스 접속을 위한 RSA Key 생성(ssh-keygen)
ALB를 위한 보안 그룹 생성
부하 분산을 위한 ALB 생성
대상 그룹 (Target Group) 생성 
VM접속을 위한 보안 그룹 생성
오토 스케일링 그룹 생성
오토 스케일링 그룹 정책 생성(Scale In/Out)

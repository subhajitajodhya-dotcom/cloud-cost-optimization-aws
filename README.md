# Cloud Cost Optimization Project (AWS)

Provisions AWS infrastructure with Terraform, runs a containerized demo app with
Docker, monitors resource usage with Prometheus and Grafana, and uses PowerShell
scripts (AWS CLI) to automate cost optimization. No Kubernetes.

## Folder structure
- terraform/   VPC, subnet, internet gateway, security group, key pair, EC2 instance
- docker/      Demo Flask app, Dockerfile, docker-compose.yml
- monitoring/  Prometheus, Grafana and node-exporter via docker-compose
- scripts/     PowerShell: start/stop instances, cleanup, cost report

## Quick steps
1. Install: AWS CLI, Terraform, PowerShell. Run `aws configure` with an IAM user's keys.
2. Create an SSH key: `ssh-keygen -t ed25519 -f $HOME/.ssh/cost-opt-key`
3. In terraform/, create terraform.tfvars with `admin_cidr = "YOUR_IP/32"`
4. `terraform init`, `terraform plan`, `terraform apply`
5. Copy docker/ and monitoring/ to the EC2 instance (scp), then run
   `docker compose up -d --build` in each folder.
6. Open http://<public-ip> (app), :3000 (Grafana), :9090 (Prometheus).
7. Run the PowerShell scripts from scripts/ and record before/after cost.
8. When finished: `terraform destroy` to avoid charges.

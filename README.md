# Notes Management App - Infrastructure as Code (IaC) with Terraform

This project sets up the infrastructure for a Notes Management application using AWS services. The infrastructure is provisioned using Terraform and includes components like ECS (Elastic Container Service), RDS (Relational Database Service), VPC (Virtual Private Cloud), and ECR (Elastic Container Registry).

### Key Components

- **VPC Module**: Sets up the Virtual Private Cloud, subnets, internet gateway, and route tables.
- **ECS Module**: Configures the Elastic Container Service cluster for running front-end and back-end services.
- **RDS Module**: Provisions the PostgreSQL database using Amazon RDS.
- **ECR**: Docker images for both front-end and back-end services are stored in ECR.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html)
- [AWS CLI](https://aws.amazon.com/cli/)
- Docker installed locally
- AWS credentials configured locally with sufficient permissions to manage ECS, RDS, and ECR.

## Getting Started

###

1. Clone the repository

```bash
git clone https://github.com/woytekn/notes-manager-iac.git
cd notes-manager-iac
```

2. Configure Terraform

Ensure that your terraform.tfvars file contains your desired variables for the prod environment.

```
vpc_cidr =
vpc_name =
public_subnet_count =
private_subnet_count =
public_subnet_cidrs =
private_subnet_cidrs =
availability_zones =
cluster_name =
allocated_storage =
rds_engine =
rds_engine_version =
rds_instance_class =
rds_db_name =
rds_username =
rds_password =
fe_image =
be_image =
execution_role_arn =
```

3. Initialize and apply Terraform

```
cd environments/prod
terraform init
terraform apply -var-file="terraform.tfvars"
```

4. Build and Push (to ECR) Docker Images

FE repository - https://github.com/woytekn/notes-manager.git
BE repository - https://github.com/woytekn/notes-manager-be.git

5. Update ECS Services

terraform apply -var-file="terraform.tfvars"

6. Access the Application

Once everything is set up and the ECS tasks are running, you can access your front-end application through the public IP address of the ECS service. The backend service will be accessible at port 5001.

To check the public IP of the front-end:

Go to the ECS console.
Check the running ECS service for the public IP.
Access the app at http://<public-ip>

Security
Ensure that sensitive files such as terraform.tfvars and .pem keys are not committed to the repository.
Use environment variables or secure vault services (like AWS Secrets Manager) for managing sensitive data.

Troubleshooting

1. ECS tasks not starting
   Check the ECS console for detailed error messages. The issue could be related to misconfigured security groups, networking issues, or misconfigured IAM roles.

2. Database connection issues
   Ensure that the RDS instance is accessible from the ECS backend service by verifying the security groups and networking configurations.

3. Debugging logs
   You can view the application logs in AWS CloudWatch to help with debugging.

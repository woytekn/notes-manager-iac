resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
}

resource "aws_security_group" "fe_sg" {
  vpc_id = var.vpc_id
  description = "Security group for front-end ECS service"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port       = 5001
    to_port         = 5001
    protocol        = "tcp"
    security_groups = [aws_security_group.be_sg.id]
  }

  tags = {
    Name = "${var.cluster_name}-fe-sg"
  }
}

resource "aws_security_group" "be_sg" {
  vpc_id = var.vpc_id
  description = "Security group for back-end ECS service"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-be-sg"
  }
}

# Front-End Task Definition
resource "aws_ecs_task_definition" "fe_task" {
  family                   = "${var.cluster_name}-fe-task"
  network_mode             = "awsvpc"
  container_definitions    = jsonencode([{
    name      = "fe-container"
    image     = var.fe_image
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
  }])
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
}

# Back-End Task Definition
resource "aws_ecs_task_definition" "be_task" {
  family                   = "${var.cluster_name}-be-task"
  network_mode             = "awsvpc"
  container_definitions    = jsonencode([{
    name      = "be-container"
    image     = var.be_image
    essential = true
    portMappings = [{
      containerPort = 5001
      hostPort      = 5001
    }]
    environment = [
      {
        name  = "DB_HOST"
        value = var.db_host
      },
      {
        name  = "DB_USER"
        value = var.db_user
      },
      {
        name  = "DB_PASSWORD"
        value = var.db_password
      }
    ]
  }])
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
}

# ECS Service for Front-End
resource "aws_ecs_service" "fe_service" {
  name            = "${var.cluster_name}-fe-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.fe_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [aws_security_group.fe_sg.id]
    assign_public_ip = true
  }
}

# ECS Service for Back-End
resource "aws_ecs_service" "be_service" {
  name            = "${var.cluster_name}-be-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.be_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [aws_security_group.be_sg.id]
    assign_public_ip = true
  }
}

# IAM Role for ECS Task Execution
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })

  tags = {
    Name = "ecsTaskExecutionRole"
  }
}

# Attach policy to ECS task execution role
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

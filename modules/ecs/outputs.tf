output "ecs_cluster_id" {
  value = aws_ecs_cluster.ecs_cluster.id
}

output "fe_security_group_id" {
  value = aws_security_group.fe_sg.id
}

output "be_security_group_id" {
  value = aws_security_group.be_sg.id
}

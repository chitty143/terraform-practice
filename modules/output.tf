output "ec2_arn" {
  value = aws_instance.test[0].arn
}

output "ec2_public_ip" {
  value = aws_instance.test[0].public_ip
}

output "ec2-volume_id" {
  value = aws_ebs_volume.volume.id
}


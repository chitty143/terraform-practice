output "instance_public_ip" {
    value = aws_instance.test[0].public_ip
}

output "instance_id" {
 value = aws_instance.test[0].id
}

output "instance_arn" {
value = aws_instance.test[0].arn
}
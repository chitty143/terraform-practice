output "vpc_id" {
    value = data.aws_vpc.self.id
}

output "owner_id" {
    value = data.aws_vpc.self.owner_id
}

output "ig_id" {
    value = aws_internet_gateway.ig.id
}

output "eip_public_ip" {
    value = aws_eip.nat_eip.public_ip
}
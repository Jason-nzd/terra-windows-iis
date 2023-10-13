output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.ec2_win
}

output "instance_http_address" {
  description = "Public http address of the EC2 instance"
  value       = "http://${aws_instance.ec2_win.public_dns}"
}

output "ssh_command" {
  description = "SSH command for connecting to EC2 instance"
  value       = "ssh -i ${var.ssh_key_local_path}${var.ssh_key_name}.pem ec2-user@${aws_instance.ec2_win.public_ip}"
}

output "rdp_user_name" {
  description = "Remote desktop user name"
  value       = "Administrator"
}

output "encrypted_rdp_password" {
  description = "Encryped password for remote desktop, available 2-4 minutes after launch"
  value       = aws_instance.ec2_win.password_data
}

output "decrypted_rdp_password" {
  description = "Decrypted password for remote desktop, available 2-4 minutes after launch"
  value       = rsadecrypt(aws_instance.ec2_win.password_data, file("${var.ssh_key_local_path}${var.ssh_key_name}.pem"))
}

output "instance_http_address" {
  description = "Public http address of the EC2 instance"
  value       = "http://${aws_instance.ec2_win.public_dns}"
}

output "rdp_user_name" {
  description = "Remote desktop user name"
  value       = "Administrator"
}

output "decrypted_rdp_password" {
  description = "Decrypted password for remote desktop, available 2-4 minutes after launch"
  value       = rsadecrypt(aws_instance.ec2_win.password_data, file("${var.ssh_key_local_path}${var.ssh_key_name}.pem"))
}

output "remote_desktop_command" {
  value = "mstsc /v:${aws_instance.ec2_win.public_ip} /prompt /w:1280 /h:1024"
}

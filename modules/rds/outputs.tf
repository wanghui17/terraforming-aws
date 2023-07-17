output "rds_address" {
  value = "${element(concat(aws_db_instance.rds.*.address, tolist([""])), 0)}"
}

output "rds_port" {
  value = "${element(concat(aws_db_instance.rds.*.port, tolist([""])), 0)}"
}

output "rds_username" {
  value = "${element(concat(aws_db_instance.rds.*.username, tolist([""])), 0)}"
}

output "rds_password" {
  sensitive = true
  value     = "${element(concat(aws_db_instance.rds.*.password, tolist([""])), 0)}"
}

output "rds_db_name" {
  value = "${element(concat(aws_db_instance.rds.*.name, tolist([""])), 0)}"
}

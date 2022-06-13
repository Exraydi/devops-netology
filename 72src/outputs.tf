output "yandex_zone" {
  value       = yandex_compute_instance.vm-count[*].zone
}

output "yandex_ip_private" {
  value       = yandex_compute_instance.vm-count[*].network_interface.0.ip_address
}

output "yandex_vpc_subnet" {
  value       = yandex_vpc_subnet.subnet[*].id
}
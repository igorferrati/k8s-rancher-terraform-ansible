output "instance_ips" {
  value = {
    for instance_name, instance in google_compute_instance.vm-ubuntu :
    instance_name => instance.network_interface[0].access_config[0].nat_ip
    if length(instance.network_interface[0].access_config) > 0
  }
}
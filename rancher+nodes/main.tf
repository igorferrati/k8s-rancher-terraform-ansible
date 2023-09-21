module "rancher_nodes" {
  source = "../infra"
  instance_type = "e2-standard-2"
  instance_zone01 = "us-central1-a"
  instance_zone02 = "us-central1-b"
  instance_zone03 = "us-central1-c"
  gcp_project = "igor-398900"
  gcp_region =  "us-central1"
  gcp_zone = "us-central1-a"
  instance_name = "ubuntu-node"
  image = "ubuntu-2004-focal-v20230907"
}

output "external_ips" {
  value = module.rancher_nodes.external_ips
}
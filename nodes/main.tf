module "nodes" {
  source = "../infra"
  gcp_project = "igor-398900"
  gcp_region =  "us-central1"
  gcp_zone = "us-central1-c"
  qtd = 3
  instance_name = "ubuntu-node"
  instance_type = "e2-standard-2"
  image = "ubuntu-2004-focal-v20230907"

}
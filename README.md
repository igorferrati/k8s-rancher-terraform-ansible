## k8s-rancher-terraform-ansible

Repository intended for studying the creation of infrastructure for fully managed Kubernetes.

---

### Architecture

For terraform:

* cloud provider Google Plataform Cloud - GCP
* Nodes: 3 machines
* Rancher: 1 machine

For ansible:

* Nodes machines: must have docker or containerd
* Rancher: must have docker

notes: nodes will be control plane, etcd and worker. (study environment)

---
### Set up GPC

You must configure your account key, follow [terraform documentation](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build)

### set up ssh to ansible

1. create ssh key, exemple:
```
ssh-keygen -t ed25519 -f ~/path/ansible_ed25519 -C ansible
```

2. add public key to gcp project: compute engine > metadata > ssh

* now all vm in the project inherited the ssh key

---

### Set up infra

set up main.tf in folders: nodes and rancher.

in each folder:
```
terraform init
```

```
terraform plan/apply
```

if you want to destroy your infra:

```
terraform destroy
```

### Ansible

We're using ansible to set up all dependencies in our infra.

This is an exercise for study and have many ways to do this !.

in ansible folder:

```
 ansible-playbook <arq.yml> -u <user> --private-key <private-key> -i <arq-hosts.yml>

```
exemple:
```
 ansible-playbook playbook.yml -u ansible --private-key ansible_ed25519 -i hosts.yml
```
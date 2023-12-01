## k8s-rancher-terraform-ansible

Repository intended for studying the creation of infrastructure for fully managed Kubernetes.

---

### Architecture

For terraform:

* cloud provider Google Plataform Cloud - GCP
* Nodes: 3 machines
* Rancher: 1 machine

notes: nodes will be control plane, etcd and worker. (study environment)

---
### Set up GPC

You must configure your account key, follow [terraform documentation](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build)

---

### Ansible

**set up ssh to ansible**

1. create ssh key, exemple:
```
ssh-keygen -t ed25519 -f ~/path/ansible_ed25519 -C ansible
```

2. add public key to gcp project: compute engine > metadata > ssh

* now all vm in the project inherited the ssh key

**Run Ansible**

Required Python library to use docker_container_module:

* for python 3:

``` 
pip install docker 
```

* For more: [ansible documentation](https://docs.ansible.com/ansible/2.9/modules/docker_container_module.html)

Obs: we're using ansible to set up all dependencies in our infra, this is an exercise for study and have many ways to do this !.

---

### Terraform

in terraform folder: 
```
terraform init
```

```
terraform apply
```

3. Pickup output ip's in terminal and set ```hosts``` with ips, user and ssh keypath in ansible folder.

```
[name]
ip ansible_user=user ansible_ssh_private_key_file="/path/your_private_key"
```
### Ansible

And then run:

```
 ansible-playbook main.yml -i hosts.yml
```

5. Pick up output ```Bootstrap Password``` and access ```vm-rancher-ip:80``` to finish Rancher install and reate a new custom cluster.

### Golang

6. Now we're gonna use script go to register nodes in our new custom cluster, in script folder:

* You need to add you cluster token and vms ip, take a look in go script to setup. Then:

```
go mod init nodes-register.go
```
```
go get packages.name
```
```
go run nodes-register.go
```

7. Wait and fish !

### Destroy your infra

```
terraform destroy
```
---

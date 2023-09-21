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

### Set up infra

set up ```main.tf``` in folders: 
* infra
* rancher+nodes

1. in each folder:

```
terraform init
```
2. In node+rancher folder:

```
terraform apply
```

3. Pickup output ip's in terminal and set ```hosts.yml``` in ansible folder.

4. Run ansible playbook to install docker and run rancher in container.

```
 ansible-playbook playbook.yml -u ansible --private-key ansible_ed25519 -i hosts.yml
```

5. Pick up output ```Bootstrap Password``` and access ```vm-rancher-ip:80``` to finish Rancher install and reate a new custom cluster.

6. Now register your nodes in your new custom cluster:

```
ssh -i ansible_ed25519 ansible@vm-ip
```
Execute your **resgitration command** for each node and fish.

7. if you want to destroy your infra, in node+rancher folder:

```
terraform destroy
```
---

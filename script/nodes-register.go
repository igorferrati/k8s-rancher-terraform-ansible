package main

import (
	"fmt"
	"os"
	"time"

	"golang.org/x/crypto/ssh"
)

var (
	sshUser       = "ansible"
	sshKey        = "/home/igor/projects/k8s-rancher-terraform-ansible/keys/ansible_ed25519"
	waitTime      = 4 * time.Minute
	commandToExec = "sudo docker run -d --privileged --restart=unless-stopped --net=host -v /etc/kubernetes:/etc/kubernetes -v /var/run:/var/run  rancher/rancher-agent:v2.6.8 --server {{ https://ip-rancher}} --token {{ your-rancher-token }} --ca-checksum {{ rancher roken id }} {{ --etcd }} {{ --controlplane }} {{ --worker }}"
)

var ipList = []string{"ip", "ip", "ip"}

func main() {

	sshKey, err := os.ReadFile(sshKey)
	if err != nil {
		fmt.Printf("Erro ao ler o path da chave ssh %v\n", err)
		return
	}

	for _, ip := range ipList {
		fmt.Printf("Conectando na vm %s...\n", ip)
		client, err := connectSSH(ip, sshUser, sshKey)
		if err != nil {
			fmt.Printf("Erro ao conectar na vm %s: %v\n", ip, err)
			continue
		}

		defer client.Close()

		fmt.Printf("Registrando nó...")
		output, err := executeCommand(client, commandToExec)
		if err != nil {
			fmt.Printf("Erro ao executar comando na vm %s: %v\n", ip, err)
		} else {
			fmt.Println("Saída do comando:")
			fmt.Println(output)
		}

		time.Sleep(waitTime)
	}
}

func connectSSH(ip, user string, key []byte) (*ssh.Client, error) {
	signer, err := ssh.ParsePrivateKey(key)
	if err != nil {
		return nil, err
	}

	config := &ssh.ClientConfig{
		User: user,
		Auth: []ssh.AuthMethod{
			ssh.PublicKeys(signer),
		},
		HostKeyCallback: ssh.InsecureIgnoreHostKey(),
	}

	return ssh.Dial("tcp", ip+":22", config)
}

func executeCommand(client *ssh.Client, command string) (string, error) {
	session, err := client.NewSession()
	if err != nil {
		return "", err
	}
	defer session.Close()

	output, err := session.CombinedOutput(command)
	if err != nil {
		return "", err
	}

	return string(output), nil
}

import docker

def main():
    try:
        # Crie uma instância do cliente Docker
        client = docker.DockerClient(base_url='unix://var/run/docker.sock')

        # Liste os contêineres em execução
        containers = client.containers.list()

        # Exiba os nomes dos contêineres em execução
        for container in containers:
            print(f'Nome do contêiner: {container.name}')

    except Exception as e:
        print(f"Ocorreu um erro: {str(e)}")

if __name__ == "__main__":
    main()

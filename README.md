# private-docker-resgistry
This repository shows how to deploy and manage a private docker registry on premises 


Private Docker registries are a practical way of distributing resources and sharing Docker images between containers. Setting up a private registry speeds delivery and ensures smooth CI/CD development using the Docker platform.

Follow the steps to setup a registry:

# Install Docker: 
 If Docker is not already installed on your Linux system, you'll need to install it. The exact method varies depending on your Linux distribution, but Docker provides installation instructions for various distributions on their website.

https://docs.docker.com/engine/install/


# Create Docker Compose file:
  Create a docker compose file in your system. sample docker-compose.yml is given in repository

# Set Up Authentication
Create a directory named auth in the same directory as your docker-compose.yml file. Inside the auth directory, create a file named htpasswd containing your desired username and password for authentication. You can generate the htpasswd file using tools like htpasswd or online generators

# Start Docker Registry

Run the following command in the directory containing your docker-compose.yml file to start the Docker registry and UI:

docker-compose up -d

# Access Docker Registry UI
Once the containers are running, you can access the Docker registry UI by visiting http://<Docker-host-IP>:8080 in your web browser. Log in using the username and password you set up in the htpasswd file.

# Push and Pull Images
You can now push Docker images to your private registry using the docker push command and pull images from it using the docker pull command. Make sure to tag your images with the address of your private registry (e.g., pvt-registry.io:5000/image-name) before pushing them.

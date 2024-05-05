# Private-Docker-Resgistry
This repository shows how to deploy and manage a private docker registry on premises 


Private Docker registries are a practical way of distributing resources and sharing Docker images between containers. Setting up a private registry speeds delivery and ensures smooth CI/CD development using the Docker platform.

Follow the steps to setup a registry:

# Install Docker: 
 If Docker is not already installed on your Linux system, you'll need to install it. The exact method varies depending on your Linux distribution, but Docker provides installation instructions for various distributions on their website.

https://docs.docker.com/engine/install/


# Create Docker Compose file:
  Create a docker compose file in your system. sample docker-compose.yml is given in repository
 https://github.com/ahsanaliq/private-docker-resgistry/blob/main/docker-compose.yml

# Set Up Authentication
Create a directory named auth in the same directory as your docker-compose.yml file. Inside the auth directory, create a file named htpasswd containing your desired username and password for authentication. You can generate the htpasswd file using tools like htpasswd or online generators

# Start Docker Registry

Run the following command in the directory containing your docker-compose.yml file to start the Docker registry and UI:

` docker-compose up -d `

# Access Docker Registry UI
Once the containers are running, you can access the Docker registry UI by visiting http://<Docker-host-IP>:8080 in your web browser. Log in using the username and password you set up in the htpasswd file.

# Push and Pull Images
You can now push Docker images to your private registry using the docker push command and pull images from it using the docker pull command. Make sure to tag your images with the address of your private registry (e.g., pvt-registry.io:5000/image-name) before pushing them.


# Optimizing Docker Registry Storage

Optimizing storage usage in your Docker registry is crucial, especially when dealing with daily builds and multiple tags for a single image. Over time, unused layers, known as abandoned or unused layers, can accumulate, leading to significant disk space consumption and potential storage issues.

Avoid tagging images solely as "latest." This practice, which often leads to referencing tags as 'latest' exclusively, results in numerous unused blobs over time. Consider numbering tags instead of relying solely on 'latest' to mitigate this issue. Otherwise, you may encounter situations where the current 'latest' tag does not utilize blobs from previous 'latest' tags, resulting in a buildup of unused blobs. It's not uncommon to find hundreds or thousands of such unused blobs within a "latest" image.

Utilize Docker's garbage collection command to perform cleanup in your registry. However, be aware that this command primarily targets blobs that aren't referenced by any manifest. Due to the existence of numerous tags for a single image, these blobs often remain untouched by garbage collection. Consequently, even if certain blobs are no longer in use, they persist in the registry's storage. In scenarios where an image has more than 100 tags, the disk usage associated with such images can exceed 20 GB.



To tidy up storage by removing unused tags, consider the following procedures:

# Eliminate tags that are no longer in use:
You can clean up all tags from an image except for the last five, which are typically retained for rollback purposes. To accomplish this, delete two directories from the repository location.

` rm -r <REGISTRY-HOME>/v2/repositories/${name}/_manifests/tags/${tag}/index/sha256/${hash} `

` rm -r <REGISTRY-HOME>/v2/repositories/${name}/_manifests/revisions/sha256/${hash} `

Please note that <REGISTRY-HOME> denotes the registry mount location, such as /var/lib/registry.


Cleaning up a large number of images with numerous tags can indeed be laborious when using APIs. Below scrip facilitates the cleanup of all tags except the last five from either the entire repository or a specific namespace:


# Run the optimize-storage-script.sh given in the repo.
https://github.com/ahsanaliq/private-docker-resgistry/blob/main/optimze-registry-storage.sh 

Once this command is executed, unused blobs will be available for garbage collection

# Garbage Collection

Run the following command to remove the unused blobs and  free up server storage.

` docker exec <Registry Container ID> bin/registry garbage-collect /etc/docker/registry/config.yml `


# Thank me later :) 

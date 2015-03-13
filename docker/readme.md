### Setup instructions

Build the image
> sudo docker build -t tenpines/html5-poc .

Start the container (first time)
> sudo docker run -d -p 9090:9090 --name html5 tenpines/html5-poc

List running containers
> sudo docker ps

Stop and remove the container
> sudo docker stop html5
> sudo docker rm html5

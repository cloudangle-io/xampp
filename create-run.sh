docker build -t 'xampp-image' .
docker stop `docker ps | grep xampp | awk '{print $1}'`
docker run -d -p 80:80 xampp-image

docker exec -it `docker ps | grep xampp | awk '{print $1}'` bash

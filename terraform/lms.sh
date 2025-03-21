# !/bin/bash
wget -O get-docker.sh https://get.docker.com && sh get-docker.sh
docker
systemctl status docker
sudo usermod -aG docker ubuntu
exec ssh ubuntu@remote-server
docker container run -dt --name lms-fe -p 80:80 pulipatitejashwini/lms-fe:${APP_VERSION}







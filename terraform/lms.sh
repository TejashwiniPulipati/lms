# !/bin/bash
sudo apt update -y
sudo apt install zip unzip -y
wget -O get-docker.sh https://get.docker.com && sh get-docker.sh
sudo docker container run -dt --name sonarqube --restart=always -p 9000:9000 sonarqube
sudo docker container run -dt --name nexus --restart=always -p 8081:8081 sonatype/nexus3
git clone -b terraform https://github.com/TejashwiniPulipati/lms.git
cd ~/lms/webapp
npm install
npm run build
ls dist
sudo apt install nginx -y
ls /var/www/html
cat /var/www/html/index.nginx-debian.html
sudo rm -rf /var/www/html/*
sudo mkdir -p /var/www/html/
ls /var/www/html
sudo cp -r ~/lms/webapp/dist/* /var/www/html


\





# !/bin/bash
sudo apt update -y
sudo apt install zip unzip -y
sudo apt install nginx -y
wget -O get-docker.sh https://get.docker.com && sh get-docker.sh
sudo docker container run -dt --name sonarqube --restart=always -p 9000:9000 sonarqube
sudo docker container run -dt --name nexus --restart=always -p 8081:8081 sonatype/nexus3
git clone -b terraform https://github.com/TejashwiniPulipati/lms.git
curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
sudo apt-get install -y nodejs
cd lms/webapp
npm install
npm run build
ls dist
sudo rm -rf /var/www/html/*
sudo mv dist/* /var/www/html







# !/bin/bash
wget -O get-docker.sh https://get.docker.com && sh get-docker.sh
sudo docker container run -dt --name sonarqube --restart=always -p 9000:9000 sonarqube
sudo docker container run -dt --name nexus --restart=always -p 8081:8081 sonatype/nexus3
cd ~/lms/webapp
npm install
npm run build
ls dist
sudo apt -y install nginx
sudo cp -r ~/lms/webapp/dist/* /var/www/html



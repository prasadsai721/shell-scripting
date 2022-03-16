#!/bin/bash

USER_ID=$(id -u)
if [ "$USER_ID" -ne 0 ]; then
  echo you should run the script as sudo or root user
  exit 1
  fi

echo -e"\e[36m installing nginx \e[0m"
yum install nginx -y

curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"

cd /usr/share/nginx/html
rm -rf
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

echo -e"\e[36m starting nginx \e[0m"

systemctl enable nginx
systemctl restart nginx


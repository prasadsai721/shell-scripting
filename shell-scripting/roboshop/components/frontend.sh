#!/bin/bash

USER_ID=$(id -u)
if [ "$USER_ID" -ne 0 ]; then
  echo you should run the script as sudo or root user
  exit 1
  fi

echo -e"\e[36m installing nginx \e[0m"
yum install nginx -y
if[ $? -eq 0 ]; then
 echo "\e[32msuccess\e[0m]"
else
 echo "\e[31mFAILURE\e[0m]"
exit 2
fi

echo -e"\e[36m Downloading nginx \e[0m"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
if[ $? -eq 0 ]; then
 echo "\e[32msuccess\e[0m]"
else
 echo "\e[31mFAILURE\e[0m]"
exit 2
fi

echo -e"\e[36m cleaningup old nginx contant and extract new download archive\e[0m"
cd /usr/share/nginx/html
rm -rf
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
if[ $? -eq 0 ]; then
 echo "\e[32msuccess\e[0m]"
else
 echo "\e[31mFAILURE\e[0m]"
exit 2
fi

echo -e"\e[36m starting nginx \e[0m"
systemctl enable nginx
systemctl restart nginx


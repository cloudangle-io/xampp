FROM  --platform=linux/amd64 ubuntu:20.04

RUN apt-get update
RUN apt-get install wget -y
RUN wget https://sourceforge.net/projects/xampp/files/XAMPP%20Linux/8.2.4/xampp-linux-x64-8.2.4-0-installer.run
RUN ls -al
RUN chmod +x ./xampp-linux-x64-8.2.4-0-installer.run
RUN ./xampp-linux-x64-8.2.4-0-installer.run

ENV db_username <<DB_USERNAME>>
ENV db_password <<DB_PASSWORD>>
ENV db_host <<DB_HOST>>

COPY config.inc.php /opt/lampp/phpmyadmin/config.inc.php
COPY php.ini /opt/lampp/etc/php.ini

COPY ./src/* /opt/lampp/htdocs/

COPY my_init /xampp
RUN chmod +x /xampp

ENTRYPOINT ["/xampp"]
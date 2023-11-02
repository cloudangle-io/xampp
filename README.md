# xampp



## Getting started

To use this repo in your project ensure you replace the following

- <<db_username>>
- <<db_password>>
- <<db_host>>

The above needs to be set in the Dockerfile and the script create-run can be used to test your changes in your local.

If you want to test with AWS RDS you can simply create a SSH tunnel to your RDS and modify the above to match it.

For instance if your RDS FQDN was yourserver.eu-west-2.rds.amazonaws.com and you have a jump box ec2 set up with key mykey.pem and your EC2 IP is 1.2.3.4, you can run the ssh runnel as follows:-

```
ssh -L 0.0.0.0:3306:yourserver.eu-west-2.rds.amazonaws.com:3306 -N -i ~/Downloads/mykey.pem ec2-user@1.2.3.4 &
```

Then you modify your Dockerfile to connect to your local IP on 3307. Assuming your local ip is 192.168.0.21

```
FROM  --platform=linux/amd64 ubuntu:20.04

RUN apt-get update
RUN apt-get install wget -y
RUN wget https://sourceforge.net/projects/xampp/files/XAMPP%20Linux/8.2.4/xampp-linux-x64-8.2.4-0-installer.run
RUN ls -al
RUN chmod +x ./xampp-linux-x64-8.2.4-0-installer.run
RUN ./xampp-linux-x64-8.2.4-0-installer.run

ENV db_username master
ENV db_password mypassword
ENV db_host 192.168.0.21

COPY config.inc.php /opt/lampp/phpmyadmin/config.inc.php
COPY php.ini /opt/lampp/etc/php.ini

COPY ./src/* /opt/lampp/htdocs/

COPY my_init /xampp
RUN chmod +x /xampp

ENTRYPOINT ["/xampp"]

```


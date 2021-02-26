# PHP-Nginx for docker to serve [Grav](https://getgrav.org/)

This is a small docker image which just provides a simple nginx server including php.  
It is specifically includes all php dependencies for [Grav](https://getgrav.org/).  

## Usage

Just see the example docker-compose.yml it basically shows everything you need:
* expose port 80
* mount your webpage to /usr/share/nginx
* optionally mount override to /override -> there you can inject different configurations without rebuilding the image
* set the environment variables for uid, gid

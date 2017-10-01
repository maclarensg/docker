#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
BLUE='\033[0;15m'
RESET='\033[0m'

# Check if /var/nginx is present

function check_nginx_shared_directory {
    if [ -d "/var/nginx" ]
    then
        echo -e "Found ${BLUE}'/var/nginx' ${RESET}... ${GREEN}ok'${RESET}"
    else
        echo -e "${RED}Error: ${RESET}No ${BLUE}'/var/nginx'${RESET}"
        exit
    fi
}
 
function check_nginx_www {
    if [ -d "/var/nginx/www" ]
    then
        echo -e "Found ${BLUE}'/var/nginx/www' ${RESET}... ${GREEN}ok${RESET}"
    else 
        echo -e "Creating ${BLUE}'/var/nginx/www'${RESET}"
        mkdir -p /var/nginx/www
    fi
}

function check_nginx_www_contents {
    if [ "$(ls -A /var/nginx/www)" ]
    then
        echo -e "${GREEN}Contents Exist ${RESET}... ${GREEN}ok${RESET}"
    else
        echo -e "${GREEN}Copy contents to ${BLUE}'/var/nginx/www'${RESET}"
        cp -vr /var/template/www/* /var/nginx/www/
        echo -e '${WHITE}Done${RESET}'
    fi
}






service ssh start

check_nginx_shared_directory
check_nginx_www
check_nginx_www_contents

nginx -g 'daemon off;'

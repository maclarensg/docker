#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
WHITE='\033[0;15m'
RESET='\033[0m'

# Check if /var/nginx is present

NGINX_DIR=/var/nginx
NGINX_WWW_DIR="${NGINX_DIR}/www"
NGINX_LOG_DIR="${NGINX_DIR}/log"
NGINX_CONF_DIR="${NGINX_DIR}/config"

function check_nginx_shared_directory {
    
    if [ -d $NGINX_DIR ]
    then
        echo -e "Found ${BLUE}'${NGINX_DIR}' ${RESET}... ${GREEN}ok'${RESET}"
    else
        echo -e "${RED}Error: ${RESET}No ${BLUE}'${NGINX_DIR}'${RESET}"
        exit
    fi
}
 
function check_nginx_www {
    if [ -d $NGINX_WWW_DIR ]
    then
        echo -e "Found ${BLUE}'${NGINX_WWW_DIR}' ${RESET}... ${GREEN}ok${RESET}"
    else 
        echo -e "Creating ${BLUE}'${NGINX_WWW_DIR}'${RESET}"
        mkdir -p $NGINX_WWW_DIR
    fi
}

function check_nginx_www_contents {
    if [ "$(ls -A $NGINX_WWW_DIR)" ]
    then
        echo -e "Contents Exist in ${BLUE}'${NGINX_WWW_DIR}' ${RESET}... ${GREEN}ok${RESET}"
    else
        echo -e "${GREEN}Copy contents to ${BLUE}'${NGINX_WWW_DIR}'${RESET}"
        cp -vr /var/template/www/* $NGINX_WWW_DIR
        echo -e "${WHITE}Done${RESET}"
    fi
}

function check_nginx_www_ownership {
    ownership=$(stat -c "%U:%G"  "$NGINX_WWW_DIR")
    wwwdata="www-data:www-data"
    if [ $ownership != $wwwdata ]; 
    then
        echo -e "Incorrect ownership ${BLUE}${ownership}${RESET}, setting to ${GREEN}${wwwdata}$RESET"
        chown -R www-data:www-data $NGINX_WWW_DIR
        echo -e '${WHITE}Done${RESET}'
    else
    echo -e "Correct ownership for ${BLUE}$NGINX_WWW_DIR${RESET}"
    fi 
}

function check_nginx_log_directory {
    if [ -d $NGINX_LOG_DIR ]
    then
        echo -e "Found ${BLUE}'${NGINX_LOG_DIR}' ${RESET}... ${GREEN}ok${RESET}"
    else
        echo -e "Creating ${BLUE}'${NGINX_LOG_DIR}'${RESET}"
        mkdir -p $NGINX_LOG_DIR
    fi   
}

function check_nginx_log_ownership {
    ownership=$(stat -c "%U:%G"  "$NGINX_LOG_DIR") 
    wwwdata="www-data:adm"
    if [ $ownership != $wwwdata ];
    then
        echo -e "Incorrect ownership ${BLUE}${ownership}${RESET}, setting to ${GREEN}${wwwdata}$RESET"
        chown -R www-data:adm $NGINX_LOG_DIR
        echo -e "${WHITE}Done${RESET}"
    else
    echo -e "Correct ownership for ${BLUE}$NGINX_LOG_DIR${RESET}"
    fi
}

function check_nginx_conf_directory {
    if [ -d $NGINX_CONF_DIR ]
    then
        echo -e "Found ${BLUE}'${NGINX_CONF_DIR}' ${RESET}... ${GREEN}ok${RESET}"
    else
        echo -e "Creating ${BLUE}'${NGINX_CONF_DIR}'${RESET}"
        mkdir -p $NGINX_CONF_DIR
    fi   
}
function check_nginx_conf_contents {
    if [ "$(ls -A $NGINX_CONF_DIR)" ]
    then
        echo -e "Contents Exist in ${BLUE}'${NGINX_CONF_DIR}' ${RESET}... ${GREEN}ok${RESET}"
    else
        echo -e "${GREEN}Copy contents to ${BLUE}'${NGINX_CONF_DIR}'${RESET}"
        cp -vr /var/template/config/* $NGINX_CONF_DIR
        echo -e "${WHITE}Done${RESET}"
    fi
}







service ssh start

# Nginx Precheck
check_nginx_shared_directory
check_nginx_www
check_nginx_www_contents
check_nginx_www_ownership
check_nginx_log_directory
check_nginx_log_ownership
check_nginx_conf_directory
check_nginx_conf_contents

nginx -c /var/nginx/confg/nginx.conf -g 'daemon off;'

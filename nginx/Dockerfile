FROM ubuntu:16.04

# Volume for shared nginx files
VOLUME ["/var/nginx/"]

# Update and Install packages
RUN apt-get update
RUN apt-get install -y openssh-server
RUN apt-get install -y vim
RUN apt-get install -y nginx

# SSH config
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Set System default root password
RUN echo 'root:iamroot' | chpasswd

# Docker run script for Mutliple services
COPY run.sh /usr/bin/
RUN chmod +x  /usr/bin/run.sh

# Nginx config

## Copy startup script for nginx
COPY nginx.init /etc/init.d/nginx
RUN chmod +x /etc/init.d/nginx 


# Copy and Extract templates
COPY template.tar.gz /var/
RUN tar xzvf /var/template.tar.gz -C /var

# Set Prompt
RUN echo "PS1='🐳  \[\033[1;36m\]\h \[\033[1;34m\]\W\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]'" >> /root/.bashrc

# Allow color terminal
ENV TERM xterm-256color

# Entry Point as run script
ENTRYPOINT ["/usr/bin/run.sh"]
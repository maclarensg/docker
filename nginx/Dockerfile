FROM ubuntu:16.04
VOLUME ["/var/nginx/"]
RUN apt-get update
RUN apt-get install -y openssh-server
RUN apt-get install -y vim
RUN apt-get install -y nginx
RUN mkdir /var/run/sshd
RUN echo 'root:iamroot' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
COPY run.sh /usr/bin/
COPY template.tar.gz /var/
RUN tar xzvf /var/template.tar.gz -C /var
RUN chmod +x  /usr/bin/run.sh
RUN echo "PS1='🐳  \[\033[1;36m\]\h \[\033[1;34m\]\W\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]'" >> /root/.bashrc

ENV TERM xterm-256color

ENTRYPOINT ["/usr/bin/run.sh"]
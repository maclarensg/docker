FROM ubuntu:16.04
RUN apt-get update
RUN apt-get install -y openssh-server
RUN apt-get install -y vim
RUN apt-get install -y libnet-ifconfig-wrapper-perl
RUN apt-get install -y openvpn

RUN mkdir /var/run/sshd
RUN echo 'root:iamroot' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile


COPY run.sh /usr/bin/
RUN chmod +x  /usr/bin/run.sh

COPY OpenVPN /root/OpenVPN
COPY .ssh   /root/.ssh

EXPOSE 22
CMD ["/usr/bin/run.sh", "-D"]


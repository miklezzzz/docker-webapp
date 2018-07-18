# Version: 0.1
FROM ubuntu:16.04
MAINTAINER Mike <miklezzzz@mail.ru>
RUN useradd -ms /bin/bash $USERNAME
RUN mkdir -p /home/$USERNAME/.ssh
RUN echo "$SSHPUBKEY $USERNAME@$REMOTEHOST" > /home/$USERNAME/.ssh/authorized_keys
RUN chown -R $USERNAME:$USERNAME /home/$USERNAME
RUN chmod 700 /home/$USERNAME/.ssh/authorized_keys
RUN apt-get update
RUN apt-get install -y openssh-server bash sudo
RUN echo '$USERNAME     ALL=(ALL)       NOPASSWD:ALL' >> /etc/sudoers
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN mkdir /var/run/sshd
RUN sed -i 's/exit 0//g' /etc/rc.local
EXPOSE 22 80
#CMD ["/etc/rc.local","/usr/sbin/sshd", "-D"]
CMD /etc/rc.local && /usr/sbin/sshd -D

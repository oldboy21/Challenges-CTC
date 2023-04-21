FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -q -y rsyslog tcpdump isc-dhcp-client isc-dhcp-server nano util-linux iputils-ping curl openssh-server sudo net-tools python3-pip
RUN pip3 install dnslib
RUN curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest/salt-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg] https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest focal main" | tee /etc/apt/sources.list.d/salt.list
RUN useradd -rm -d /home/ctc -s /bin/bash -g root -G sudo -u 1000 ctc
RUN echo 'ctc:ctc' | chpasswd
COPY data-breach-notes.txt /home/ctc/
RUN apt-get update && apt-get install -y salt-master
RUN service ssh start 
EXPOSE 22 
CMD ["/usr/sbin/sshd","-D"]

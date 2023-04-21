FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -q -y rsyslog tcpdump nano util-linux iputils-ping curl openssh-server sudo net-tools python3-pip
RUN apt-get install -y default-jre openjdk-11-jre-headless openjdk-11-jdk maven zip
RUN useradd -rm -d /home/ctc -s /bin/bash -u 1000 ctc
RUN echo "ctc ALL=NOPASSWD:/usr/bin/bash /home/ctc/run-tests.sh" > /etc/sudoers.d/ctc
RUN echo 'ctc:ctc' | chpasswd
ADD run-tests.sh /home/ctc/
ADD README.txt /home/ctc/
RUN chmod 700 /home/ctc/run-tests.sh
RUN groupadd pcap && usermod -a -G pcap ctc && chgrp pcap /usr/sbin/tcpdump && setcap cap_net_raw,cap_net_admin=eip /usr/sbin/tcpdump && ln -s /usr/sbin/tcpdump /usr/bin/tcpdump
RUN service ssh start 
EXPOSE 22 
CMD ["/usr/sbin/sshd","-D"]

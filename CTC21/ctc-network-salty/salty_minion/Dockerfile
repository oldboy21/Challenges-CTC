FROM ubuntu:20.04
ENV DEBIAN_FRONTEND='noninteractive' 
RUN apt-get -y update 
RUN apt-get install -y tcpdump isc-dhcp-client isc-dhcp-server nano iputils-ping supervisor curl
RUN curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest/salt-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg] https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest focal main" | tee /etc/apt/sources.list.d/salt.list
RUN apt-get update
RUN apt-get install -y salt-minion
COPY dhcp-parse.sh /home/
COPY automatic-dhcpclient.sh /home/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN useradd -rm -d /home/salty -s /bin/bash -u 1001 salty
RUN echo 'salty:salty' | chpasswd
RUN chown -R salty /etc/salt /var/cache/salt /var/log/salt /run
RUN sed -i 's/#master: salt/master: mayflower.gang/g' /etc/salt/minion
COPY flag.txt /home/salty/
ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/conf.d/supervisord.conf"]

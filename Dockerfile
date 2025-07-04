FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y 
wget curl unzip sudo net-tools xrdp xfce4 xfce4-goodies 
wine64 winetricks xterm firefox && 
apt clean

RUN useradd -m forex && echo "forex:forex" | chpasswd && adduser forex sudo

RUN echo "xfce4-session" > /home/forex/.xsession && 
chown forex:forex /home/forex/.xsession

RUN mkdir -p /home/forex/mt4 && 
mkdir -p /home/forex/mt4/experts && 
chown -R forex:forex /home/forex/mt4

EXPOSE 3389

CMD ["/usr/sbin/xrdp", "-n"]


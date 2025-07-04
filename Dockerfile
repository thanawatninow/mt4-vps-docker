FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive


RUN apt update && apt install -y \
    curl tar unzip sudo net-tools xrdp xfce4 xfce4-goodies \
    wine64 winetricks xterm firefox && \
    apt clean


RUN useradd -m forex && echo "forex:forex" | chpasswd && adduser forex sudo


RUN echo "xfce4-session" > /home/forex/.xsession && \
    chown forex:forex /home/forex/.xsession


COPY tools/ngrok-v3.tgz /tmp/ngrok-v3.tgz
RUN tar -xvzf /tmp/ngrok-v3.tgz -C /usr/local/bin && chmod +x /usr/local/bin/ngrok


ENV NGROK_AUTH_TOKEN=2zQ0HkrzRDZkO1TUOgwRBlNjPVv_745AJuP3sAVAw1M2XQEGo


EXPOSE 3389

CMD ngrok authtoken $NGROK_AUTH_TOKEN && \
    ngrok tcp 3389 & \
    /usr/sbin/xrdp -n

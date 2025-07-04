FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

ติดตั้งแพ็กเกจพื้นฐานและ XRDP + Wine 

RUN apt update && apt install -y 
wget curl unzip sudo net-tools xrdp xfce4 xfce4-goodies 
wine64 winetricks xterm firefox && 
apt clean

สร้าง user forex 

RUN useradd -m forex && echo "forex:forex" | chpasswd && adduser forex sudo

ตั้งค่า XRDP 

RUN echo "xfce4-session" > /home/forex/.xsession && 
chown forex:forex /home/forex/.xsession

สร้างไดเรกทอรีสำหรับไฟล์ติดตั้ง MT4 และ EA 

RUN mkdir -p /home/forex/mt4 && 
mkdir -p /home/forex/mt4/experts && 
chown -R forex:forex /home/forex/mt4

เปิดพอร์ต XRDP 

EXPOSE 3389

เริ่ม XRDP service 

CMD ["/usr/sbin/xrdp", "-n"]


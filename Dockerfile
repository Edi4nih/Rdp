# Gunakan image dasar CentOS
FROM centos:7

# Install dependencies
RUN yum install -y unzip wget sudo qemu-kvm curl npm

# Install LocalTunnel secara global
RUN npm install -g localtunnel

# Unduh file QCOW2 dan jalankan QEMU
RUN wget -O lite11.qcow2 https://app.vagrantup.com/thuonghai2711/boxes/WindowsQCOW2/versions/1.0.2/providers/qemu.box \
    || wget -O lite11.qcow2 https://transfer.sh/1XQtaoZ/lite11.qcow2

# Script untuk menjalankan QEMU dan LocalTunnel
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Start script
CMD ["/bin/bash", "/run.sh"]

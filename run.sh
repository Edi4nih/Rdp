#!/bin/bash

# Hitung RAM yang tersedia dan tentukan parameter QEMU
availableRAM=$(free -m | tail -2 | head -1 | awk '{print $7}')
custom_param_ram="-m "$(expr $availableRAM - 856 )"M"
cpus=$(lscpu | grep CPU\(s\) | head -1 | cut -f2 -d":" | awk '{$1=$1;print}')

# Jalankan QEMU dengan konfigurasi yang disesuaikan
nohup /usr/libexec/qemu-kvm -nographic -net nic -net user,hostfwd=tcp::30889-:3389 -show-cursor $custom_param_ram -localtime -enable-kvm -cpu host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time,+nx -M pc -smp cores=$cpus -vga std -machine type=pc,accel=kvm -usb -device usb-tablet -k en-us -drive file=lite11.qcow2,index=0,media=disk,format=qcow2 -boot once=d &>/dev/null &

# Tunggu beberapa saat untuk memastikan QEMU berjalan
sleep 10

# Jalankan LocalTunnel
lt --port 30889 --subdomain windows11rdp &>/dev/null &

# Tampilkan informasi koneksi
clear
echo "Windows 11 RDP by TechZilla LK"
echo Your RDP IP Address:
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
echo User: Administrator
echo Password: Thuonghai001
echo Script by t.me/infje
echo Wait 2-4m VM boot up before connect. 
echo Do not close Katacoda tab. VM expired in 1 hour.

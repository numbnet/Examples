
# ReBuild Centos7 with KS.cfg

##=============================
##
PROJECTDIR=/home/Project/Centos7KS
ISODIR=/mnt/iso
WORKDIR=/home/Project/Centos7KS/centos
DOWNDIR=/home/Download/centos/7.8.2003/isos/x86_64/
CENTOSMIN="CentOS-7-x86_64-Minimal-2003.iso"
WEBCENTOSMIN="http://mirror.mirohost.net/centos/7.8.2003/isos/x86_64/CentOS-7-x86_64-Minimal-2003.iso"


##=============================
yum install wget nano mkisofs -y


##====================
mkdir -p /home/Download/centos/7.8.2003/isos/x86_64/
cd /home/Download/centos/7.8.2003/isos/x86_64/
wget http://mirror.mirohost.net/centos/7.8.2003/isos/x86_64/CentOS-7-x86_64-Minimal-2003.iso
sleep 5

mkdir -p /mnt/iso
mount /home/Download/centos/7.8.2003/isos/x86_64/CentOS-7-x86_64-Minimal-2003.iso /mnt/iso/

sleep 5

mkdir -p /home/Project/Centos7KS/centos
cp -rp /mnt/iso/* /home/Project/Centos7KS/centos/

##=============================
touch /home/Project/Centos7KS/minimal.ks.cfg
KONF_KS=/home/Project/Centos7KS/minimal.ks.cfg

cat > $KONF_KS <<-EOF
###
EOF

##=============================

#cat ~/minimal.ks.cfg > /home/Project/Centos7KS/centos/ks.cfg


##=============================
## isolinux
##
touch /home/Project/Centos7KS/isolinux.cfg
KONF_ISOLINUX=/home/Project/Centos7KS/isolinux.cfg

cat > $KONF_ISOLINUX <<-EOF

label auto
menu label ^Auto install CentOS 7
kernel vmlinuz
append  initrd=initrd.img inst.ks=cdrom:/dev/cdrom:/ks.cfg

label autolan
menu label ^Lan Auto install CentOS7
kernel vmlinuz
append initrd=initrd.img inst.ks=http://192.168.1.15/ks.cfg

EOF

##=============================

#cat ~/minimal.ks.cfg > /home/Project/Centos7KS/centos/ks.cfg


#cp /home/Project/Centos7KS/centos/isolinux/isolinux.cfg /home/Project/Centos7KS/isolinux.cfg
#nano /home/isolinux.cfg

# cp /home/Project/Centos7KS/isolinux.cfg /home/Project/Centos7KS/centos/isolinux/isolinux.cfg


##===============================
# создаем образ CentOS 7 x86_64
cd /home/Project/Centos7KS/centos/
# mkisofs -o /home/centos-cust.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -V 'OEMDRV' -boot-load-size 4 -boot-info-table -R -J -v -T .


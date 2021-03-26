#!/bin/bash



##======================================
## Var
DATA="$(date +%Y%m%d-%k%M%S)";

##======================================
##
yum update
yum install vsftpd
tar czvf /etc/vsftpd.$DATA.tar.gz /etc/vsftpd
ls /etc/
rm -rf /etc/vsftpd/*

##======================================
ServCONFIG='/etc/vsftpd/vsftpd.conf'
cat> $ServCONFIG <<EOF
# Запуск сервера в режиме службы
listen=YES

# Работа в фоновом режиме
background=YES

# Имя pam сервиса для vsftpd
pam_service_name=vsftpd

# Входящие соединения контроллируются через tcp_wrappers
tcp_wrappers=YES

# Запрещает подключение анонимных пользователей
anonymous_enable=NO

# Каталог, куда будут попадать анонимные пользователи, если они разрешены
#anon_root=/ftp

# Разрешает вход для локальных пользователей
local_enable=YES

# Разрешены команды на запись и изменение
write_enable=YES

# Указывает исходящим с сервера соединениям использовать 20-й порт
connect_from_port_20=YES

# Логирование всех действий на сервере
xferlog_enable=YES

# Путь к лог-файлу
xferlog_file=/var/log/vsftpd.log

# Включение специальных ftp команд, некоторые клиенты без этого могут зависать
async_abor_enable=YES

# Локальные пользователи по-умолчанию не могут выходить за пределы своего домашнего каталога
chroot_local_user=YES

# Разрешить список пользователей, которые могут выходить за пределы домашнего каталога
chroot_list_enable=YES

# Список пользователей, которым разрешен выход из домашнего каталога
chroot_list_file=/etc/vsftpd/chroot_list

# Разрешить запись в корень chroot каталога пользователя
allow_writeable_chroot=YES

# Контроль доступа к серверу через отдельный список пользователей
userlist_enable=YES

# Файл со списками разрешенных к подключению пользователей
userlist_file=/etc/vsftpd/user_list

# Пользователь будет отклонен, если его нет в user_list
userlist_deny=NO

# Директория с настройками пользователей
user_config_dir=/etc/vsftpd/users

# Показывать файлы, начинающиеся с точки
force_dot_files=YES

# Маска прав доступа к создаваемым файлам
local_umask=022

# Порты для пассивного режима работы
pasv_min_port=49000
pasv_max_port=55000
EOF
##====================================================
cat $ServCONFIG


tar -czvf /etc/pam.d/vsftpd.$DATA.tar.gz /etc/pam.d/vsftpd;
ls /etc/pam.d/

## Исключаем то что ищем и выводим то что не надо
OBOLSHE='/etc/pam.d/vsftpd'
sed -i '/pam_shells.so/s/auth/# auth/g' $OBOLSHE;

## !АЛЬТЕРНАТИВА! Исключаем то что ищем и выводим то что не надо
# echo "$( echo "$(grep -vi 'pam_shells.so' $OBOLSHE)"; echo "$(echo '# ')$(grep -i 'pam_shells.so' $OBOLSHE)" )" > $OBOLSHE


##==========================================
useradd -s /sbin/nologin ftpuser
passwd ftpuser

mkdir /etc/vsftpd/users;
touch /etc/vsftpd/users/ftpuser;
echo 'local_root=/ftp/ftpuser/' >> /etc/vsftpd/users/ftpuser;
mkdir /ftp && chmod 0777 /ftp;
mkdir /ftp/ftpuser && chown ftpuser. /ftp/ftpuser/;
 touch /etc/vsftpd/chroot_list;
echo 'root' >> /etc/vsftpd/chroot_list;
 touch /etc/vsftpd/user_list;
 echo 'root' >> /etc/vsftpd/user_list && echo 'ftpuser' >> /etc/vsftpd/user_list;
 touch /var/log/vsftpd.log && chmod 600 /var/log/vsftpd.log;

systemctl status vsftpd
systemctl enable vsftpd
systemctl start vsftpd
systemctl status vsftpd

##==========================================


netstat -tulnp | grep vsftpd

exit;






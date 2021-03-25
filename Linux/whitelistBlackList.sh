#!/bin/sh

# Скрипты добавления доменов в белый и черный списки spamassassin

# Скрипт добавления доменов из писем, перенаправленных в ham@example.com, в файл белых список адресов

cat /home/whitelist.sh <<EOF
#!/bin/sh
temp=/etc/mail/spamassassin/temp_whitelist.txt
result=/etc/mail/spamassassin/whitelist.cf
catalog=/var/vmail/example.com/ham/new/

if [ `ls $catalog | wc -l` -eq 0 ]
then
    echo "Emty"
else

    for file in /var/vmail/example.com/ham/new/*
	do
	#	echo $file
	#    Вывод строки, содержащей "In-Reply.." | Оставить только e-mail                               | Убрать символы до @    | исключить          | Добавить символы перед @            >>   сохранить в файл
	    grep "In-Reply-To: " $file | grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b" | awk -F'@' '{print $2}' | grep -v example.com | awk '{print "whitelist_from *@"$0}' >> $result
    done
    mv $result $temp
    awk '!($0 in a) {a[$0];print}' $temp > $result

fi

EOF


#Принцип действия:
#Вначале задаются переменные

#- temp - временный файл
#- result - конечный файл
#- catalog - путь к каталогу с письмами почтового ящика
# Далее идет проверка

if [ `ls $catalog | wc -l` -eq 0 ]

#Если новых писем нет, скрипт заканчивает работу. Если есть, выполняется цикл.

# Вывод строки, содержащей "In-Reply.."
grep "In-Reply-To: " $file

# Оставить только e-mail
grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b"

# Убрать символы до @
awk -F'@' '{print $2}'

# Исключить example.com
grep -v example.com

# Добавить символы перед @ и сохранить в результирующий файл
awk '{print "whitelist_from *@"$0}' >> $result


##==========================================================
##
#Аналогично, скрипт добавления доменов из писем, перенаправленных в
# spam@example.com, в файл черных список адресов:

cat /home/blacklist.sh <<EOF
#!/bin/sh
temp=/etc/mail/spamassassin/temp_blacklist.txt
result=/etc/mail/spamassassin/blacklist.cf
catalog=/var/vmail/example.com/spam/new/

if [ `ls $catalog | wc -l` -eq 0 ]
then
    echo "Emty"
else

    for file in /var/vmail/example.com/spam/new/*
	do
	#	echo $file
	#    Вывод строки, содержащей "In-Reply.." | Оставить только e-mail                               | Убрать символы до @    | исключить          | Добавить символы перед @            >>   сохранить в файл
	    grep "In-Reply-To: " $file | grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b" | awk -F'@' '{print $2}' | grep -v example.com | awk '{print "blacklist_from *@"$0}' >> $result
    done
    mv $result $temp
    awk '!($0 in a) {a[$0];print}' $temp > $result

fi
EOF

#Делаем файлы исполняемыми
chmod +x /home/whitelist.sh
chmod +x /home/blacklist.sh

#Добавляем в crontab задание

# cat /var/spool/cron/root
# обучение spamassassin раз в 60 минут
*/60 * * * * /usr/bin/sa-learn --spam /var/vmail/example.com/spam/new/
*/60 * * * * /usr/bin/sa-learn --ham /var/vmail/example.com/ham/new/
# запуск скриптов сбора доменов в 0:10 и 0:11
10 0 * * * /home/whitelist.sh
11 0 * * * /home/blacklist.sh
# очистка ящиков в 0:15 и 0:17
15 0 * * * /bin/rm -rf /var/vmail/example.com/spam/new/*
17 0 * * * /bin/rm -rf /var/vmail/example.com/ham/new/*
# перезапуск сервиса spamassassin
19 0 * * * service spamassassin restart




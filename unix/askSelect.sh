#!/bin/bash

ver="v1.0.0"
title="ask-"
title_full="$title $ver"
NAMEFILE=askSelect.sh



##============ ≠≠≠ ============
#типовые функции
##============ ≠≠≠ ============


##============ ≠≠≠ ============
#для рабты с цветами
normal="\033[0m"
green="\033[32m"
red="\033[1;31m"
blue="\033[1;34m"
black="\033[40m"
textcolor=$green
bgcolor=$black

## Color
color() {
case "$1" in
  normal|default)
    sed -i -e 's/^textcolor=.*/textcolor=$normal/' -e 's/^bgcolor=.*/bgcolor=$normal/' $NAMEFILE	#меняем переменную в самом скрипте
    textcolor=$normal #меняем переменную в текущей сессии
    bgcolor=$normal #меняем переменную в текущей сессии
    chosen=0 #выходим из терминала в главное меню
  ;;
  green)
    sed -i -e 's/^textcolor=.*/textcolor=$green/' -e 's/^bgcolor=.*/bgcolor=$black/' $NAMEFILE		#меняем переменную в самом скрипте
    textcolor=$green		#меняем переменную в текущей сессии
    bgcolor=$black			#меняем переменную в текущей сессии
    chosen=0				#выходим из терминала в главное меню
  ;;
  blue)
    sed -i -e 's/^textcolor=.*/textcolor=$blue/' -e 's/^bgcolor=.*/bgcolor=$black/' $NAMEFILE		#меняем переменную в самом скрипте
    textcolor=$blue			#меняем переменную в текущей сессии
    bgcolor=$black			#меняем переменную в текущей сессии
    chosen=0				#выходим из терминала в главное меню
  ;;
  red)
    sed -i -e 's/^textcolor=.*/textcolor=$red/' -e 's/^bgcolor=.*/bgcolor=$black/' $NAMEFILE		#меняем переменную в самом скрипте
    textcolor=$red			#меняем переменную в текущей сессии
    bgcolor=$black			#меняем переменную в текущей сессии
    chosen=0				#выходим из терминала в главное меню
  ;;
  *)echo "цвет указан неверно. Поддерживается только green, blue, red и default/normal"
  ;;
esac
}

my_clear() { echo -e "$textcolor$bgcolor";clear;}

#функция, которая запрашивает только один символ
myread() { temp=""; while [ -z "$temp" ] #защита от пустых значений
do
read -n 1 temp
done
eval $1=$temp
echo
}

#функция, которая запрашивает только да или нет
myread_yn() {
temp=""
while [[ "$temp" != "y" && "$temp" != "Y" && "$temp" != "n" && "$temp" != "N" ]]		#запрашиваем значение, пока не будет "y" или "n"
do
echo -n "y/n: "
read -n 1 temp
echo
done
eval $1=$temp
}

#функция, которая запрашивает только цифру
myread_dig() {
temp=""
counter=0
while [[ "$temp" != "0" && "$temp" != "1" && "$temp" != "2" && "$temp" != "3" && "$temp" != "4" && "$temp" != "5" && "$temp" != "6" && "$temp" != "7" && "$temp" != "8" && "$temp" != "9" ]] #запрашиваем значение, пока не будет цифра
do
if [ $counter -ne 0 ]; then echo -n "Неправильный выбор. Ведите цифру: "; fi
let "counter=$counter+1"
read -n 1 temp
echo
done
eval $1=$temp
}


##============ ≠≠≠ ============
#функция установки с проверкой не установлен ли уже пакет
myinstall() {
if [ -z `rpm -qa $1` ]; then
	yum -y install $1
else
	echo "Пакет $1 уже установлен"
	br
fi
}

title()        { my_clear;echo "$title"; }
menu()         { my_clear;echo "$menu";echo "Выберите Select меню:"; }
wait()         { echo "Нажмите любую клавишу, чтобы продолжить..."; read -s -n 1; }
br()           { echo ""; }
updatescript() { wget $updpath/$filename -r -N -nd --no-check-certificate; chmod 777 $filename; }


##============ ≠≠≠ ============
## Функция проверки установленного приложения, exist возвращает true если установлена и false, если нет.
installed() {
	if [ "$2" == "force" ]; then exist=`rpm -qa $1`		#добавили возможности форсированно использовать длинный вариант проверки
	else												#если нет ключа force, используем старый двойной вариант
		exist=`whereis $1 | awk {'print $2'}`			#вариант быстрый, но не всегда эффективный
		if [ -z $exist ]
			then										#будем использовать оба варианта
			exist=`rpm -qa $1`							#вариант медленнее, но эффективнее
		fi
	fi

	if [ -n "$exist" ]
	then
		exist=true
	else
		exist=false
	fi
}




menu="

●  $title $ver$space
├───┬─────────────────────────────────────────┐
│ 1 │ Select 1                                │
├───┼─────────────────────────────────────────┤
│ 2 │ Select 2                                │
├───┼─────────────────────────────────────────┤
│ 3 │ Select 3                                │
├───┼─────────────────────────────────────────┤
│ 4 │ Select 4                                │
├───┼─────────────────────────────────────────┤
│ 5 │ Select 5                                │
├───┼─────────────────────────────────────────┤
│ 6 │ Select 6                                │
├───┼─────────────────────────────────────────┤
│ 7 │ Select 7                                │
├───┼─────────────────────────────────────────┤
│ 8 │ Select 8                                │
├───┼─────────────────────────────────────────┤
│ 9 │ Select 9                                │
├───┼─────────────────────────────────────────┤
│ 0 │ Выход                                   │
└───┴─────────────────────────────────────────┘
"

menu1="
● Основное меню :
│
└─● выбран Select "$pick":
  │
  │ ┌───┬────────────────────────┐
  ├─┤ 1 │ SubSelect 1            │
  │ ├───┼────────────────────────┤
  ├─┤ 2 │ SubSelect 2            │
  │ ├───┼────────────────────────┤
  ├─┤ 3 │ SubSelect 3            │
  │ ├───┼────────────────────────┤
  ├─┤ 4 │ SubSelect 4            │
  │ ├───┼────────────────────────┤
  ├─┤ 5 │ SubSelect 5            │
  │ ├───┼────────────────────────┤
  ├─┤ 6 │ SubSelect 6            │
  │ ├───┼────────────────────────┤
  ├─┤ 7 │ SubSelect 7            │
  │ ├───┼────────────────────────┤
  ├─┤ 8 │ SubSelect 8            │
  │ ├───┼────────────────────────┤
  ├─┤ 9 │ SubSelect 9            │
  │ ├───┼────────────────────────┤
  └─┤ 0 │ НА УРОВЕНЬ ВВЕРХ       │
    └───┴────────────────────────┘
"

##============ ≠≠≠ ============
## Интерфейс
##============ ≠≠≠ ============

repeat=true
chosen=0
chosen2=0
while [ "$repeat" = "true" ] #выводим меню, пока не надо выйти
do

##============ ≠≠≠ ============
## пошёл вывод
if [ $chosen -eq 0 ]; then #выводим меню, только если ещё никуда не заходили
	menu
	myread_dig pick
else
	pick=$chosen
fi
case "$pick" in
	1) echo "Select $pick ===="
	chosen=1
	my_clear
	echo "$title"
	echo "$menu1"
	myread_dig pick
		case "$pick" in
		1|2|3|4|5|6|7|8|9)echo "Select $pick";br;wait;;
		0)chosen=0;;
		*)echo "Неправильный выбор";wait;;
		esac
	;;
	2) echo "Select $pick ===="
	chosen=2
	my_clear
	if [ $chosen2 -eq 0 ]; then #выводим меню, только если ещё никуда не заходили
	echo "$title"
	echo "$menu1"
	myread_dig pick
	else
	pick=$chosen2
	fi
		case "$pick" in
		1|2|3|4|5|6|7|8|9)echo "Select $pick";br;wait;;
		0)chosen=0;;
		*)echo "Неправильный выбор";wait;;
		esac
	;;
	3) echo "Select $pick ===="
	chosen=3
	my_clear
	echo "$title"
	echo "$menu1"
	myread_dig pick
		case "$pick" in
		1|2|3|4|5|6|7|8|9)echo "Selectect $pick";br;wait;;
		0)chosen=0;;
		*)echo "Неправильный выбор";wait;;
		esac
	;;
	4) echo "Select $pick ===="
	chosen=4
	my_clear
	echo "$title"
	echo "$menu1"
	myread_dig pick
		case "$pick" in
		1|2|3|4|5|6|7|8|9)echo "Select $pick";br;wait;;
		0)chosen=0;;
		*)echo "Неправильный выбор";wait;;
		esac
	;;
	5) echo "Select $pick ===="
	chosen=5
	my_clear
	echo "$title"
	echo "$menu1"
	myread_dig pick
		case "$pick" in
		1|2|3|4|5|6|7|8|9)echo "Select $pick";br;wait;;
		0)chosen=0;;
		*)echo "Неправильный выбор";wait;;
		esac
	;;
	6) echo "Select $pick ===="
	chosen=6
	my_clear
	echo "$title"
	echo "$menu1"
	myread_dig pick
		case "$pick" in
		1|2|3|4|5|6|7|8|9)echo "Select $pick";br;wait;;
		0)chosen=0;;
		*)echo "Неправильный выбор";wait;;
		esac
	;;
	7) echo "Select $pick ===="
	chosen=7
	my_clear
	echo "$title"
	echo "$menu1"
	myread_dig pick
		case "$pick" in
		1|2|3|4|5|6|7|8|9)echo "Select $pick";br;wait;;
		0)chosen=0;;
		*)echo "Неправильный выбор";wait;;
		esac
	;;
	8) echo "Select $pick ===="
	chosen=8
	my_clear
	echo "$title"
	echo "$menu1"
	myread_dig pick
		case "$pick" in
		1|2|3|4|5|6|7|8|9)echo "Select $pick";br;wait;;
		0)chosen=0;;
		*)echo "Неправильный выбор";wait;;
		esac
	;;
	9) echo "Select $pick ===="
	chosen=9
	my_clear
	echo "$title"
	echo "$menu1"
	myread_dig pick
		case "$pick" in
		1|2|3|4|5|6|7|8|9)echo "Select $pick";br;wait;;
		0)chosen=0;;
		*)echo "Неправильный выбор";wait;;
		esac
	;;
	0)
	repeat=false
	;;
	*)
	echo "Неправильный выбор."
	wait
	;;
	esac
done
echo "Скрипт ожидаемо завершил свою работу."
echo -e "$normal"
clear
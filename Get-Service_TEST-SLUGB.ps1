
###### Get-Service: проверка состояния служб Windows в PowerShell #####

## Данная команда выведет список всех служб и их статус (запущена или остановлена) и отображаемое имя (Display Name).
Get-Service

## Если вам нужно вывести только запушенные службы, воспользуемся такой командой:

Get-Service | Where-Object {$_.Status -EQ "Running"}

## Получить все свойства объекта службы можно с помощью командлета Get-Member.

get-service | get-member


## Чтобы вывести определенные свойства службы, нужно воспользоваться возможностями выбора свойств объектов с помощью командлета Select. Например, нам нужно вывести имя, статус и доступные возможности службы Windows Update:

get-service wuauserv | select Displayname,Status,ServiceName,Can*

DisplayName : Windows Update






# Удаление предустановленных UWP (APPX) приложений в Windows 10

### Windows 10 поставляется с набором предустановленных современных (Modern) UWP приложений (ранее они назывались Metro Apps или APPX). Это Калькулятор, Календарь, Почта, Кортана, Карты, Новости, OneNote, Groove Music Камера и т.д. UWP приложения Windows 10 автоматически в профиль пользователя устанавливаются при первом входе в систему. Большинстве из этих приложения не нужны бизнес пользователям, поэтому их обычно требуют удалить. В этой статье мы рассмотрим, как правильно удалить встроенные UWP/APPX приложения в Windows 10, что позволит сохранить дополнительное место на системном диске и уберет ненужные элементы в стартовом меню.

## Содержание:
## Удаление UWP приложений из меню Параметры Windows 10
## Как удалить определенное UWP приложение в Windows 10 из PoweShell?
## Удаляем сразу все ненужные UWP приложения в Windows 10
## Удаление UWP приложений из меню Параметры Windows 10
## Самый очевидный способ удалить современное приложение в Windows 10 – воспользоваться новой панелью управления Параметры. Для этого нажмите кнопку Пуск и перейдите в раздел Settings -> Apps -> Apps and features (Параметры -> Приложения -> Приложения и возможности). В списке программ найдите и выберите приложение, которое нужно удалить. Нажмите кнопку Uninstall (Удалить). Таким образом вы удалили UWP приложение только в профиле текущего пользователя. При входе любого другого нового пользователя, appx приложение автоматически установится из системного хранилища. Кроме того, обратите внимание, что у большинства предустановленных современных приложений просто недоступна кнопка Uninstall.




##===============================
## Удалить такие системные приложения Windows 10 можно только с помощью командной строки Powershell.
### Рассмотрим, как удалить конкретное UWP приложение в Windows 10 с помощью PowerShell. Обратите внимание, что в Windows 10 есть два типа приложений:
## AppX packages – UWP приложения, которые установлены для текущего пользователя Windows 10. AppX provisioned packages — встроенные Windows 10 приложения, которые устанавливаются при первом входе пользователя в систему

##===============================
## выведет список современных приложений, установленных для аккаунта:
Get-AppxPackage | select Name,PackageFullName,NonRemovable

##===============================
## Вивод список установленных приложений для всех пользователей. В этом случае команда будет выглядеть так:
Get-AppxPackage -AllUsers | select Name,PackageFullName,NonRemovable

### Совет. Результаты команды можно перенаправить в текстовый файл для более удобного просмотра и поиска требуемого имени пакета:
### Get-AppxPackage –AllUsers>c:\ps\windows10apps.txt


##===============================
### Чтобы найти приложение по имени, используйте такую команду (в этом примере мы ищем приложение BingWeather):
### Get-AppxPackage -AllUsers | select Name,PackageFullName,NonRemovable | where-object {$_.Name -like "*Weather*"} | Format-Table


##===============================
### Для удаления конкретного appx приложения для текущего пользователя, вам нужно скопировать название пакета из столбца PackageFullName (полное имя пакета) и вставить его в команду Remove-AppxPackage:
### Remove-AppxPackage Microsoft.BingWeather_4.25.20211.0_x64__8wekyb3d8bbwe
### Команда удалила приложение только для текущего пользователя. 



##===============================
### удалить приложение у всех пользователей компьютера, используйте параметр –AllUsers:
### Remove-AppxPackage -AllUsers Microsoft.BingWeather_4.25.20211.0_x64__8wekyb3d8bbwe
### Get-AppxPackage * BingWeather * -AllUsers| Remove-AppPackage –AllUsers



##===============================
### Если нужно удалить приложение у другого пользователя системы, нужно воспользоваться параметром -User <user_name>.
### При таком удалении приложения оно все еще остается в системе в состоянии Staged (и хранится на диске в каталоге C:\Program Files\WindowsApps). Состояние Staged, означает, что приложение будет устанавливаться для каждой новой учетной записи на этом компьютере.



##===============================

echo "список Staged приложений, которые встроены в образ Windows и автоматически устанавливаются всем пользователям при первом входе на компьютер:"
Get-AppxProvisionedPackage -online |select DisplayName,PackageName



##===============================
### полностью удалить определенное UWP приложение из образа Windows 10, нужно указать его имя в команде Remove-AppxProvisionedPackage:

### Get-AppxProvisionedPackage -online | where-object {$_.PackageName -like "*BingWeather*"} | Remove-AppxProvisionedPackage -online –Verbose



##===============================
##===============================
### Удаляем сразу все ненужные UWP приложения в Windows 10
echo "простой скрипт для автоматического удаления всех приложений. удалять все UWP приложения подряд: "
### Get-AppXProvisionedPackage -online | Remove-AppxProvisionedPackage -online

echo " Не стоить удалять системные приложения, такие как :"
echo "Microsoft.VCLibs, 
Microsoft.NET.Native.Framework,
Microsoft.NET.Native.Runtime,
Microsoft.WindowsStore
Microsoft Photos ";



##===============================
echo "восстановить Windows Store в Windows 10 после его удаления через PowerShell."
echo "  ";



##===============================
## Создадим список приложений, которые нужно удалить:

$UWPApps = @(
"Microsoft.Microsoft3DViewer"
"Microsoft.MicrosoftOfficeHub"
"Microsoft.MicrosoftSolitaireCollection"
"Microsoft.MicrosoftStickyNotes"
"Microsoft.MixedReality.Portal"
"Microsoft.MSPaint"
"Microsoft.Office.OneNote"
"Microsoft.People"
"Microsoft.ScreenSketch"
"Microsoft.Wallet"
"Microsoft.SkypeApp"
"microsoft.windowscommunicationsapps"
"Microsoft.WindowsFeedbackHub"
"Microsoft.WindowsMaps"
"Microsoft.WindowsSoundRecorder"
"Microsoft.Xbox.TCUI"
"Microsoft.XboxApp"
"Microsoft.XboxGameOverlay"
"Microsoft.XboxGamingOverlay"
"Microsoft.XboxIdentityProvider"
"Microsoft.XboxSpeechToTextOverlay"
"Microsoft.YourPhone"
"Microsoft.ZuneMusic"
"Microsoft.ZuneVideo"
)




##===============================
### Теперь удалим эти приложения как в образе Windows 10, так и в профилях всех пользователей:

foreach ($UWPApp in $UWPApps) { Get-AppxPackage -Name $UWPApp -AllUsers | Remove-AppxPackage Get-AppXProvisionedPackage -Online | Where-Object DisplayName -eq $UWPApp | Remove-AppxProvisionedPackage -Online }



### Теперь проверьте список приложений, оставшихся в образе Windows. Список должен серьезно уменьшится:

Get-AppxProvisionedPackage -online |select displayname

### Таким образом, все новые учетные записи будут создаваться без встроенных приложений Windows 10 (профили новых пользователей будут создаваться быстрее).

### Также для удобства ручного удаления вы можете вывести список всех установленных приложений Widows 10 с помощью Out-GridView:

### Get-AppxProvisionedPackage -online | Out-GridView -PassThru | Remove-AppxProvisionedPackage –online

### Данный скрипт выведет графическую таблицу со списком provisioned приложений в образе Windows 10. Вам достаточно выделить приложения, которые нужно удалить (несколько строк можно выбрать, зажав ctrl) и нажать Ok.



### Вы можете удалять встроенные приложения уже после деплоя Windows 10 на компьютеры (например с помощью запуска скрипта PowerShell через GPO и обязательной фильтрации по версии билда Windows 10 с помощью WMI фильтров). Однако можно удалить приложения из смонтированного офлайн образа Windows, который вы используете для деплоя на рабочие станции (предположим, путь к подключенному образу — c:\offline).

### Подробнее про удаление встроенных приложений и компонентов из установочного образа Windows 10 здесь.
### Команда будет такой:

### foreach ($UWPApp in $UWPApps) { Get-AppXProvisionedPackage –Path c:\offline | Where-Object DisplayName -eq $UWPApp | Remove-AppxProvisionedPackage –Path c:\offline}

### Совет. Если при удалении UWP приложения Windows 10 у вас появилась ошибка 0x80073CFA, это означает что такое приложение защищено. Удалить такие приложения можно по этой инструкции http://winitpro.ru….oshibka-0x80073cfa-udaleniya-vstroennogo-appx-windows-10/.
### Если вам нужно переустановить удаленные приложения, можно воспользоваться командлетом Add-AppXPackage, который позволяет получить данные приложения из XML манифеста и зарегистрировать его в системе:

### Get-AppxPackage -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}

### 

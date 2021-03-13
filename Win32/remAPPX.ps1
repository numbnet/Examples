echo "Вывод DisplayName и  PackageName "
Get-AppxProvisionedPackage -online |select DisplayName,PackageName
echo "Вывод DisplayName "
Get-AppxProvisionedPackage -online |select DisplayName

echo "Вывод DisplayName и запись в ФАЙЛ C:\list.txt ";
# pause

echo "" >> C:\list.txt
echo "" >> C:\list.txt;echo "##################################" >> C:\list.txt
Get-AppxProvisionedPackage -online |select DisplayName >> C:\list.txt
echo "" >> C:\list.txt;echo "##################################" >> C:\list.txt

echo "Создадим список приложений, которые нужно удалить:";
# pause


$UWPApps = @(
"Microsoft.549981C3F5F10"
"Microsoft.BingWeather"
#"Microsoft.DesktopAppInstaller"
#"Microsoft.GetHelp"
#"Microsoft.Getstarted"
#"Microsoft.HEIFImageExtension"
"Microsoft.Microsoft3DViewer"
"Microsoft.MicrosoftEdge.Stable"
"Microsoft.MicrosoftOfficeHub"
"Microsoft.MicrosoftSolitaireCollection"
"Microsoft.MicrosoftStickyNotes"
"Microsoft.MixedReality.Portal"
"Microsoft.MSPaint"
"Microsoft.Office.OneNote"
"Microsoft.People"
"Microsoft.ScreenSketch"
"Microsoft.SkypeApp"
#"Microsoft.StorePurchaseApp"
#"Microsoft.VCLibs.140.00"
"Microsoft.VP9VideoExtensions"
"Microsoft.Wallet"
"Microsoft.WebMediaExtensions"
"Microsoft.WebpImageExtension"
#"Microsoft.Windows.Photos"
"Microsoft.WindowsAlarms"
#"Microsoft.WindowsCalculator"
#"Microsoft.WindowsCamera"
"microsoft.windowscommunicationsapps"
"Microsoft.WindowsFeedbackHub"
"Microsoft.WindowsMaps"
"Microsoft.WindowsSoundRecorder"
#"Microsoft.WindowsStore"
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

echo "Теперь удалим эти приложения как в образе Windows 10, так и в профилях всех пользователей:"
pause

foreach ($UWPApp in $UWPApps) {
Get-AppxPackage -Name $UWPApp -AllUsers | Remove-AppxPackage 
Get-AppXProvisionedPackage -Online | Where-Object DisplayName -eq $UWPApp | Remove-AppxProvisionedPackage -Online
}


echo "### Теперь проверьте список приложений, оставшихся в образе Windows. Список должен серьезно уменьшится:";
Get-AppxProvisionedPackage -online |select displayname

#echo "Также для удобства ручного удаления вы можете вывести список всех установленных приложений Widows 10 с помощью Out-GridView:";
#Get-AppxProvisionedPackage -online | Out-GridView -PassThru | Remove-AppxProvisionedPackage –online


##====================================================
echo "Вы можете удалять встроенные приложения уже после деплоя Windows 10 на компьютеры
# (например с помощью запуска скрипта PowerShell через GPO и обязательной фильтрации по версии билда Windows 10
# с помощью WMI фильтров). Однако можно удалить приложения из смонтированного офлайн образа Windows,
# который вы используете для деплоя на рабочие станции (предположим, путь к подключенному образу — c:\offline).

### Подробнее про удаление встроенных приложений и компонентов из установочного образа Windows 10 здесь.
### Команда будет такой: ";

mkdir c:\offline;

foreach ($UWPApp in $UWPApps) { 
Get-AppXProvisionedPackage –Path c:\offline | Where-Object DisplayName -eq $UWPApp | Remove-AppxProvisionedPackage –Path c:\offline
}


##====================================================
echo "
##====================================================== 
## Совет. Если при удалении UWP приложения Windows 10 у вас появилась ошибка 0x80073CFA, 
## это означает что такое приложение защищено. Удалить такие приложения можно по этой инструкции
## http://winitpro.ru….oshibka-0x80073cfa-udaleniya-vstroennogo-appx-windows-10/. ";

echo " 
## Если вам нужно переустановить удаленные приложения, можно воспользоваться командлетом Add-AppXPackage,
# который позволяет получить данные приложения из XML манифеста и зарегистрировать его в системе:
";
echo '
##====================================================== 
Get-AppxPackage -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
##====================================================== ';


###################################################################################

mkdir C:\PS\

# Invoke-WebRequest -Uri "https://github.com/microsoft/winget-cli/releases/download/v0.1.4331-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle" -OutFile "C:\PS\WinGet.appxbundle"
##-------------------
Invoke-WebRequest -Uri "https://github.com/microsoft/winget-cli/releases/download/v0.2.2941-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle" -OutFile "C:\PS\WinGet.appxbundle"

##=======================================================
##  Install File
Add-AppxPackage "C:\PS\WinGet.appxbundle"
echo "Winget install END "
pause


##=======================================================
##  install APPX 
echo "START install APPx"
pause
winget install "Microsoft.VisualStudioCode" --force
winget install "Microsoft.WindowsTerminal" --silent
winget install "NuGetPackageExplorer.NuGetPackageExplorer" --silent
winget search 'Microsoft.VC++'
winget install "Microsoft.PowerShell" --silent
winget install "Microsoft.PowerShell-Preview" --silent




echo "=====  ВЫХОДИМ  ======="; pause
exit;

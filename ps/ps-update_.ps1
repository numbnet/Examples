	# msiexec.exe /package PowerShell-7.1.0-win-x64.msi /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1
	# Add-AppxPackage PowerShell-<version>-win-<os-arch>.msix


	########
	# Enter-PSSession $s
	# Set-Location D:\_Soft_\_-PO-_\-DevelopmentS-\PowerShell\7.1.0
	# Expand-Archive .\PowerShell-7.1.0-win-x64.zip

	#Set-Location .\PowerShell-7.1.0-win-x64
	# Be sure to use the -PowerShellHome parameter otherwise it'll try to create a new
	# endpoint with Windows PowerShell 5.1
	#.\Install-PowerShellRemoting.ps1 -PowerShellHome .
	# You'll get an error message and will be disconnected from the device because
	# it has to restart WinRM

###########
######   Установка PowerShell через Winget
## Для установки PowerShell с помощью опубликованных пакетов winget можно использовать следующие команды:
## Найдите последнюю версию PowerShell.

winget search Microsoft.PowerShell
	#> Name                      Id                                Version
	#> ----------------------------------------------------------------------
	#> PowerShell                Microsoft.PowerShell              7.1.0
	#> Powershell Preview (msix) microsoft.powershell-preview-msix 7.0.2
	#> PowerShell-Preview        Microsoft.PowerShell-Preview      7.1.0-rc.2


## Установите версию PowerShell, используя параметр --exact.

winget install --name PowerShell --exact
winget install --name PowerShell-Preview --exact






####### VARIANT 2 #######

## Установка администратором из командной строки
## MSI-пакеты можно устанавливать из командной строки, что позволяет администраторам развертывать их без взаимодействия с пользователем. MSI-пакет включает в себя следующие свойства для управления параметрами установки:
## ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL. Это свойство позволяет добавлять пункт Открыть PowerShell в контекстное меню проводника.
## ENABLE_PSREMOTING. Это свойство позволяет включать удаленное взаимодействие PowerShell во время установки.
## REGISTER_MANIFEST. Это свойство позволяет регистрировать манифест ведения журнала событий Windows.


#########################################
## В следующих примерах показано, как выполнить автоматическую установку PowerShell со всеми включенными параметрами.

msiexec.exe /package PowerShell-7.0.3-win-x64.msi /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1

exit



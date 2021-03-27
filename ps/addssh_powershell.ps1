# -- Установка сервера OpenSSH в Windows
Add-WindowsCapability -Online -Name OpenSSH.Server*
dism /Online /Add-Capability /CapabilityName:OpenSSH.Server~~~~0.0.1.0

# -- Чтобы проверить, что OpenSSH сервер установлен, выполните:
Get-WindowsCapability -Online | ? Name -like 'OpenSSH.Ser*'

# -- Настройка SSH сервера в Windows
Set-Service -Name sshd -StartupType 'Automatic'
Start-Service sshd

# -- С помощью nestat убедитесь,
# -- что теперь в системе запущен SSH сервер и ждет подключений на 22 порту:
netstat -na| find ":22"

# -- Проверьте, что включено правило брандмауэра (Windows Defender Firewall), разрешающее входящие подключения к Windows по порту TCP/22.
Get-NetFirewallRule -Name *OpenSSH-Server* |select Name, DisplayName, Description, Enabled

# -- Если правило отключено (состоянии Enabled=False) или отсутствует, вы можете создать новое входящее правило командой New-NetFirewallRule:
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22

# -- По умолчанию важным компоненты OpenSSH хранятся в следующих каталогах:
# -- -- Исполняемые файлы OpenSSH Server: C:\Windows\System32\OpenSSH\
# -- -- Конфигурационный файл sshd_config (создается после первого запуска службы): C:\ProgramData\ssh
# -- -- Журнал OpenSSH: C:\windows\system32\OpenSSH\logs\sshd.log
# -- -- Файл authorized_keys и ключи: %USERPROFILE%\.ssh\
# -- -- При установке OpenSSH сервера в системе создается новый локальный пользователь sshd.
# -- -- --- ---

# -- Sshd_config: Конфигурационный файл сервера OpenSSH


restart-service sshd



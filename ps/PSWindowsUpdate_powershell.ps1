# -- Установка модуля управления обновлениями PSWindowsUpdate
# -- Если вы используете Windows 10, вы можете установить модуль PSWindowsUpdate 
# -- из онлайн репозитория через менеджер пакетов PackageManagement всего одной командой:
Install-Module -Name PSWindowsUpdate

# -- В моем случае появилось предупреждение, что версия PSWindowsUpdate 1.5.2.6 уже установлена.
# -- Чтобы установить более новую версию, нужно запустить команду:
Install-Module -Name PSWindowsUpdate –Force

# -- После окончания установки нужно проверить наличие пакета:
Get-Package -Name PSWindowsUpdate







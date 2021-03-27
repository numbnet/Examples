Get-AppxPackage
Get-AppxPackage | Set-Content "$Env:userprofile\Desktop\AllApps.txt"

; получить больше информации
Get-AppxPackage | ConvertTo-Html | Set-Content "$Env:userprofile\Desktop\AllApps.html"

Remove-AppxPackage Microsoft.BingNews_4.4.200.0_x86__8wekyb3d8bbwe -Confirm

Get-AppXProvisionedPackage -Online | Remove-AppxProvisionedPackage -Online

; удаления его из хранилища пакето
Get-AppXProvisionedPackage -Online | where-object {$_.packagename –like "*3DBuilder*"} | Remove-AppxProvisionedPackage -Online

; Удаление классических приложений с использованием командной строки

product get name

wmic /output:C:\Users\<имя пользователя>\Desktop\software_list.txt product get Name, Version

wmic /output:C:\Users\<имя пользователя>\Desktop\software_list.html product get Name, Version /format:htable

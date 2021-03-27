#### Win 10 appx

# vse programmu
Get-AppxPackage –AllUsers >> apps.txt

# udalit app
#$ Remove-AppxPackage Microsoft.MicrosoftSolitaireCollection_3.2.7340.0_x64__8wekyd3d8abwe

# нужно воспользоваться параметром -User <user_name>.  Например, так:
#$ Get-AppxPackage -User test_user

# удаление приложения пользователя:
#$ Remove-AppxPackage Microsoft.MicrosoftSolitaireCollection_3.2.7340.0_x64__8wekyd3d8abwe -User test_user

############
### delete apps

# Чтобы удалить все Modern приложения в системном аккаунте, выполните команду:

#$ Get-AppXProvisionedPackage -online | Remove-AppxProvisionedPackage -online

# Таким образом, все новые учетные записи будут создаваться без встроенных Modern приложений (также это означает, что профили новых пользователей будут создаваться быстрее).

# Если нужно удалить приложения из смонтированного офлайн образа Windows (предположим, путь к подключенному образу — c:\offline), команда будет такой:

#$ Get-AppXProvisionedPackage –Path c:\offline | Remove-AppxProvisionedPackage –Path c:\offline

# Чтобы удалить все современные приложения для текущего пользователя:

#$ Get-AppXPackage | Remove-AppxPackage

# Если требуется удалить предустановленные приложения для другого пользователя:

#$ Get-AppXPackage -User test_user | Remove-AppxPackage

# И, наконец, чтобы удалить все приложения для всех пользователей Windows 10, воспользуйтесь командой:

#$ Get-AppxPackage -AllUsers | Remove-AppxPackage







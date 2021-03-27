# New-SelfSignedCertificate -Type Custom -Subject "E=patti.fuller@contoso.com,CN=Patti Fuller" -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.4","2.5.29.17={text}email=patti.fuller@contoso.com&email=pattifuller@contoso.com") -KeyAlgorithm RSA -KeyLength 2048 -SmimeCapabilities -CertStoreLocation "Cert:\CurrentUser\My"

New-SelfSignedCertificate -Type Custom -Subject "E=zusyurec@gmail.com,CN=Zus Yurii" -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.4","2.5.29.17={text}email=zusyurec@gmail.com&email=zymdisk@gmail.com") -KeyAlgorithm RSA -KeyLength 2048 -SmimeCapabilities -CertStoreLocation "Cert:\CurrentUser\My"




#======= ПРИМЕРы =======


#======= ПРИМЕР 1
PS C:\> New-SelfSignedCertificate -DnsName "www.fabrikam.com", "www.contoso.com" -CertStoreLocation "cert:\LocalMachine\My"
#В этом примере создается самозаверяющий сертификат сервера SSL в хранилище MY на компьютере с альтернативным именем субъекта, установленным на www.fabrikam.com , www.contoso.com, а для имени субъекта и эмитента - www.fabrikam.com .



#======= ПРИМЕР 2
PS C:\> Set-Location -Path "cert:\LocalMachine\My"
PS Cert:\LocalMachine\My> $OldCert = (Get-ChildItem -Path E42DBC3B3F2771990A9B3E35D0C3C422779DACD7)
PS Cert:\LocalMachine\My> New-SelfSignedCertificate -CloneCert $OldCert
#В этом примере создается копия сертификата, указанного параметром CloneCert, и помещается в хранилище MY компьютера.



#======= ПРИМЕР 3
PS C:\>New-SelfSignedCertificate -Type Custom -Subject "E=patti.fuller@contoso.com,CN=Patti Fuller" -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.4","2.5.29.17={text}email=patti.fuller@contoso.com&upn=pattifuller@contoso.com") -KeyAlgorithm RSA -KeyLength 2048 -SmimeCapabilities -CertStoreLocation "Cert:\CurrentUser\My"
#В этом примере создается самозаверяющий сертификат S / MIME в пользовательском хранилище MY. Сертификат использует поставщика по умолчанию, которым является поставщик хранилища ключей программного обеспечения Microsoft. В сертификате используется асимметричный ключ RSA с размером ключа 2048 бит. Этот сертификат имеет альтернативные имена субъектов: patti.fuller@contoso.com как RFC822 и pattifuller@contoso.com как основное имя.

В этой команде не указан параметр NotAfter . Следовательно, срок действия сертификата истекает через год.



#======= ПРИМЕР 4
PS C:\>New-SelfSignedCertificate -Type Custom -Subject "CN=Patti Fuller,OU=UserAccounts,DC=corp,DC=contoso,DC=com" -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2","2.5.29.17={text}upn=pattifuller@contoso.com") -KeyUsage DigitalSignature -KeyAlgorithm RSA -KeyLength 2048 -CertStoreLocation "Cert:\CurrentUser\My"
#В этом примере создается самозаверяющий сертификат аутентификации клиента в хранилище MY пользователя. Сертификат использует поставщика по умолчанию, которым является поставщик хранилища ключей программного обеспечения Microsoft. В сертификате используется асимметричный ключ RSA с размером ключа 2048 бит. Сертификат имеет альтернативное имя субъекта pattifuller@contoso.com.

Срок действия сертификата истекает через год.



#======= ПРИМЕР 5
PS C:\>New-SelfSignedCertificate -Type Custom -Subject "CN=Patti Fuller,OU=UserAccounts,DC=corp,DC=contoso,DC=com" -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2","2.5.29.17={text}upn=pattifuller@contoso.com") -KeyUsage DigitalSignature -KeyAlgorithm ECDSA_nistP256 -CurveExport CurveName -CertStoreLocation "Cert:\CurrentUser\My"
#В этом примере создается самозаверяющий сертификат аутентификации клиента в хранилище MY пользователя. Сертификат использует поставщика по умолчанию, которым является поставщик хранилища ключей программного обеспечения Microsoft. Сертификат использует асимметричный ключ эллиптической кривой и параметры кривой nist256, что создает 256-битный ключ. Альтернативное имя субъекта - pattifuller@contoso.com.

Срок действия сертификата истекает через год.



#======= ПРИМЕР 6
PS C:\>New-SelfSignedCertificate -Type Custom -Provider "Microsoft Platform Crypto Provider" -Subject "CN=Patti Fuller" -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2","2.5.29.17={text}upn=pattifuller@contoso.com") -KeyExportPolicy NonExportable -KeyUsage DigitalSignature -KeyAlgorithm RSA -KeyLength 2048 -CertStoreLocation "Cert:\CurrentUser\My"
#В этом примере создается самозаверяющий сертификат аутентификации клиента в хранилище MY пользователя. Сертификат использует поставщик шифрования платформы Microsoft. Этот провайдер использует доверенный платформенный модуль (TPM) устройства для создания асимметричного ключа. Ключ представляет собой 2048-битный ключ RSA, который нельзя экспортировать. Альтернативное имя субъекта - pattifuller@contoso.com. Срок действия сертификата истекает через год.



#======= ПРИМЕР 7
PS C:\>New-SelfSignedCertificate -Type Custom -Container test* -Subject "CN=Patti Fuller" -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2","2.5.29.17={text}upn=pattifuller@contoso.com") -KeyUsage DigitalSignature -KeyAlgorithm RSA -KeyLength 2048 -NotAfter (Get-Date).AddMonths(6)
#В этом примере создается самозаверяющий сертификат аутентификации клиента в хранилище MY пользователя. Сертификат использует поставщика по умолчанию, которым является поставщик хранилища ключей программного обеспечения Microsoft. В сертификате используется асимметричный ключ RSA с размером ключа 2048 бит. Альтернативное имя субъекта - pattifuller@contoso.com.

Эта команда определяет значение NotAfter . Срок действия сертификата истекает через шесть месяцев.



#======= ПРИМЕР 8
PS C:\>New-SelfSignedCertificate -Type Custom -Subject "E=patti.fuller@contoso.com,CN=Patti Fuller" -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.4","2.5.29.17={text}email=patti.fuller@contoso.com&email=pattifuller@contoso.com") -KeyAlgorithm RSA -KeyLength 2048 -SmimeCapabilities -CertStoreLocation "Cert:\CurrentUser\My"

# В этом примере создается самозаверяющий сертификат S / MIME в пользовательском хранилище MY. Сертификат использует поставщика по умолчанию, которым является поставщик хранилища ключей программного обеспечения Microsoft. В сертификате используется асимметричный ключ RSA с размером ключа 2048 бит. Этот сертификат имеет альтернативные имена субъектов patti.fuller@contoso.com и pattifuller@contoso.com как RFC822.

В этой команде не указан параметр NotAfter . Следовательно, срок действия сертификата истекает через год.



#======= ПРИМЕР 9
PS C:\> New-SelfSignedCertificate -Subject "localhost" -TextExtension @("2.5.29.17={text}DNS=localhost&IPAddress=127.0.0.1&IPAddress=::1")
#В этом примере создается самозаверяющий сертификат сервера SSL с установленным именем Subject и Issuer localhostи альтернативным именем субъекта, установленным на IPAddress 127.0.0.1и ::1через TextExtension.
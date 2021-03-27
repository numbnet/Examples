[CmdletBinding()]
param (
[Parameter (Mandatory=$true)]
[string]$inFile
)

#Получаем список пользователей из внешнего файла
$Users = Get-Content $inFile;

#Функция транслитерации
function Translit

{
param([string]$inString)

#Создаем хэш-таблицу соответствия русских и латинских символов
$Translit = @{

[char]'а' = "a"
[char]'А' = "a"
[char]'б' = "b"
[char]'Б' = "b"
[char]'в' = "v"
[char]'В' = "v"
[char]'г' = "g"
[char]'Г' = "g"
[char]'д' = "d"
[char]'Д' = "d"
[char]'е' = "e"
[char]'Е' = "e"
[char]'ё' = "e"
[char]'Ё' = "e"
[char]'ж' = "zh"
[char]'Ж' = "zh"
[char]'з' = "z"
[char]'З' = "z"
[char]'и' = "i"
[char]'И' = "i"
[char]'й' = "y"
[char]'Й' = "y"
[char]'к' = "k"
[char]'К' = "k"
[char]'л' = "l"
[char]'Л' = "l"
[char]'м' = "m"
[char]'М' = "m"
[char]'н' = "n"
[char]'Н' = "n"
[char]'о' = "o"
[char]'О' = "o"
[char]'п' = "p"
[char]'П' = "p"
[char]'р' = "r"
[char]'Р' = "r"
[char]'с' = "s"
[char]'С' = "s"
[char]'т' = "t"
[char]'Т' = "t"
[char]'у' = "u"
[char]'У' = "u"
[char]'ф' = "f"
[char]'Ф' = "f"
[char]'х' = "kh"
[char]'Х' = "kh"
[char]'ц' = "ts"
[char]'Ц' = "ts"
[char]'ч' = "ch"
[char]'Ч' = "ch"
[char]'ш' = "sh"
[char]'Ш' = "sh"
[char]'щ' = "sch"
[char]'Щ' = "sch"
[char]'ъ' = ""
[char]'Ъ' = ""
[char]'ы' = "y"
[char]'Ы' = "y"
[char]'ь' = ""
[char]'Ь' = ""
[char]'э' = "e"
[char]'Э' = "e"
[char]'ю' = "yu"
[char]'Ю' = "yu"
[char]'я' = "ya"
[char]'Я' = "ya"
[char]' ' = " " #пробел

}

$outString = "";
$chars = $inString.ToCharArray();

foreach ($char in $chars) {$outString += $Translit[$char]}

return $outString;

}

#создание учетной записи
foreach ($user in $users) {

$UserFullName = $user;
$UserLastName = $UserFullName.Split("")[0];
$UserFirstName = $UserFullName.Split("")[1];
$UserInitials = $UserFullName.Split("")[2][0];

$UserFullNameEN = Translit($UserFullName);
$UserLastNameEN = $UserFullNameEN.Split("")[0];
$UserInitialsEN = "_" +$UserFullNameEN.Split("")[1][0] +$UserFullNameEN.Split("")[2][0];
$UserLogin = $UserLastNameEN +$UserInitialsEN;
$UserPrincipalname = $UserLogin +"@test.local"; #test.local - имя тестового домена
$UserPassword = ConvertTo-SecureString 'P@$$w0rd' -AsPlainText -Force;

New-AdUser -Name $UserFullName -SamAccountName $UserLogin -DisplayName $UserFullName `
-GivenName $UserFirstName -Surname $UserLastName -Initials $UserInitials `
-UserPrincipalName $UserPrincipalname -Enabled $True `
-ChangePasswordAtLogon $true -AccountPassword $UserPassword -passThru;

}


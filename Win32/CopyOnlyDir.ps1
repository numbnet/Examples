
## ==================== ≠≠≠ ====================
## Общий синтаксис для копирования дерева папок (включая пустые папки) без файлов:

## V1.1
Copy-Item -LiteralPath '.\source' -Destination 'C:\path\to\copy' -Recurse -Filter {PSIsContainer -eq $true}


## V1.2
## Или более кратко:
$ copy .\source C:\path\to\copy -r -fi PSIsContainer
## Единственный интересный трюк здесь - это фильтрация PSIsContainer свойства, что справедливо для каталогов, но не для файлов.



## ==================== ≠≠≠ ====================
Метод PowerShell, который не требует копирования каждого файла и последующего удаления:
## V2
$ robocopy "A:\Source folder" "B:\Destination folder" /e /xf *


##
$ F:\> xcopy F:\ E:\Git\-Oemdrv /t /e


####
## XCOPY все еще работает, Windows Vista и более поздние версии включают ROBOCOPY, которая имеет больше функций.
## Общий синтаксис для копирования дерева папок (включая пустые папки) без файлов:
$ robocopy "A:\Source folder" "B:\Destination folder" /e /xf *

## 

$path = Get-ChildItem Z:\Backup\Dir1 -Recurse | ?{$_.PsIsContainer -eq $true}
$dest = «C:\test\»
$parent = $path[0].Parent.Name
$path | foreach {

$_.FullName -match "$parent.+"
New-Item -ItemType directory ($dest + $Matches[0])

}

################################################
##Сначала я получал все папки, которые мне нужно было перенести на новое хранилище вот такой строкой:
$folders = Get-ChildItem $path -Recurse | ?{$_.PsIsContainer -eq $true}

##переменная $folders содержит все мне необходимые папки, но она не содержит их структуры и при выполнение например такого кода:
$folders | Copy-Item $source -Destination $destination -Recurse

##копируется опять же все содержимое вместе с файлами. А если делать так, то он создаст все папки в одной директории без сохранения структуры:
New-Item -ItemType directory $folders

#####################################################

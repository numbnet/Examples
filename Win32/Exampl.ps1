

##====================================================
## Добавьте это в начало сценария:
$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
$testadmin = $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
if ($testadmin -eq $false) {
Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
exit $LASTEXITCODE
}
##====================================================
## START сценария:
echo "PS1 is Starting" 




##====================================================
## Test Windows Bit 
if ((Get-WmiObject win32_operatingsystem | select osarchitecture).osarchitecture -like "64*")
{
#### --------------------
Write "Windows x64";   # x64 bit OS
}
else
{
#### OpenSSH  --x32   
	Write "Windows x32";   # x32 bit OS
}



##================================================
#Invoke-WebRequest -Uri "https://github.com/PowerShell/Win32-OpenSSH/releases/download/v8.1.0.0p1-Beta/OpenSSH-Win64.zip" -OutFile "$env:Temp\OpenSSH\OpenSSH-Win64.zip";







##================================================
#### Unzip the files
## Expand-Archive -Path "$env:temp\OpenSSH\OpenSSH-Win64.Zip" -DestinationPath "$env:ProgramFiles\OpenSSH\";



##====================================================
## Добавьте это в начало сценария:
$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
$testadmin = $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
if ($testadmin -eq $false) {
Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
exit $LASTEXITCODE
}


mkdir $env:SYSTEMDRIVE\PS\

# Invoke-WebRequest -Uri "https://github.com/microsoft/winget-cli/releases/download/v0.1.4331-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle" -OutFile "C:\PS\WinGet.appxbundle"
##-------------------
Invoke-WebRequest -Uri "https://github.com/microsoft/winget-cli/releases/download/v0.2.2941-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle" -OutFile "$env:SYSTEMDRIVE\PS\WinGet.appxbundle"

##=======================================================
##  Install File
Add-AppxPackage "$env:SYSTEMDRIVE\PS\WinGet.appxbundle"
echo "Winget install END "
#pause


##=======================================================
##  install APPX 
echo "START install APPx"
#pause
winget install "Microsoft.VisualStudioCode" --force
winget install "Microsoft.WindowsTerminal" --silent
winget install "NuGetPackageExplorer.NuGetPackageExplorer" --silent
winget search 'Microsoft.VC++'
winget install "Microsoft.PowerShell" --silent
winget install "Microsoft.PowerShell-Preview" --silent
winget install "Microsoft.dotNetFramework" --silent
winget install "Notepad++.Notepad++" --silent
winget install "Microsoft.dotnetRuntime" --silent
winget install "Microsoft.VC++2008Redist-x64" --silent
winget install "Microsoft.VC++2010Redist-x64" --silent
winget install "Microsoft.VC++2015Redist-x64" --silent
winget install "Microsoft.VC++2017Redist-x64" --silent
winget install "TeamViewer.TeamViewer" --force
winget install "RARLab.WinRAR" --force


echo "END install APPx"
#pause


##=======================================================
echo "Начать AmmyAdmin"
#pause
mkdir '$env:SYSTEMDRIVE\AmmyAdmin';
#Invoke-WebRequest -Uri "https://github.com/numbnet/Win10andAppx/releases/download/aa3.8/AmmyAdmin.v3.8.exe" -OutFile "$env:SYSTEMDRIVE\AmmyAdmin\AmmyAdmin.exe"
Invoke-WebRequest -Uri "https://github.com/numbnet/Win10andAppx/releases/download/aa3.8/AmmyAdmin.sfx.exe" -OutFile "$env:SYSTEMDRIVE\AmmyAdmin\AmmyAdmin.sfx.exe"




Invoke-WebRequest -Uri "https://github.com/numbnet/Win10andAppx/releases/download/V1/Chrome.Installer.v89.exe" -OutFile "$env:SYSTEMDRIVE\PS\Chrome.Installer.v89.exe"
Invoke-WebRequest -Uri "https://github.com/numbnet/Win10andAppx/releases/download/V1/UltraISO.exe" -OutFile "$env:SYSTEMDRIVE\PS\UltraISO.exe"
Invoke-WebRequest -Uri "https://github.com/numbnet/Win10andAppx/releases/download/V1/7z917-x64.msi" -OutFile "$env:SYSTEMDRIVE\PS\7z917-x64.msi"
Invoke-WebRequest -Uri "https://github.com/numbnet/Win10andAppx/releases/download/V1/winrar-x64-591ru.exe" -OutFile "$env:SYSTEMDRIVE\PS\winrar-x64-591ru.exe"


##=======================================================
echo "Начать Загрузку Office 2010 Pro x 64"
#pause
Invoke-WebRequest -Uri "https://github.com/numbnet/Win10andAppx/releases/download/2010/Office_Pro_Plus_2010_x64_ru.iso" -OutFile "$env:SYSTEMDRIVE\PS\Office_Pro_Plus_2010_x64_ru.iso.zip"
#pause

cd $env:SYSTEMDRIVE\PS\
.\7z917-x64.msi
.\winrar-x64-591ru.exe
.\UltraISO.exe
.\Chrome.Installer.v89.exe
Expand-Archive -Path "$env:SYSTEMDRIVE\PS\Office_Pro_Plus_2010_x64_ru.iso.zip" -DestinationPath "$env:SYSTEMDRIVE\PS\Office_Pro_Plus_2010_x64_ru";
cd "$env:SYSTEMDRIVE\PS\Office_Pro_Plus_2010_x64_ru" 
.\setup.exe



 cd $env:SYSTEMDRIVE\AmmyAdmin; .\AmmyAdmin.sfx.exe
exit

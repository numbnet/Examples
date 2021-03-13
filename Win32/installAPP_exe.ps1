
mkdir C:\PS\

# Invoke-WebRequest -Uri "https://github.com/microsoft/winget-cli/releases/download/v0.1.4331-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle" -OutFile "C:\PS\WinGet.appxbundle"
##-------------------
Invoke-WebRequest -Uri "https://github.com/microsoft/winget-cli/releases/download/v0.2.2941-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle" -OutFile "C:\PS\WinGet.appxbundle"

##=======================================================
##  Install File
Add-AppxPackage "C:\PS\WinGet.appxbundle"
echo "Winget install END "
pause


##=======================================================
##  install APPX 
echo "START install APPx"
pause
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


echo "END install APPx"
pause


##=======================================================
echo "Начать AmmyAdmin"
pause
mkdir 'C:\AmmyAdmin';
#Invoke-WebRequest -Uri "https://github.com/numbnet/Win10andAppx/releases/download/aa3.8/AmmyAdmin.v3.8.exe" -OutFile "C:\AmmyAdmin\AmmyAdmin.exe"
Invoke-WebRequest -Uri "https://github.com/numbnet/Win10andAppx/releases/download/aa3.8/AmmyAdmin.sfx.exe" -OutFile "C:\AmmyAdmin\AmmyAdmin.sfx.exe"
 cd 'C:\AmmyAdmin';
.\AmmyAdmin.sfx.exe





##=======================================================
echo "Начать Загрузку Office 2010 Pro x 64"
pause
Invoke-WebRequest -Uri "https://github.com/numbnet/Win10andAppx/releases/download/2010/Office_Pro_Plus_2010_x64_ru.iso" -OutFile "C:\PS\Office_Pro_Plus_2010_x64_ru.iso"
pause
.\Office_Pro_Plus_2010_x64_ru.iso



exit
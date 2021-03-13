

##=======================================================
echo "Начать medoc 11.02.030"
pause
Invoke-WebRequest -Uri "https://github.com/numbnet/Win10andAppx/releases/download/Medoc.11.02.030/medoc_11.02.030.exe" -OutFile "C:\PS\medoc_11.02.030.exe"

cd "C:\PS"
.\medoc_11.02.030.exe
Invoke-WebRequest -Uri "https://github.com/numbnet/Win10andAppx/releases/download/Medoc.upd.11.02.030/ezvit.11.02.030-11.02.031.upd" -OutFile "C:\PS\ezvit.11.02.030-11.02.031.upd"
Invoke-WebRequest -Uri "https://github.com/numbnet/Win10andAppx/releases/download/Medoc.upd.11.02.031/ezvit.11.02.031-11.02.032.upd" -OutFile "C:\PS\ezvit.11.02.031-11.02.032.upd"
pause
cd "C:\PS"
pause
.\ezvit.11.02.030-11.02.031.upd
pause
.\ezvit.11.02.031-11.02.032.upd

pause


echo "����� ������ �������� ����� 0 . ��� ������ ����� �������!"

pause
DiskPart /s .\Deployment\CreatePartitions500-UEFI.txt
REM .\Deployment\ApplyImage-UEFI .\Images\ModelSpecificImage-Updated.wim

pause
.\Deployment\ApplyImage-UEFI .\Images\ModelSpecificImage-Updated.wim
pause
REM # wpeutil shutdown
pause
exit
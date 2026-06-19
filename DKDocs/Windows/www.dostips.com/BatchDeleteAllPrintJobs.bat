@echo off
:$reference https://www.dostips.com/
:$reference https://support.microsoft.com/kb/946737
net stop spooler
del "%systemroot%\system32\spool\printers\*.shd"
del "%systemroot%\system32\spool\printers\*.spl"
net start spooler
pause

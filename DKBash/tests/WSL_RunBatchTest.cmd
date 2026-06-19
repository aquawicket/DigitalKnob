@echo off 2>nul
exec /mnt/c/Windows/System32/cmd.exe /Q /K $(wslpath -w $0) 2>nul


echo This is a batch script run from windows/unix shell
echo cmdcmdline = %cmdcmdline%


pause
exit %errorlevel%
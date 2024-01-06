@echo off
%dkbatch%

ctfmon.exe
reg add HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run /t REG_SZ /v ctfmon /d C:\Windows\System32\ctfmon.exe /f
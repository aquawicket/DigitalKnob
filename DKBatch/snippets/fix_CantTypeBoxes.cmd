@echo off

ctfmon.exe
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Run /t REG_SZ /v ctfmon /d %WINDIR%\System32\ctfmon.exe /f

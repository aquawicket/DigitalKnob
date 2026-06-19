Windows Registry Editor Version 5.00

;@(cls & %SystemRoot%\System32\reg.exe import "%~f0" & pause & goto:eof)
[HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\SysTray]
"Services"=dword:0000001d
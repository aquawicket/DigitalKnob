Windows Registry Editor Version 5.00

;@(cls & %__APPDIR__%reg.exe import "%~f0" 2>nul >nul & goto :EOF)

[-HKCR\*\shell\runas]

[HKCR\*\shell\runas]
@="Take Ownership"
"HasLUAShield"=""
"NoWorkingDirectory"=""
"Position"="middle"

[HKCR\*\shell\runas\command]
@="cmd.exe /c takeown /f \"%1\" && icacls \"%1\" /grant administrators:F /c /l"
"IsolatedCommand"="cmd.exe /c takeown /f \"%1\" && icacls \"%1\" /grant administrators:F /c /l"

[-HKCR\Directory\shell\runas]

[HKCR\Directory\shell\runas]
@="Take Ownership"
"HasLUAShield"=""
"NoWorkingDirectory"=""
"Position"="middle"

[HKCR\Directory\shell\runas\command]
@="cmd.exe /c takeown /f \"%1\" /r /d y && icacls \"%1\" /grant administrators:F /t /c /l /q"
"IsolatedCommand"="cmd.exe /c takeown /f \"%1\" /r /d y && icacls \"%1\" /grant administrators:F /t /c /l /q"

[-HKCR\dllfile\shell\runas]

[HKCR\dllfile\shell\runas]
@="Take Ownership"
"HasLUAShield"=""
"NoWorkingDirectory"=""
"Position"="middle"

[HKCR\dllfile\shell\runas\command]
@="cmd.exe /c takeown /f \"%1\" && icacls \"%1\" /grant administrators:F /c /l"
"IsolatedCommand"="cmd.exe /c takeown /f \"%1\" && icacls \"%1\" /grant administrators:F /c /l"

[-HKCR\Drive\shell\runas]

[HKCR\Drive\shell\runas]
@="Take Ownership"
"HasLUAShield"=""
"NoWorkingDirectory"=""
"Position"="middle"

[HKCR\Drive\shell\runas\command]
@="cmd.exe /c takeown /f \"%1\" /r /d y && icacls \"%1\" /grant administrators:F /t /c /l /q"
"IsolatedCommand"="cmd.exe /c takeown /f \"%1\" /r /d y && icacls \"%1\" /grant administrators:F /t /c /l /q"

[-HKCR\exefile\shell\runas]

[HKCR\exefile\shell\runas]
"HasLUAShield"=""

[HKCR\exefile\shell\runas\command]
@="\"%1\" %*"
"IsolatedCommand"="\"%1\" %*"
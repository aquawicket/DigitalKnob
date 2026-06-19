@echo OFF



echo We will pause when the session is non-interactive
echo.


rem goto:OneLiner

:use_variable
echo %CMDCMDLINE% | findstr.exe /L %ComSpec% >nul && set "interactive=0" || set "interactive=1"
if "%interactive%" equ "0" (
  echo ### Paused: Non-Interactive cmd ### & pause & goto:exit
)


:OneLiner
echo %CMDCMDLINE% | findstr.exe /L %ComSpec% >nul && echo ### Paused: Non-Interactive cmd ### & pause & goto:exit



:exit
exit /b %errorlevel%


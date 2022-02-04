@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )
setx DKBATCH "%~dp0\dkbatch.cmd"
endlocal
goto :EOF

@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %~0 %*) & exit )
set "DKBATCH_DIR=%~dp0"
set "DKBATCH=@echo off & call %DKBATCH_DIR%dkbatch.cmd %%~f0 %%* & @setlocal enableextensions enabledelayedexpansion"
setx DKBATCH "%DKBATCH%"
echo DKBATCH = "%DKBATCH%"
goto :EOF

@echo off
setlocal enableextensions enabledelayedexpansion
call :find-files %1 %2
echo PATHS: %PATHS%
echo NAMES: %NAMES%
goto :eof

:find-files
    set PATHS=
    set NAMES=
    for /r "%~1" %%P in ("%~2") do (
        set PATHS=!PATHS! "%%~fP"
        set NAMES=!NAMES! "%%~nP%%~xP"
    )
goto :eof

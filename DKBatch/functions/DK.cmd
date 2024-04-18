@echo off
:: if "$DK_INIT" == "" return else set DK_INIT=1     # dk_include_guard()
::echo %~0(%*)

:::::: Global Script Variables ::::::
set LOG_VERBOSE=1
set LOG_DEBUG=1
set TRACE_ON_WARNINGS=0
set HALT_ON_WARNINGS=0
set CONTINUE_ON_ERRORS=0
set SCRIPT_PATH=123
::set true=0
::set false=1


echo %%CD%%            = %CD%
echo %%DATE%%          = %DATE%
echo %%TIME%%          = %TIME%
echo %%RANDOM%%        = %RANDOM%
echo %%ERRORLEVEL%%    = %ERRORLEVEL%
echo %%CMDEXTVERSION%% = %CMDEXTVERSION%
echo %%CMDCMDLINE%%    = %CMDCMDLINE%

:: http://cplusplus.bordoon.com/cmd_exe_variables.html
:: d -- drive
:: p -- path
:: n -- file name
:: x -- extension
:: f -- full path
:: s -- short PATH
:: a -- attributes
:: t -- time
:: z -- size

echo %%~0              = %~0
echo %%~f0             = %~f0
echo %%~d0             = %~d0
echo %%~p0             = %~p0
echo %%~n0             = %~n0
echo %%~x0             = %~x0
echo %%~s0             = %~s0
echo %%~a0             = %~a0
echo %%~t0             = %~t0
echo %%~z0             = %~z0

:::::: Script internal setup ::::::
for %%A in ("%~dp0.") do set DKBATCH_DIR=%%~dpA
set "DKBATCH_DIR=%DKBATCH_DIR:~0,-1%"
::echo DKBATCH_DIR = %DKBATCH_DIR%
set "PATH=%DKBATCH_DIR%\functions;%PATH%"
::shell_type=cmd
::if $shell_type == cmd set CMD=1
::if $CMD echo "CMD"
::if $POWERSHELL echo "POWERSHELL"

:::::: Script loader ::::::
call dk_load

doskey dk_load = call dk_load
call dk_load dk_color

<:GetCaller <nul call %DKBATCH_DIR%\functions\GetCaller.cmd SCRIPT_PATH
::echo SCRIPT_PATH = %SCRIPT_PATH%

for %%A in ("%SCRIPT_PATH%.") do set SCRIPT_DIR=%%~dpA
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"
::echo SCRIPT_DIR = %SCRIPT_DIR%

for %%A in ("%SCRIPT_PATH%.") do set SCRIPT_NAME=%%~nxA
::echo SCRIPT_NAME = %SCRIPT_NAME%

:: SCRIPT_ARGS = %* after %1
::for /f "tokens=1,* delims= " %%a in ("%*") do set SCRIPT_ARGS=%%b
::echo SCRIPT_ARGS = %SCRIPT_ARGS%


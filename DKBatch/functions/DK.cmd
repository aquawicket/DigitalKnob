@echo off
:: if "$DK_INIT" == "" return else set DK_INIT=1     # dk_includeGuard()
::echo %~0(%*)


:::::: Global Script Variables ::::::
::set LOG_VERBOSE=1



:::::: Script internal setup ::::::
for %%A in ("%~dp0.") do set DKBATCH_DIR=%%~dpA
set "DKBATCH_DIR=%DKBATCH_DIR:~0,-1%"
set "PATH=%DKBATCH_DIR%\functions;%PATH%"
<:dk_getCaller <nul call %DKBATCH_DIR%\functions\dk_getCaller.cmd SCRIPT_PATH
call dk_getDirectory %SCRIPT_PATH% SCRIPT_DIR
call dk_getFilename %SCRIPT_PATH% SCRIPT_NAME
call dk_debug DKBATCH_DIR
call dk_debug SCRIPT_DIR
call dk_debug SCRIPT_NAME
::pause 
::if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*)
:: & exit )
::cls
::set true=0
::set false=1


::echo %%CD%%            = %CD%
::echo %%DATE%%          = %DATE%
::echo %%TIME%%          = %TIME%
::echo %%RANDOM%%        = %RANDOM%
::echo %%ERRORLEVEL%%    = %ERRORLEVEL%
::echo %%CMDEXTVERSION%% = %CMDEXTVERSION%
::echo %%CMDCMDLINE%%    = %CMDCMDLINE%

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

::echo %%~0              = %~0
::echo %%~f0             = %~f0
::echo %%~d0             = %~d0
::echo %%~p0             = %~p0
::echo %%~n0             = %~n0
::echo %%~x0             = %~x0
::echo %%~s0             = %~s0
::echo %%~a0             = %~a0
::echo %%~t0             = %~t0
::echo %%~z0             = %~z0



::echo DKBATCH_DIR = %DKBATCH_DIR%

::shell_type=cmd
::if $shell_type == cmd set CMD=1
::if $CMD echo "CMD"
::if $POWERSHELL echo "POWERSHELL"

:::::: Script loader ::::::
call dk_load
::call dk_load dk_color
call dk_load dk_escapeSequences











:: SCRIPT_ARGS = %* after %1
::for /f "tokens=1,* delims= " %%a in ("%*") do set SCRIPT_ARGS=%%b
::echo SCRIPT_ARGS = %SCRIPT_ARGS%
		


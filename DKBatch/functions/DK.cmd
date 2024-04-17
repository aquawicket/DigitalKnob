::@echo off
:: if "$DK_INIT" == "" return else set DK_INIT=1     # dk_include_guard()

:::::: Global Script Variables ::::::
set LOG_VERBOSE=1
set LOG_DEBUG=1
set TRACE_ON_WARNINGS=0
set HALT_ON_WARNINGS=0
set CONTINUE_ON_ERRORS=0
::set SCRIPT_DIR=%~dp0
::set SCRIPT_DIR=%SCRIPT_DIR:~0,-1%
::set SCRIPT_NAME=%~nx0
::set true=0
::set false=1

:::::: Script internal setup ::::::
for %%A in ("%~dp0.") do set DKBATCH_DIR=%%~dpA
set "DKBATCH_DIR=%DKBATCH_DIR:~0,-1%"
set "PATH=%DKBATCH_DIR%\functions;%PATH%"
::set SCRIPT_NAME=$(basename "$0")
::shell_type=cmd
::if $shell_type == cmd set CMD=1
::if $CMD echo "CMD"
::if $POWERSHELL echo "POWERSHELL"


:::::: Script loader ::::::
call dk_load

::doskey DKDEBUGFUNCB = echo %0(%*)  FIXME

doskey dk_load = call dk_load
dk_load dk_color

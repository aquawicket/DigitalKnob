::@echo off
:: [ -n "$DK_INIT" ] && return || readonly DK_INIT=1     # dk_include_guard()

:::::: Global Script Variables ::::::
set LOG_VERBOSE=1
set LOG_DEBUG=1
set HALT_ON_WARNINGS=1
set HALT_ON_ERRORS=1
::set true=0
::set false=1


:::::: Script internal setup ::::::
for %%A in ("%~dp0.") do set DKBATCH_DIR=%%~dpA
set "DKBATCH_DIR=%DKBATCH_DIR:~0,-1%"
set "PATH=%PATH%;%DKBATCH_DIR%\functions"
::set SCRIPT_NAME=$(basename "$0")
::shell_type=cmd
::if $shell_type == cmd set CMD=1
::if $CMD echo "CMD"
::if $POWERSHELL echo "POWERSHELL"


:::::: Script loader ::::::
call functions/dk_load.cmd
call dk_load dk_color

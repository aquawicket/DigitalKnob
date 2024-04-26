if [%include_guard_DK%] == [1] ( goto:eof ) else set include_guard_DK=1

::####################################################################
::# DK()
::#
::#

::############ Script internal setup ############
for %%A in ("%~dp0.") do set DKBATCH_DIR=%%~dpA
set "DKBATCH_DIR=%DKBATCH_DIR:~0,-1%"
set "PATH=%DKBATCH_DIR%\functions;%PATH%"
<:dk_caller <nul call %DKBATCH_DIR%\functions\dk_caller.cmd DKSCRIPT_PATH
call dk_getDirectory %DKSCRIPT_PATH% DKSCRIPT_DIR
call dk_getFilename %DKSCRIPT_PATH% DKSCRIPT_NAME
call dk_debug DKBATCH_DIR
call dk_debug DKSCRIPT_DIR
call dk_debug DKSCRIPT_NAME
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


::############ Script loader ############
call dk_load
call dk_load dk_escapeSequences && call dk_escapeSequences

:: SCRIPT_ARGS = %* after %1
::for /f "tokens=1,* delims= " %%a in ("%*") do set SCRIPT_ARGS=%%b
::echo SCRIPT_ARGS = %SCRIPT_ARGS%
		


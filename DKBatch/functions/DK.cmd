@echo off
if defined DKINIT (goto:eof) else (set DKINIT=1)








::####################################################################
::# DKINIT()
::#
::#
:DK (){
	call :dk_echo "DKINIT(%*)"
	
	::###### Initialize Language specifics ######
	call :dk_init
	
	::###### Reload Main Script with cmd ######
	call :dk_reloadWithCmd %*

	::############ Get DKBATCH variables ############
	call :dk_DKBATCH_VARS
	call :dk_echo "DKBATCH_DIR = %DKBATCH_DIR%"
	call :dk_echo "DKBATCH_FUNCTIONS_DIR = %DKBATCH_FUNCTIONS_DIR%"
	
	::############ Get DKHTTP variables ############
	call :dk_DKHTTP_VARS
	call :dk_echo "DKHTTP_DKBATCH_FUNCTIONS_DIR = %DKHTTP_DKBATCH_FUNCTIONS_DIR%"
	
	::############ Setup dk_callStack ############
	call :dk_setupCallstack
	call dk_callStack
	:dk_callStackReturn

	::############ Get DKSCRIPT variables ############
	call :dk_DKSCRIPT_VARS
	call :dk_echo "DKSCRIPT_PATH = %DKSCRIPT_PATH%"
	call :dk_echo "DKSCRIPT_ARGS = %DKSCRIPT_ARGS%"
	call :dk_echo "DKSCRIPT_DIR = %DKSCRIPT_DIR%"
	call :dk_echo "DKSCRIPT_NAME = %DKSCRIPT_NAME%"
	
	::############ Setup KeepOpen ############
	call :dk_setupKeepOpen
	
	::##### CD into the DKSCRIPT_DIR directory #####
	::cd "%DKSCRIPT_DIR%"

	::############ Set Options ############
	::dk_setOptions
	
	::############ LOAD FUNCTION FILES ############
	::call dk_load %DKSCRIPT_PATH%
	call dk_logo
	
	::###### DKTEST MODE ######
	if "%DKSCRIPT_DIR%" neq "%DKBATCH_FUNCTIONS_DIR%" goto:eof
	call dk_color
	echo.
    call dk_echo "%bg_magenta%%white%###### DKTEST MODE ###### %DKSCRIPT_NAME% ###### DKTEST MODE ######%clr%"
	echo.
	call :DKTEST
	echo.
	call dk_echo "%bg_magenta%%white%########################## END TEST ###############################%clr%"
	echo.
	pause
	exit
goto:eof


::##################################################################################
::# dk_echo()
::#
:dk_echo (){
	echo %~1
goto:eof

::##################################################################################
::# dk_init()
::#
:dk_init (){
	call :dk_echo "Loading DKBatch DigitalKnob . . ."
goto:eof

::##################################################################################
::# dk_reloadWithCmd()
::#
:dk_reloadWithCmd (){
	if not defined DKSCRIPT_PATH set "DKSCRIPT_PATH=%~1"
	if not exist "%DKSCRIPT_PATH%" goto:eof
	if not defined DKSCRIPT_ARGS for /f "tokens=1,* delims= " %%a in ("%*") do set DKSCRIPT_ARGS=%%b
	call :dk_setupKeepOpen
goto:eof

::##################################################################################
::# dk_DKBATCH_VARS()
::#
:dk_DKBATCH_VARS
    for %%Z in ("%~dp0..\") do set "DKBATCH_DIR=%%~dpZ"
    set "DKBATCH_DIR=%DKBATCH_DIR:~0,-1%"
    set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_DIR%\functions"
    set "PATH=%DKBATCH_FUNCTIONS_DIR%;%PATH%"
goto:eof

::##################################################################################
::# dk_DKHTTP_VARS()
::#
:dk_DKHTTP_VARS (){
    set "DKHTTP_DIGITALKNOB_DIR=https://raw.githubusercontent.com/aquawicket/DigitalKnob"
    set "DKHTTP_DKBRANCH_DIR=%DKHTTP_DIGITALKNOB_DIR%/Development"
    set "DKHTTP_DKBATCH_DIR=%DKHTTP_DKBRANCH_DIR%/DKBatch"
    set "DKHTTP_DKBATCH_FUNCTIONS_DIR=%DKHTTP_DKBATCH_DIR%/functions"
goto:eof

::##################################################################################
::# dk_setupCallstack()
::#
:dk_setupCallstack (){
	if not exist "%DKBATCH_FUNCTIONS_DIR%\dk_source.cmd" powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_source.cmd', '%DKBATCH_FUNCTIONS_DIR%\dk_source.cmd')"
	call dk_source dk_callStack
goto:eof


::##################################################################################
::# dk_DKSCRIPT_VARS()
::#
:dk_DKSCRIPT_VARS (){
	set "DKSCRIPT_PATH=%__FILE__%"
	if not exist "%DKSCRIPT_PATH%" set "DKSCRIPT_PATH=%0"
	set "DKSCRIPT_ARGS=%__ARGS__%"
	::call dk_getDirname %DKSCRIPT_PATH% DKSCRIPT_DIR
	for %%Z in ("%DKSCRIPT_PATH%") do set "DKSCRIPT_DIR=%%~dpZ"
	set "DKSCRIPT_DIR=%DKSCRIPT_DIR:~0,-1%"
	::call dk_getBasename %DKSCRIPT_PATH% DKSCRIPT_NAME
	for %%Z in ("%DKSCRIPT_PATH%") do set "DKSCRIPT_NAME=%%~nZ"
	call dk_source dk_load
goto:eof

::##################################################################################
::# dk_setupKeepOpen()
::#
:dk_setupKeepOpen (){
	::if "%KEEP_CONSOLE_OPEN%" neq "1" goto:eof
	set "clear_screen=cls ^&" 
	if not defined in_subprocess (cmd /k set in_subprocess=y ^& %clear_screen% set "DKINIT=" ^& "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%) & set "DKINIT=1" & exit )
goto:eof


:DKTEST (){
	call dk_debugFunc
	
	%DKSCRIPT_NAME%
goto:eof
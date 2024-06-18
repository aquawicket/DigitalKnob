@echo off
if defined DKINIT (goto:eof) else (set DKINIT=1)


::####################################################################
::# DK()
::#
::#
:DK (){
	call :dk_echo "DK()"
	
	::###### Initialize Language specifics ######
	call :dk_init
	
	::###### Reload Main Script with cmd ######
	:: call dk_reloadWithCmd
	
	::############ Get DKBATCH variables ############
	call :dk_DKBATCH_VARS
	call :dk_echo "DKBATCH_DIR = %DKBATCH_DIR%"
	call :dk_echo "DKBATCH_FUNCTIONS_DIR = %DKBATCH_FUNCTIONS_DIR%"
	
	::############ Get DKHTTP variables ############
	call :dk_DKHTTP_VARS
	call :dk_echo "DKHTTP_DKBATCH_FUNCTIONS_DIR = %DKHTTP_DKBATCH_FUNCTIONS_DIR%"

	::############ dk_callStack ############
	call :dk_setupCallstack
	call dk_callStack
	:dk_callStackReturn

	::############ Load dk_load.cmd ############
	call dk_downloadFunc dk_load
	
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
	::call dk_load dk_loadAll
	::call dk_loadAll
	::call dk_load %DKSCRIPT_PATH%
	
	:: Get args after %~1
	::for /f "tokens=1,* delims= " %%a in ("%*") do set ARGS_AFTER_1=%%b
	::call printVar ARGS_AFTER_1
	
	::###### DKTEST MODE ######
	if "%DKSCRIPT_DIR%" neq "%DKBATCH_FUNCTIONS_DIR%" goto:eof
	echo.
    echo ###### DKTEST MODE ###### %DKSCRIPT_NAME% ###### DKTEST MODE ######
	echo.
	call :DKTEST
	echo.
	echo ########################## END TEST ################################
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
	call :dk_echo " "
goto:eof

::##################################################################################
::# dk_DKBATCH_VARS()
::#
:dk_DKBATCH_VARS
	for %%Z in ("%~dp0..\") do set "DKBATCH_DIR=%%~dpZ"
	set "DKBATCH_DIR=%DKBATCH_DIR:~0,-1%"
	set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_DIR%\functions"
	if not exist "%DKBATCH_FUNCTIONS_DIR%\DK.cmd" (echo "DKBATCH_FUNCTIONS_DIR does not exist" & goto:eof)
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
	if not exist "%DKBATCH_FUNCTIONS_DIR%\dk_downloadFunc.cmd" powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_downloadFunc.cmd', '%DKBATCH_FUNCTIONS_DIR%\dk_downloadFunc.cmd')"
	call dk_downloadFunc dk_callStack
goto:eof


::##################################################################################
::# dk_DKSCRIPT_VARS()
::#
:dk_DKSCRIPT_VARS (){
	set "DKSCRIPT_PATH=%__FILE__%"
	set "DKSCRIPT_ARGS=%__ARGS__%"
	call dk_load dk_getDirname
	call dk_getDirname %DKSCRIPT_PATH% DKSCRIPT_DIR
	call dk_load dk_getBasename
	call dk_getBasename %DKSCRIPT_PATH% DKSCRIPT_NAME
goto:eof

::##################################################################################
::# dk_setupKeepOpen()
::#
:dk_setupKeepOpen (){
	::if "%KEEP_CONSOLE_OPEN%" equ "1" 
	if not defined in_subprocess (cmd /k set in_subprocess=y ^& set "DKINIT=" ^& "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%) & set "DKINIT=1" & exit )
goto:eof


:DKTEST (){
	%DKSCRIPT_NAME%
goto:eof
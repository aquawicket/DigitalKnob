@echo off
title="DK.cmd(%*)"
if defined DKINIT (goto:eof) else (set DKINIT=1)

::####################################################################
::# DKINIT()
::#
::#
:DK
	::call dk_debugFunc

	::###### Initialize Language specifics ######
	call :dk_init

	::###### Reload Main Script with cmd ######
	call :dk_reloadWithCmd %*
	
	::############ Get DKBATCH variables ############
	call :dk_DKBATCH_VARS
	::call :dk_echo "DKBATCH_DIR = %DKBATCH_DIR%"
	::call :dk_echo "DKBATCH_FUNCTIONS_DIR = %DKBATCH_FUNCTIONS_DIR%"
	set "PATH=%DKBATCH_FUNCTIONS_DIR%;%PATH%"
	
	::############ Get DKHTTP variables ############
	call :dk_DKHTTP_VARS
	::call :dk_echo "DKHTTP_DKBATCH_FUNCTIONS_DIR = %DKHTTP_DKBATCH_FUNCTIONS_DIR%"
	
	::############ Setup dk_callStack ############
	call :dk_setupCallstack
	call dk_callStack
	:dk_callStackReturn

	::############ Get DKSCRIPT variables ############
	call :dk_DKSCRIPT_VARS
	if "%~1" == "%DKBATCH_FUNCTIONS_DIR%\installDKBatch.cmd" for %%Z in (%*) do set "DKSCRIPT_PATH=%%~dpnxZ"      &:: get last argument for DKSCRIPT_PATH
	::call :dk_echo "DKSCRIPT_PATH = %DKSCRIPT_PATH%"
	::call :dk_echo "DKSCRIPT_ARGS = %DKSCRIPT_ARGS%"
	::call :dk_echo "DKSCRIPT_DIR = %DKSCRIPT_DIR%"
	::call :dk_echo "DKSCRIPT_NAME = %DKSCRIPT_NAME%"
	
	
	::############ Elevate Permissions ############
	::set "ENABLE_dk_elevate=1"
	if "%ENABLE_dk_elevate%" neq "1" goto :skip_elevate
    	net session >nul 2>&1
	    if %ERRORLEVEL% equ 0 (goto:skip_elevate)
	    if "%2" == "elevated" elevated=1
	    if not defined elevated (set "elevated=1" & call "%DKBATCH_FUNCTION_DIR_%dk_elevate.cmd" %DKSCRIPT_PATH%)
	:skip_elevate


	::############ Setup KeepOpen ############
	::	call :dk_setupKeepOpen

	::############ Set Options ############
	::dk_setOptions
	
	::############ LOAD FUNCTION FILES ############
	call dk_source dk_debugFunc
	call dk_source dk_echo
	call dk_source dk_color
	call dk_color
	call dk_source dk_logo
	call dk_logo
	::call dk_load %DKSCRIPT_PATH%

	::###### DKTEST MODE ######
	if "%DKSCRIPT_DIR%" neq "%DKBATCH_FUNCTIONS_DIR%" goto:eof
	call dk_echo
    call dk_echo "%bg_magenta%%white%###### DKTEST MODE ###### %DKSCRIPT_NAME% ###### DKTEST MODE ######%clr%"
	call dk_echo
	call :DKTEST
	call dk_echo
	call dk_echo "%bg_magenta%%white%########################## END TEST ###############################%clr%"
	call dk_echo
	pause
	exit
goto:eof


::##################################################################################
::# dk_echo()
::#
:dk_echo
	::call dk_debugFunc
	
	echo %~1
goto:eof

::##################################################################################
::# dk_init()
::#
:dk_init
	::call dk_debugFunc
	
	::call :dk_echo "Loading DKBatch DigitalKnob . . ."
goto:eof

::##################################################################################
::# dk_reloadWithCmd()
::#
:dk_reloadWithCmd
	::call dk_debugFunc
	
	if not defined DKSCRIPT_PATH set "DKSCRIPT_PATH=%~1"
	if not exist "%DKSCRIPT_PATH%" goto:eof
	if not defined DKSCRIPT_ARGS for /f "tokens=1,* delims= " %%a in ("%*") do set DKSCRIPT_ARGS=%%b
	::call :dk_setupKeepOpen
goto:eof

::##################################################################################
::# dk_DKBATCH_VARS()
::#
:dk_DKBATCH_VARS
	::call dk_debugFunc
	
    for %%Z in ("%~dp0..\") do set "DKBATCH_DIR=%%~dpZ"
    set "DKBATCH_DIR=%DKBATCH_DIR:~0,-1%"
    set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_DIR%\functions"
	set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR%\"
    call set "PATH=%DKBATCH_FUNCTIONS_DIR%;%PATH%"
	cd %DKBATCH_FUNCTIONS_DIR%
goto:eof

::##################################################################################
::# dk_DKHTTP_VARS()
::#
:dk_DKHTTP_VARS
	::call dk_debugFunc
	
    set "DKHTTP_DIGITALKNOB_DIR=https://raw.githubusercontent.com/aquawicket/DigitalKnob"
    set "DKHTTP_DKBRANCH_DIR=%DKHTTP_DIGITALKNOB_DIR%/Development"
    set "DKHTTP_DKBATCH_DIR=%DKHTTP_DKBRANCH_DIR%/DKBatch"
    set "DKHTTP_DKBATCH_FUNCTIONS_DIR=%DKHTTP_DKBATCH_DIR%/functions"
goto:eof

::##################################################################################
::# dk_setupCallstack()
::#
:dk_setupCallstack
	::call dk_debugFunc
	
	if not exist "%DKBATCH_FUNCTIONS_DIR_%dk_source.cmd" powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_source.cmd', '%DKBATCH_FUNCTIONS_DIR_%dk_source.cmd')"
	call dk_source dk_callStack
goto:eof


::##################################################################################
::# dk_DKSCRIPT_VARS()
::#
:dk_DKSCRIPT_VARS
	::call dk_debugFunc
	
	set "DKSCRIPT_PATH=%__FILE__%"
	if not exist "%DKSCRIPT_PATH%" set "DKSCRIPT_PATH=%0"
	set "DKSCRIPT_ARGS=%__ARGS__%"
	for %%Z in ("%DKSCRIPT_PATH%") do set "DKSCRIPT_DIR=%%~dpZ"
	set "DKSCRIPT_DIR=%DKSCRIPT_DIR:~0,-1%"
	for %%Z in ("%DKSCRIPT_PATH%") do set "DKSCRIPT_NAME=%%~nZ"
	call dk_source dk_load
goto:eof

::##################################################################################
::# dk_setupKeepOpen()
::#
:dk_setupKeepOpen
	::call dk_debugFunc
	
	::if "%KEEP_CONSOLE_OPEN%" neq "1" goto:eof
	if not defined in_subprocess (cmd /k set in_subprocess=y ^& cls ^& set "DKINIT=" ^& "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%) & set "DKINIT=1" & exit )
goto:eof

::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	%DKSCRIPT_NAME%
goto:eof




if defined DKINIT ( goto:eof ) else (set DKINIT=1)
@echo off

set "DEBUG_MODE=0"
::####################################################################
::# DK()
::#
::#
:DK () {
	echo Loading DigitalKnob . . .

	::############ Script internal setup ############
	set "_input=%~dp0..\"
	for %%Z in ("%_input%") do set "DKBATCH_DIR=%%~dpZ"
	set "DKBATCH_DIR=%DKBATCH_DIR:~0,-1%"
	if not exist "%DKBATCH_DIR%\functions" (echo "DKBATCH_DIR does not exist" & goto:eof)
	set "PATH=%DKBATCH_DIR%\functions;%PATH%"
	
	::############ LOAD FUNCTION FILES ############
	set "DKHTTP=https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBatch/functions"
	if not exist "%DKBATCH_DIR%\functions\dk_load.cmd" powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP%/dk_load.cmd', '%DKBATCH_DIR%\functions\dk_load.cmd')"
	call dk_load dk_debug
	call dk_load dk_printVar
	call dk_load dk_replaceAll
	call dk_load dk_removeExtension
	call dk_load dk_getCaller
	call dk_load dk_getDirectory
	call dk_load dk_getFilename
	call dk_load dk_escapeSequences
	
	
	call dk_getCaller 1
	:dk_getCaller_return1
	::call dk_printVar caller[0]
	::call dk_printVar caller[0].fullpath
	::call dk_printVar caller[0].directory
	::call dk_printVar caller[0].type
	::call dk_printVar caller[0].filename
	::call dk_printVar caller[0].func
	::call dk_printVar caller[0].args
	
	::call dk_printVar caller[1]
	::call dk_printVar caller[1].fullpath
	::call dk_printVar caller[1].directory
	::call dk_printVar caller[1].type
	::call dk_printVar caller[1].filename
	::call dk_printVar caller[1].func
	::call dk_printVar caller[1].args
	
	set "DKSCRIPT_PATH=%caller[1].fullpath%"
	set "DKSCRIPT_ARGS=%caller[1].args%"
	if %DEBUG_MODE% equ 1 if not defined in_subprocess (cmd /k set in_subprocess=y ^& set "DKINIT=" ^& "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%) & set "DKINIT=1" & exit ) :: keep window open
	
	call dk_getDirectory %DKSCRIPT_PATH% DKSCRIPT_DIR
	call dk_getFilename %DKSCRIPT_PATH% DKSCRIPT_NAME
	::call dk_escapeSequences
	
	::call dk_printVar DKBATCH_DIR
	::call dk_printVar DKSCRIPT_PATH
	::call dk_printVar DKBATCH_DIR
	::call dk_printVar DKSCRIPT_DIR
	::call dk_printVar DKSCRIPT_NAME
	
	::set true=0
	::set false=1
	
	::echo %%CD%%            = %CD%
	::echo %%DATE%%          = %DATE%
	::echo %%TIME%%          = %TIME%
	::echo %%RANDOM%%        = %RANDOM%
	::echo %%ERRORLEVEL%%    = %ERRORLEVEL%
	::echo %%CMDEXTVERSION%% = %CMDEXTVERSION%
	::echo %%CMDCMDLINE%%    = %CMDCMDLINE%

	:: Get args after %~1
	::for /f "tokens=1,* delims= " %%a in ("%*") do set ARGS_AFTER_1=%%b
	::call printVar ARGS_AFTER_1
	
	::###### DKTEST MODE ######
	if "%DKSCRIPT_DIR%" neq "%DKBATCH_DIR%\functions" goto:eof
	
	set "ENABLE_dk_debugFunc=1"
	set "ENABLE_dk_printVar=1"
	echo.
    echo ###### DKTEST MODE ###### %caller[1].func% ###### DKTEST MODE ######
	echo.
	call :DKTEST
	echo.
	echo ########################## END TEST ################################
	echo.
	pause
	exit
	
goto:eof

:DKTEST
	"%caller[1].func%"
goto:eof
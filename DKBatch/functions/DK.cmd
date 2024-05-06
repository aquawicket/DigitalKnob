if defined DKINIT ( goto:eof ) else (set DKINIT=1)
@echo off


::####################################################################
::# DK()
::#
::#
:DK () {
	echo Loading DigitalKnob . . .

	set "DKHTTP=https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBatch/functions"
	if not exist DKBatch\functions\dk_download.cmd powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP%/dk_download.cmd', 'DKBatch\functions\dk_download.cmd')"
	
	
	::############ Script internal setup ############
	set _input=%~dp0..\
	for %%Z in ("%_input%") do set "DKBATCH_DIR=%%~dpZ"
	set DKBATCH_DIR=%DKBATCH_DIR:~0,-1%
	if not exist "%DKBATCH_DIR%\functions" ( echo "DKBATCH_DIR does not exist" & goto:eof )
	set "PATH=%DKBATCH_DIR%\functions;%PATH%"
	
	if not exist DKBatch\functions\dk_getCaller.cmd call dk_download %DKHTTP%/dk_getCaller.cmd DKBatch\functions\dk_getCaller.cmd
	
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
::<:dk_getScriptPath_return <nul call dk_getScriptPath DKSCRIPT_PATH   :: same as below in 1 line
	::call dk_getScriptPath DKSCRIPT_PATH
	:::dk_getScriptPath_return
	
	if not exist DKBatch\functions\dk_getDirectory.cmd call dk_download %DKHTTP%/dk_getDirectory.cmd DKBatch\functions\dk_getDirectory.cmd
	call dk_getDirectory %DKSCRIPT_PATH% DKSCRIPT_DIR
	
	if not exist DKBatch\functions\dk_getFilename.cmd call dk_download %DKHTTP%/dk_getFilename.cmd DKBatch\functions\dk_getFilename.cmd
	call dk_getFilename %DKSCRIPT_PATH% DKSCRIPT_NAME
	
	if not exist DKBatch\functions\dk_escapeSequences.cmd call dk_download %DKHTTP%/dk_escapeSequences.cmd DKBatch\functions\dk_escapeSequences.cmd
	call dk_escapeSequences
	
	if not exist DKBatch\functions\dk_printVar.cmd call dk_download %DKHTTP%/dk_printVar.cmd DKBatch\functions\dk_printVar.cmd
	call dk_printVar DKBATCH_DIR
	call dk_printVar DKSCRIPT_PATH
	call dk_printVar DKBATCH_DIR
	call dk_printVar DKSCRIPT_DIR
	call dk_printVar DKSCRIPT_NAME
	
	
	::call dk_exception init
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
	if not exist DKBatch\functions\dk_load.cmd call dk_download %DKHTTP%/dk_load.cmd DKBatch\functions\dk_load.cmd
	call dk_load


	:: SCRIPT_ARGS = %* after %1
	::for /f "tokens=1,* delims= " %%a in ("%*") do set SCRIPT_ARGS=%%b
	::echo SCRIPT_ARGS = %SCRIPT_ARGS%
	if "%DKSCRIPT_DIR%"=="%DKBATCH_DIR%\functions" (
        echo ###### DKTEST MODE ###### %caller[1].func% ###### DKTEST MODE ######
        call :DKTEST
        :DKTEST
        "%caller[1].func%"
        echo ########################## END DKTEST MODE ######################
		
		if not exist DKBatch\functions\dk_exit.cmd call dk_download %DKHTTP%/dk_exit.cmd DKBatch\functions\dk_exit.cmd
        call dk_exit
	)
goto:eof





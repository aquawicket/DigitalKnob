if defined DKINIT ( goto:eof ) else set DKINIT=1

::####################################################################
::# DK()
::#
::#
:DK () {
	echo Loading DigitalKnob . . .

	::############ Script internal setup ############
	set _input=%~dp0..\
	for %%Z in ("%_input%") do set "DKBATCH_DIR=%%~dpZ"
	set DKBATCH_DIR=%DKBATCH_DIR:~0,-1%
	set "PATH=%DKBATCH_DIR%\functions;%PATH%"
	
	if not exist "%DKBATCH_DIR%\functions" ( echo "The DKBATCH_DIR is incorrec!" & goto:eof )
	
::<:dk_getScriptPath_return <nul call dk_getScriptPath DKSCRIPT_PATH   :: same as below in 1 line
	call dk_getScriptPath DKSCRIPT_PATH
	:dk_getScriptPath_return
	
	call dk_getDirectory %DKSCRIPT_PATH% DKSCRIPT_DIR
	call dk_getFilename %DKSCRIPT_PATH% DKSCRIPT_NAME
	call dk_escapeSequences
	call dk_debug DKBATCH_DIR
	call dk_debug DKSCRIPT_PATH
	call dk_debug DKBATCH_DIR
	call dk_debug DKSCRIPT_DIR
	call dk_debug DKSCRIPT_NAME
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
	call dk_load


	:: SCRIPT_ARGS = %* after %1
	::for /f "tokens=1,* delims= " %%a in ("%*") do set SCRIPT_ARGS=%%b
	::echo SCRIPT_ARGS = %SCRIPT_ARGS%
goto:eof	


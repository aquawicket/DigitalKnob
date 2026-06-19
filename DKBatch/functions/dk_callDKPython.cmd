@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ####################################################################
rem # dk_callDKPython(function, arguments...)
rem #
rem #
:dk_callDKPython
%setlocal%

	rem ### Get DKPYTHON_FUNCTIONS_DIR
	%dk_call% dk_validate DKPYTHON_FUNCTIONS_DIR  %dk_call% dk_DKBRANCH_DIR

	rem ### Get DKHTTP_DKPYTHON_FUNCTIONS_DIR
	if NOT defined DKHTTP_DKPYTHON_DIR				(set "DKHTTP_DKPYTHON_DIR=%DKHTTP_DKBRANCH_DIR%/DKJavascript")
	if NOT defined DKHTTP_DKPYTHON_FUNCTIONS_DIR	(set "DKHTTP_DKPYTHON_FUNCTIONS_DIR=%DKHTTP_DKPYTHON_DIR%/functions")

	rem ### Download files if missing
	if NOT EXIST "%DKPYTHON_FUNCTIONS_DIR%/DK.py"	(%dk_call% dk_download "%DKHTTP_DKPYTHON_FUNCTIONS_DIR%/DK.py" "%DKPYTHON_FUNCTIONS_DIR%/DK.py")
	if NOT EXIST "%DKPYTHON_FUNCTIONS_DIR%/%~1.py"	(%dk_call% dk_download "%DKHTTP_DKPYTHON_FUNCTIONS_DIR%/%~1.py" "%DKPYTHON_FUNCTIONS_DIR%/%~1.py")

	rem ### All but first Args ###
	%dk_call% dk_allButFirstArgs %*
	
	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	%dk_call% dk_validate cmd.exe 		%dk_call% dk_findFile cmd.exe
	%dk_call% dk_validate python_exe 	%dk_call% dk_depend python3
	
	rem ############ DKPython function call ############
	set DKPYTHON_COMMAND=%cmd.exe% /V:ON /c call "%python_exe:\=/%" "%DKPYTHON_FUNCTIONS_DIR:\=/%/%1.py" %dk_allButFirstArgs%
	%dk_call% dk_exec %DKPYTHON_COMMAND%
	endlocal & (
		set "dk_callDKPython=%dk_exec%"
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_callDKPython dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKPython = %dk_callDKPython%"
%endfunction%

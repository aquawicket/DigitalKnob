rem shebang
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


rem ################################################################################
::# dk_testReturn(input, output)
::#
::#
:dk_testReturn
%setlocal%

	set "input=%~1"
	set "dk_testReturn=%input:input=output%"

	endlocal & (
		set "dk_testReturn=%dk_testReturn%"
		if "%~2" neq "" (
			set "%~2=%dk_testReturn%"
		) else (
			echo %dk_testReturn%
		)
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	::### Result as return value
	%dk_call% dk_echo
	for /f "usebackq tokens=*" %%G in (`%ComSpec% /V:ON /c call "C:/Users/Administrator/Digital Knob/Development/3rdParty/python3-python-3.11.8-embed-amd64/python.exe" "dk_testReturn.py"`) do (set "dk_testReturn=%%G")
	%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"	
	%dk_call% dk_echo
	
%endfunction%

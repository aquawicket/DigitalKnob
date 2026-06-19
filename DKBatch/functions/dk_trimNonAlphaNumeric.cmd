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


rem ################################################################################
rem # dk_trimNonAlphaNumeric(string)
rem #
rem #	Remove Non-Alphanumeric characters from the front and back of a string
rem #
:dk_trimNonAlphaNumeric
%setlocal%

	set "_input_=%~1"
	set "dk_trimNonAlphaNumeric="
	set "map=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"

	rem echo %_input_:~0,1% 	&rem =a
	rem echo %_input_:~1%   	&rem =bcd
	rem echo %_input_:~-1%  	&rem =d
	rem echo %_input_:~0,-1% 	&rem abc
	:dk_front_loop
		if NOT defined _input_ (goto:dk_front_loop_end)
		for /F "delims=*~ eol=*" %%C in ("%_input_:~0,1%") do (
			if "!map:%%C=!" neq "%map%" (set "continue=1")
			if defined continue (
				set "front=!front!%%C"
			) else (
				set "front=!front!"
			)
		)
		set "_input_=%_input_:~1%"
		goto:dk_front_loop
	:dk_front_loop_end
	

	set "_input_=%front%"
	set "continue="
	:dk_back_loop
		if NOT defined _input_ (goto:dk_back_loop_end)
		for /F "delims=*~ eol=*" %%C in ("%_input_:~-1%") do (
			if "!map:%%C=!" neq "%map%" (set "continue=1")
			if defined continue (
				set "dk_trimNonAlphaNumeric=%%C!dk_trimNonAlphaNumeric!"
			) else (
				set "dk_trimNonAlphaNumeric=!dk_trimNonAlphaNumeric!"
			)
		)
		set "_input_=%_input_:~0,-1%"
		goto:dk_back_loop
	:dk_back_loop_end
	

	:return
	endlocal & (
		set "dk_trimNonAlphaNumeric=%dk_trimNonAlphaNumeric%"
		if "%~2" neq "" (set "%~2=%dk_trimNonAlphaNumeric%")
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	set "myVar=--.0.2.134Beta.--"
	%dk_call% dk_trimNonAlphaNumeric "%myVar%"
	%dk_call% dk_printVar dk_trimNonAlphaNumeric

	rem %dk_call% dk_set myVar "--0.2.134Beta"
	rem %dk_call% dk_trimNonAlphaNumeric "%myVar%" cIdentifier
	rem %dk_call% dk_printVar dk_trimNonAlphaNumeric
	rem %dk_call% dk_printVar cIdentifier
%endfunction%

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
rem # dk_convertToCIdentifier(string rtn_var)
rem #
rem #
:dk_convertToCIdentifier
setlocal enabledelayedexpansion

	set "_input_=%~1"
	set "dk_convertToCIdentifier="
	set "map=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
	
:c_identifier_loop
:c_identifier_loop
		if NOT defined _input_ (goto:c_identifier_endLoop)

		for /F "delims=*~ eol=*" %%C in ("%_input_:~0,1%") do (			
			if "!map:%%C=!" neq "%map%" (set "dk_convertToCIdentifier=!dk_convertToCIdentifier!%%C")
			if "!map:%%C=!" equ "%map%" (set "dk_convertToCIdentifier=!dk_convertToCIdentifier!_")
		)
		set "_input_=%_input_:~1%"
		goto:c_identifier_loop
:c_identifier_endLoop
	
	
	:return
	endlocal & (
		set "dk_convertToCIdentifier=%dk_convertToCIdentifier%"
		if "%~2" neq "" (
			set "%~2=%dk_convertToCIdentifier%"
		) else (
			echo %dk_convertToCIdentifier%
		)
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem Can't handle these characters yet->	[ ] \ ' . / ~ " ? < >
	rem %dk_call% dk_set myVar "a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 ` - = ; , ! @ # $ % ^ & * ( ) _ + { } | :"
	
	set "myVar=a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 ` - = ; , ! @ # $ % ^ & * ( ) _ + { } | :"
	%dk_call% dk_convertToCIdentifier "%myVar%"
	%dk_call% dk_printVar dk_convertToCIdentifier

	set "myVar=a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 ` - = ; , ! @ # $ % ^ & * ( ) _ + { } | :"
	%dk_call% dk_convertToCIdentifier "%myVar%" cIdentifier
	%dk_call% dk_printVar dk_convertToCIdentifier
	%dk_call% dk_printVar cIdentifier
%endfunction%

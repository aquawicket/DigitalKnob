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


rem ############################################################################
rem # dk_setMultiLine()
rem #
rem #
:dk_setMultiLine
%setlocal%

	rem ##### DO NOT ALTER #############
	set NL=^


	rem ##### DO NOT ALTER #############

	if NOT defined flag (set "flag=0")
	for /F "usebackq delims=" %%A in ("%~1") do (
		set "var=%%A"
		if !flag! equ 1 if "!var:endMultiLine=!" neq "!var!" (
		
			rem Replace every new-line by an escaped new-line
			set MyVar=!MyVar:^%NL%%NL%=^^^%NL%%NL%^%NL%%NL%!
			
			rem /* Use a `for` meta-variable rather than a normal environment variable to
			rem    pass the variable value beyond the `endlocal` barrier;
			rem    a standard `for` loop can be used here, because there are NOT going to be
			rem    wildcards `?` and `*` in the variable value since they have already been
			rem    resolved by `dir`; `for /F` cannot be used here due to the new-lines: */
			for %%G in ("!MyVar!") do endlocal & set MyVar=%%~G
			
			goto:endMultiLine
		)
		if !flag! equ 1 (
			rem echo %%A
			if defined MyVar set "MyVar=!MyVar!!NL!"
			set "MyVar=!MyVar!%%A"
		)
		if !flag! equ 0 if "!var:setMultiLine %%0 %~2=!" neq "!var!" (set "flag=1")
	)

%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
 

	%dk_call% dk_setMultiLine %0 MyVar & exit /b 0
line1
line2
line3
	:endMultiLine

	echo %MyVar%

%endfunction%


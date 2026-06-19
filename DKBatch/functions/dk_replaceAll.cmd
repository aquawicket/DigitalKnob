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


rem ##################################################################################
rem # dk_replaceAll(<input>, <searchValue>, <newValue>, <rtn_var>:optional)
rem #
rem #
:dk_replaceAll
%setlocal%

    set "_input_=%~1"
    set "dk_replaceAll=!_input_:%~2=%~3!"
	
	endlocal & (
		set "dk_replaceAll=%dk_replaceAll%"
		if "%~4" neq "" (set "%~4=%dk_replaceAll%")
	)
		
	rem endlocal & (
	rem	%dk_call% dk_set dk_replaceAll "%dk_replaceAll%"
	rem	if "%~4" neq "" (%dk_call% dk_set %~4 "%dk_replaceAll%")
	rem )
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ########
:DKTEST
%setlocal%

	rem replaceAll with result in <dk_replaceAll> variable
    %dk_call% dk_set string_var "AZC AZC Zannana Zread"
    %dk_call% dk_printVar string_var
    %dk_call% dk_replaceAll "%string_var%" "Z" "B"
    %dk_call% dk_printVar dk_replaceAll

	rem replaceAll with result in same variable
	%dk_call% dk_echo
	%dk_call% dk_set string_var "AZC AZC Zannana Zread"
    %dk_call% dk_printVar string_var
    %dk_call% dk_replaceAll "%string_var%" "Z" "B" string_var
    %dk_call% dk_printVar string_var
	
	rem replace back slashes's with forward slashes's
	%dk_call% dk_echo
    %dk_call% dk_set string_var "C:\path\with\backslashes"
	%dk_call% dk_printVar string_var
    %dk_call% dk_replaceAll "%string_var%" "\" "/"
	%dk_call% dk_printVar dk_replaceAll
	
	rem replace _'s with <space>'s
	%dk_call% dk_echo
	%dk_call% dk_set string_var "dk_info('test dk_info message')"
	%dk_call% dk_printVar string_var
	%dk_call% dk_replaceAll "%string_var%" "_" " "
	%dk_call% dk_printVar dk_replaceAll
%endfunction%

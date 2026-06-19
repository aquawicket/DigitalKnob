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
rem # dk_newline()
rem #
rem #    creates a newline variable assigned to %\n%
rem #
:dk_newline
%setlocal%
	
rem ###### METHOD A:  work with !\n!, Can be quoted or unquoted ######
endlocal & (set \n=^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)

rem ###### METHOD B:  only works with %\n% (unquoted) ###
rem ::DO NOT ALTER THE EMPTY LINES BELOW
rem set NLM=^
rem
rem
rem set \n=^^^%NLM%%NLM%^%NLM%%NLM%
rem ::DO NOT ALTER THE EMPTY LINES ABOVE
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_newline

rem	echo.
rem	echo This should display %\n%a new line
rem	echo.
rem	echo "This should display %\n%a new line"
	echo.
	echo This is a sting with !\n!a new line
	echo.
	echo "This is a quoted string with !\n!a new line"
	
%endfunction%
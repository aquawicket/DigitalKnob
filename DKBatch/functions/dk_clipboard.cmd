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
rem # dk_clipboard()
rem #	dk_clipboard(set)
rem #
rem #
:dk_clipboard
%setlocal%

	rem ### SET ###
	if "%~1" neq "" (echo|set/p=%~1|clip)

	rem ###### GET ######
	%dk_call% dk_exec powershell.exe -command Get-Clipboard
	set "dk_clipboard=%dk_exec%"

	
	:return
	endlocal & (
		set "dk_clipboard=%dk_clipboard%"
		if "%~2" neq "" (
			set "%~2=%dk_clipboard%"
		) else (
			echo %dk_clipboard%
		)
	)
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem get the clipboard
	%dk_call% dk_echo "Getting the clipboard . . ."
	%dk_call% dk_clipboard
	%dk_call% dk_echo "dk_clipboard = %dk_clipboard%"

	rem set the clipboard
	%dk_call% dk_echo "Setting the clipboard . . ."
	%dk_call% dk_clipboard "clipboard test"
	%dk_call% dk_echo "dk_clipboard = %dk_clipboard%"

	rem get the clipboard
	%dk_call% dk_echo "Getting the clipboard . . ."
	%dk_call% dk_clipboard
	%dk_call% dk_echo "dk_clipboard = %dk_clipboard%"
%endfunction%
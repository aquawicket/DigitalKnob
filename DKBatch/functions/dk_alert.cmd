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

rem ##############################################################################################################
rem # dk_alert(text)
rem #
:dk_alert
%setlocal%

	set "text=%~1"
	if "%text%" equ "" (set "text=Alert")

	rem ### Method_1 (mshta.exe)
rem	%dk_call% dk_validate mshta.exe %dk_call% dk_findFile mshta.exe
rem	"%mshta.exe%" ^"javascript:^
rem		alert('%text%');^
rem		close();^
rem	^"

	rem ### Method_2 (rundll32.exe)
	rem ### https://www.stormshield.com/news/poweliks-command-line-confusion
	rem #
	%dk_call% dk_validate rundll32.exe %dk_call% dk_findFile rundll32.exe
	"%rundll32.exe%" javascript:"\..\mshtml,RunHTMLApplication ";^
		alert("%text%");^
		close();
	
	
    :return
	endlocal & (
		set dk_alert=!errorlevel!
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_alert "dk_alert message"
	%dk_call% dk_debug "dk_alert = %dk_alert%"
%endfunction%
    
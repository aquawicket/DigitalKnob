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


rem ####################################################################
rem # explorer.exe()
rem #
:DKINSTALL
%setlocal%

	rem ### Test if already valid
	if EXIST "%explorer.exe%" (
rem		"%explorer.exe%" && (
			%return%
rem		)
	)

rem	if NOT EXIST "%explorer.exe%" (set "explorer.exe=%SystemRoot:\=/%/explorer.exe")
	if NOT EXIST "%explorer.exe%" (%dk_call% dk_findFile explorer.exe)

	rem ### Test exists
	if NOT EXIST "%explorer.exe%" (%dk_call% dk_error "explorer.exe:'%explorer.exe%' not found" & %return%)

	rem ### Test command
rem 	"%explorer.exe%" || (
rem 		%dk_call% dk_error "explorer.exe:'%explorer.exe%' failed to run"
rem 		%return%
rem 	)
	

	:return
	rem %dk_call% dk_firewallAllow "%explorer.exe%"	
	endlocal & (
		set "explorer.exe=%explorer.exe:\=/%"
	)
	rem %dk_call% dk_debug "explorer.exe=%explorer.exe%"
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate explorer.exe %dk_call% dk_depend explorer.exe
	%dk_call% dk_debug "explorer.exe = %explorer.exe%"
	
	%dk_call% dk_validate explorer.exe %dk_call% dk_depend explorer.exe
	%dk_call% dk_debug "explorer.exe = %explorer.exe%"
	
	%dk_call% explorer.exe
%endfunction%
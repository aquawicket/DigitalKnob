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
rem # DKINSTALL()
rem #
:DKINSTALL
%setlocal%

	rem ### Test if already valid
	if EXIST "%sudo_exe%" (
		%sudo_exe:/=\% --version 1>nul 2>nul && %return%
	)

	if NOT EXIST "%sudo_exe%" (set "sudo_exe=%SystemRoot:\=/%/System32/sudo.exe")
	if NOT EXIST "%sudo_exe%" (%dk_call% dk_findFile sudo.exe)
	if NOT EXIST "%sudo_exe%" (set "sudo_exe=sudo.exe")

	rem ### Test exists
	if NOT EXIST "%sudo_exe%" (%dk_call% dk_error "sudo_exe:'%sudo_exe%' NOT FOUND" & %return%)
	
	rem ### Test command
	%sudo_exe:/=\% --version 1>nul 2>nul || (%dk_call% dk_error "sudo_exe:'%sudo_exe%' failed to run" & %return%)

	:return
	endlocal & (
		set "sudo_exe=%sudo_exe:\=/%"
	)
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate sudo_exe %dk_call% dk_depend sudo_exe
	%dk_call% dk_echo "sudo_exe = %sudo_exe%"
	
	%dk_call% dk_validate sudo_exe %dk_call% dk_depend sudo_exe
	%dk_call% dk_echo "sudo_exe = %sudo_exe%"
%endfunction%
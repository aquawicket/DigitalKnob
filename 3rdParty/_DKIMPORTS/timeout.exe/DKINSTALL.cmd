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
::# DKINSTALL()
::#
:DKINSTALL
%setlocal%

	"%timeout.exe:/=\%" /? 1>nul 2>nul && (goto:return) || (
		%dk_call% dk_findFile "timeout.exe"
	)
	
	"%timeout.exe:/=\%" /? 1>nul 2>nul && (goto:return) || (
		if NOT EXIST "%timeout.exe%" (
			%dk_call% dk_error "timeout.exe:'%timeout.exe%' NOT FOUND"
		) else (
			%dk_call% dk_error "timeout.exe:'%timeout.exe%' FAILED"
		)
	)

	
	:return
	::%dk_call% dk_firewallAllow "%timeout.exe%"
	endlocal & (
		set "timeout.exe=%timeout.exe:\=/%"
	)
	rem %dk_call% dk_debug "timeout.exe = %timeout.exe%"
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate timeout.exe %dk_call% dk_depend timeout.exe
	%dk_call% dk_debug "timeout.exe = %timeout.exe%"
	
	set "PATH="
	set "timeout.exe="
	%dk_call% dk_validate timeout.exe %dk_call% dk_depend timeout.exe
	%dk_call% dk_debug "timeout.exe = %timeout.exe%"
%endfunction%
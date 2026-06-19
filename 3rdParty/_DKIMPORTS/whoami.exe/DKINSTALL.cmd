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
::# whoami.exe
::#
:DKINSTALL
%setlocal%

	"%whoami.exe:/=\%" /? 1>nul 2>nul && (goto:return) || (
		%dk_call% dk_findFile "whoami.exe"
	)
	
	"%whoami.exe:/=\%" /? 1>nul 2>nul && (goto:return) || (
		if NOT EXIST "%whoami.exe%" (
			%dk_call% dk_error "whoami.exe:'%whoami.exe%' NOT FOUND"
		) else (
			%dk_call% dk_error "whoami.exe:'%whoami.exe%' FAILED"
		)
	)

	
	:return
	::%dk_call% dk_firewallAllow "%whoami.exe%"
	endlocal & (
		set "whoami.exe=%whoami.exe:\=/%"
	)
	rem %dk_call% dk_debug "whoami.exe = %whoami.exe%"
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate whoami.exe %dk_call% dk_depend whoami.exe
	%dk_call% dk_debug "whoami.exe = %whoami.exe%"
	
	set "PATH="
	set "whoami.exe="
	%dk_call% dk_validate whoami.exe %dk_call% dk_depend whoami.exe
	%dk_call% dk_debug "whoami.exe = %whoami.exe%"
%endfunction%
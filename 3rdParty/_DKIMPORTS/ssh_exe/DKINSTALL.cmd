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

	"%ssh.exe:/=\%" -V 1>nul 2>nul && (goto:return) || (
		%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
		%dk_call% dk_findFile "ssh.exe" "!SystemRoot!"
	)
	
	"%ssh.exe:/=\%" -V 1>nul 2>nul && (goto:return) || (
		if NOT EXIST "%ssh.exe%" (
			%dk_call% dk_error "ssh.exe:'%ssh.exe%' NOT FOUND"
		) else (
			%dk_call% dk_error "ssh.exe:'%ssh.exe%' FAILED"
		)
	)

	
	:return
	%dk_call% dk_firewallAllow "%ssh.exe%"
	endlocal & (
		set "ssh.exe=%ssh.exe:\=/%"
	)
	rem %dk_call% dk_debug "ssh.exe = %ssh.exe%"
%endfunction%












rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate ssh.exe %dk_call% dk_depend ssh_exe
	%dk_call% dk_debug "ssh.exe = %ssh.exe%"
	
	set "PATH="
	set "ssh.exe="
	%dk_call% dk_validate ssh.exe %dk_call% dk_depend ssh_exe
	%dk_call% dk_debug "ssh.exe = %ssh.exe%"
%endfunction%
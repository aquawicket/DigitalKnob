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

	%wsl_exe:/=\% --status 1>nul 2>nul || (set "wsl_exe=%SystemRoot:\=/%/System32/wsl.exe")
	%wsl_exe:/=\% --status 1>nul 2>nul || (%dk_call% dk_findFile wsl.exe)
	%wsl_exe:/=\% --status 1>nul 2>nul || (set "wsl_exe=wsl.exe")

	%wsl_exe% --status 1>nul 2>nul || (
		if NOT EXIST %wsl_exe% (
			%dk_call% dk_error "wsl_exe:'%wsl_exe%' NOT FOUND"
		) else (
			%dk_call% dk_error "wsl_exe:'%wsl_exe%' FAILED"
		)
		%return%
	)

	:return
	endlocal & (
		set "wsl_exe=%wsl_exe:\=/%"
	)
	%dk_call% dk_debug "wsl_exe = %wsl_exe%"
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate wsl_exe %dk_call% dk_depend wsl_exe
	%dk_call% dk_echo "wsl_exe = %wsl_exe%"
	
	%dk_call% dk_validate wsl_exe %dk_call% dk_depend wsl_exe
	%dk_call% dk_echo "wsl_exe = %wsl_exe%"
%endfunction%
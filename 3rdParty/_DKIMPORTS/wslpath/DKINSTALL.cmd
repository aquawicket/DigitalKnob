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

	%dk_call% dk_validate wsl.exe %dk_call% dk_depend wsl.exe
	
	%wslpath:/=\% C:/ 1>nul 2>nul || (set "wslpath=%wsl.exe% wslpath")
	%wslpath:/=\% C:/ 1>nul 2>nul || (set "wslpath=%SystemRoot:\=/%/System32/wsl.exe wslpath")
	%wslpath:/=\% C:/ 1>nul 2>nul || (
		if NOT FOUND "%wsl.exe%" (
			%dk_call% dk_error "wslpath:'%wsl.exe%' NOT FOUND"
		) else (
			%dk_call% dk_error "wslpath:'%wslpath%' FAILED"
		)
		%return%
	)

	:return
	endlocal & (
		set "wslpath=%wslpath:\=/%"
	)
	%dk_call% dk_debug "wslpath = %wslpath%"
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate wslpath %dk_call% dk_depend wslpath
	%dk_call% dk_echo "wslpath = %wslpath%"
	
	%dk_call% dk_validate wslpath %dk_call% dk_depend wslpath
	%dk_call% dk_echo "wslpath = %wslpath%"
%endfunction%
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

	"%cmd.exe:/=\%" /c ver 1>nul 2>nul && (
	goto:return) || (
		set "cmd.exe=%ComSpec:\=/%"
	)
	
	"%cmd.exe:/=\%" /c ver 1>nul 2>nul && (
	goto:return) || (
		echo false & %dk_call% dk_findFile cmd.exe
	)
	
	:test
	"%cmd.exe:/=\%" /c ver 1>nul 2>nul && (
	goto:return) || (
		if "%cmd.exe%" exist (
			%dk_call% dk_error "cmd.exe:'%cmd.exe%' FAILED"
		) else (
			%dk_call% dk_error "cmd.exe:'%cmd.exe%' NOT FOUND"
		)
		%return% 1
	)

	:return
	endlocal & (
		set "cmd.exe=%cmd.exe:\=/%"
	)
	rem %dk_call% dk_debug "cmd.exe = %cmd.exe%"
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	set "cmd.exe="
	%dk_call% dk_validate cmd.exe %dk_call% dk_depend cmd.exe
	%dk_call% dk_debug "cmd.exe = '%cmd.exe%'"
	%cmd.exe:/=\% /c ver
	
	set "cmd.exe="
	%dk_call% dk_validate cmd.exe %dk_call% dk_depend cmd.exe
	%dk_call% dk_debug "cmd.exe = '%cmd.exe%'"
	%dk_call% cmd.exe /c ver
%endfunction%
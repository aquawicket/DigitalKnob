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


rem ############ reg.exe ############
rem #
:DKINSTALL
%setlocal%

	
	set "reg.exe=%reg.exe:reg.exe%=%"
	%dk_start% "!reg.exe:/=\!" /? 1>nul 2>nul && (
		goto:return) || (
			%dk_call% dk_findFile reg.exe
			rem %dk_call% dk_findFile reg.exe "%DKTOOLS_DIR%"
		)
		
	%dk_start% "!reg.exe:/=\!" /? 1>nul 2>nul && (
		goto:return) || (
			if exist "!reg.exe!" (
				%dk_call% dk_error "reg.exe:'%reg.exe%' FAILED"
			) else (
				%dk_call% dk_error "reg.exe:'%reg.exe%' NOT FOUND"
			)
			%endfunction%
		)
	
	:return
	rem	%dk_call% dk_firewallAllow "%reg.exe%"
	endlocal & (
		set "reg.exe=%reg.exe%"
	)
	rem %dk_call% dk_debug "reg.exe = %reg.exe%"
%endfunction%









rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	echo.
	echo ###### Test dk_call reg.exe ######
	set "reg.exe="
	%dk_call% reg.exe "/?"
	
	echo.
	echo ####### Test dk_depend reg.exe ######
	set "reg.exe="
	%dk_call% dk_validate reg.exe %dk_call% dk_depend reg.exe
	%dk_start% "%reg.exe:/=\%" /?

%endfunction%

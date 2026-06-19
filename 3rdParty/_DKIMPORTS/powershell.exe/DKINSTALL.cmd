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
echo 20
	"%powershell.exe:/=\%" -Command 'exit' 1>nul 2>nul && (goto:return) || (
echo 22
		%dk_call% dk_findFile powershell.exe
	)
echo 24
	"%powershell.exe:/=\%" -Command 'exit' 1>nul 2>nul && (goto:return) || (
		%dk_call% dk_validate pwsh %dk_call% dk_depend pwsh
		set "powershell.exe=%pwsh_exe%"
	)
echo 29	
	"%powershell.exe:/=\%" -Command 'exit' 1>nul 2>nul && (goto:return) || (
		if NOT EXIST "%powershell.exe%" (
			%dk_call% dk_error "powershell.exe:'%powershell.exe%' NOT FOUND"
		) else (
			%dk_call% dk_error "powershell.exe:'%powershell.exe%' FAILED"
		)
	)

	
	:return
	rem %dk_call% dk_firewallAllow "%powershell.exe%"
	endlocal & (
		set "powershell.exe=%powershell.exe:\=/%"
	)
	rem %dk_call% dk_debug "powershell.exe = %powershell.exe%"
%endfunction%








rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate powershell.exe %dk_call% dk_depend powershell.exe
	%dk_call% dk_debug "powershell.exe = %powershell.exe%"
	
	set "powershell.exe="
	set "PATH="
	%dk_call% dk_validate powershell.exe %dk_call% dk_depend powershell.exe
	%dk_call% dk_debug "powershell.exe = %powershell.exe%"
%endfunction%
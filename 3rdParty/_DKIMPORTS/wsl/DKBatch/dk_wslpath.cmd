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


rem ############################################################################
::# dk_wslpath(win_path rtn_var:optional)
::#
::#
:dk_wslpath
%setlocal%
 

	%dk_call% dk_validate wsl.exe %dk_call% dk_depend wsl.exe
	if NOT defined wslpath (
		%dk_call% dk_exec %wsl.exe% which wslpath
		set "wslpath=%wsl.exe% !dk_exec!"
	)
	
	%dk_call% dk_debug "wslpath = %wslpath%"
	%dk_call% dk_exec %wslpath% -u %~1
	set "dk_wslpath=%dk_exec%"
	
	:return
	endlocal & (
		set "dk_wslpath=%dk_wslpath%"
		if "%~2" neq "" (
			set "%~2=%dk_wslpath%"
		) else (
			echo %dk_wslpath%
		)
	)
	
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_wslpath "C:\\Windows\\notepad.exe" notepad_exe_wsl
	%dk_call% dk_echo "dk_wslpath = %dk_wslpath%"
	%dk_call% dk_echo "notepad_exe_wsl = %notepad_exe_wsl%"
%endfunction%


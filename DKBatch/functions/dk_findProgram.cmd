@rem shebang
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


rem ################################################################################
rem dk_findProgram(<var> name [path1 path2 ...])
rem 
:dk_findProgram
%setlocal%
	
	%dk_call% dk_getParameterValue NO_ERROR %*
	if defined NO_ERROR (
		set "dk_exec_NO_ERROR=1"
	)
	
	for /f "tokens=*" %%G in ("%~1") do (set _var_=%%~G)

	if defined %~1 for /f "tokens=*" %%G in ("!%~1!") do (set _val_=%%~G)
	if EXIST "%_val_%" (%return%)
	
	for /f "tokens=*" %%G in ("%~2") do set "_filename_=%%~G"
	for /f "tokens=*" %%G in ("%~3") do set "_pattern_=%%~G"
	set "_recursive_="
	if defined _pattern_ (
		set "_pattern_=%_pattern_:/=\%"
		set "_recursive_=/R"
	)

	set "where.exe=%SystemRoot%\System32\where.exe"
	if defined _pattern_ (
		%dk_call% dk_exec %where.exe% %_recursive_% %_pattern_% %_filename_% 2>nul
	) else (
		%dk_call% dk_exec %where.exe% %_filename_% 2>nul
	)
	rem %checkerror%
	set "dk_findProgram=%dk_exec:\=/%"

	if NOT EXIST "%dk_exec%" (
		if /i "%~4" equ "NO_ERROR" (
			%dk_call% dk_return 0
		) else if /i "%~4" equ "NO_HALT" (
			%dk_call% dk_return 0 "%_filename_% NOT found"
		) else (
			%dk_call% dk_return -1 "%_filename_% NOT found"
		)
	)

	:return
	endlocal & (
		set "dk_findProgram=%dk_findProgram%"
		set "%~1=%dk_findProgram%"
	)
%endfunction%










rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_echo
	%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
	%dk_call% dk_findProgram pwsh_exe "pwsh.exe" "%DKTOOLS_DIR%"
	%dk_call% dk_echo "pwsh_exe = %pwsh_exe%"

	%dk_call% dk_echo
	%dk_call% dk_findProgram powershell.exe "powershell.exe" "%SystemRoot%/System32"
	%dk_call% dk_echo "powershell.exe = %powershell.exe%"

	%dk_call% dk_echo
	%dk_call% dk_findProgram cmd.exe "cmd.exe" "%SystemRoot%/System32"
	%dk_call% dk_echo "cmd.exe = %cmd.exe%"

	%dk_call% dk_echo
	%dk_call% dk_findProgram cmd.exe "cmd.exe"
	%dk_call% dk_echo "cmd.exe = %cmd.exe%"
	
	%dk_call% dk_echo
	%dk_call% dk_findProgram notepadpp_exe "notepad++.exe" "%ProgramFiles%"
	%dk_call% dk_echo "notepadpp_exe = %notepadpp_exe%"

	%dk_call% dk_echo
	%dk_call% dk_findProgram wsl.exe "wsl.exe" "%SystemRoot%/System32" 
	%dk_call% dk_echo "wsl.exe = %wsl.exe%"
%endfunction%

@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
:: dk_findProgram(<var> name [path1 path2 ...])
::
:dk_findProgram
%setlocal%
	%dk_call% dk_debugFunc 2 9
	
	%dk_call% dk_getParameterValue NO_ERROR %*
	if defined NO_ERROR (set "dk_exec_NO_ERROR=1")
	
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

	if defined _pattern_ (
		%dk_call% dk_exec where %_recursive_% "%_pattern_%" %_filename_% 2>nul
	) else (
		%dk_call% dk_exec where %_filename_% 2>nul
	)
	::%checkerror%
	set "dk_findProgram=%dk_exec:\=/%"

	if NOT EXIST "%dk_exec%" (
		if "%~4" equ "NO_ERROR" (
			%dk_call% dk_return 0
		) else if "%~4" equ "NO_HALT" (
			%dk_call% dk_return 0 "%_filename_% NOT found"
		) else (
			%dk_call% dk_return -1 "%_filename_% NOT found"
		)
	)

	endlocal & (
		set "%~1=%dk_findProgram%"
	)	
%endfunction%










::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_echo
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_findProgram PWSH_EXE "pwsh.exe" "%DKTOOLS_DIR%"
	%dk_call% dk_echo "PWSH_EXE = %PWSH_EXE%"

	%dk_call% dk_echo
	%dk_call% dk_findProgram POWERSHELL_EXE "powershell.exe" "%windir%/System32"
	%dk_call% dk_echo "POWERSHELL_EXE = %POWERSHELL_EXE%"

	%dk_call% dk_echo
	%dk_call% dk_findProgram CMD_EXE "cmd.exe" "%windir%/System32"
	%dk_call% dk_echo "CMD_EXE = %CMD_EXE%"

	%dk_call% dk_echo
	%dk_call% dk_findProgram CMD_EXE "cmd.exe"
	%dk_call% dk_echo "CMD_EXE = %CMD_EXE%"
	
	%dk_call% dk_echo
	%dk_call% dk_findProgram NOTEPADPP_EXE "notepad++.exe" "%ProgramFiles%"
	%dk_call% dk_echo "NOTEPADPP_EXE = %NOTEPADPP_EXE%"

	%dk_call% dk_echo
	%dk_call% dk_findProgram WSL_EXE "wsl.exe" "%windir%/System32" 
	%dk_call% dk_echo "WSL_EXE = %WSL_EXE%"
%endfunction%

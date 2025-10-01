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

	if defined _pattern_ (
		%dk_call% dk_exec where %_recursive_% "%_pattern_%" %_filename_% 2>nul
	) else (
		%dk_call% dk_exec where %_filename_% 2>nul
	)
	::%checkerror%
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

	::###### output ######
	endlocal & (
		set "%~1=%dk_findProgram%"
		set "dk_findProgram=%dk_findProgram%"
		echo %dk_findProgram%
	)
%endfunction%










::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_echo
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_findProgram pwsh_exe "pwsh.exe" "%DKTOOLS_DIR%"
	%dk_call% dk_echo "pwsh_exe = %pwsh_exe%"

	%dk_call% dk_echo
	%dk_call% dk_findProgram powershell_exe "powershell.exe" "%windir%/System32"
	%dk_call% dk_echo "powershell_exe = %powershell_exe%"

	%dk_call% dk_echo
	%dk_call% dk_findProgram cmd_exe "cmd.exe" "%windir%/System32"
	%dk_call% dk_echo "cmd_exe = %cmd_exe%"

	%dk_call% dk_echo
	%dk_call% dk_findProgram cmd_exe "cmd.exe"
	%dk_call% dk_echo "cmd_exe = %cmd_exe%"
	
	%dk_call% dk_echo
	%dk_call% dk_findProgram notepadpp_exe "notepad++.exe" "%ProgramFiles%"
	%dk_call% dk_echo "notepadpp_exe = %notepadpp_exe%"

	%dk_call% dk_echo
	%dk_call% dk_findProgram wsl_exe "wsl.exe" "%windir%/System32" 
	%dk_call% dk_echo "wsl_exe = %wsl_exe%"
%endfunction%

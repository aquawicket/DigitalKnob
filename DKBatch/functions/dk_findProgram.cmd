@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
:: dk_findProgram(<var> name [path1 path2 ...])
::
:dk_findProgram
%setlocal%
	%dk_call% dk_debugFunc 2 9

	for /F %%G IN ("%~1") do set _var_=%%~G
	::echo _var_ = %_var_%
	
	for /F %%G IN ("!%_var_%!") do set _val_=%%~G
	::echo _val_ = %_val_%

	::set "_val_=!%_var_%!"
	if exist "%_val_%" (
		dk_return "dk_findProgram: %_var_% already set"
	)

	for /F %%G IN ("%~2") do set _filename_=%%~G
	::echo _filename_ = %_filename_%
	
	for /F %%G IN ("%~3") do set _pattern_=%%~G
	
	set "_recursive_="
	if defined _pattern_ (
		set "_pattern_=%_pattern_:/=\%"
		set "_recursive_=/R"
	)
	::echo _pattern_ = %_pattern_%
	::echo _recursive_ = %_recursive_%

	%dk_call% dk_exec where %_recursive_% "%_pattern_%" "%_filename_%" 2>nul

	if not exist "%dk_exec%" (
		if "%~4" equ "NO_ERROR" (
			dk_return
		) else if "%~4" equ "NO_HALT" (
			dk_return "%_filename_% not found"
		) else (
			dk_return -1 "%_filename_% not found"
		)
	)
	::echo dk_exec = %dk_exec%

	for %%G in ("%dk_exec%") do (set dk_exec="%%~fG")   &:: get the real path
	set "dk_findProgram=%dk_exec:\=/%"
	if "%~4" neq "NO_ERROR" (
		%dk_call% dk_assertPath "%dk_findProgram%"
	)

	endlocal & (
		set "%~1=%dk_findProgram%"
	)
%endfunction%










::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	

	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_findProgram PWSH_EXE "pwsh.exe" "%DKTOOLS_DIR%" || %dk_call% dk_printLastError
	%dk_call% dk_printVar PWSH_EXE

	%dk_call% dk_findProgram POWERSHELL_EXE "powershell.exe" "%windir%\System32" || %dk_call% dk_printLastError
	%dk_call% dk_printVar POWERSHELL_EXE

	%dk_call% dk_findProgram CMD_EXE "cmd.exe" "%windir:\=/%/System32" || %dk_call% dk_printLastError
	%dk_call% dk_printVar CMD_EXE

	%dk_call% dk_findProgram CMD_EXE "cmd.exe" || %dk_call% dk_printLastError
	%dk_call% dk_printVar CMD_EXE
	
	%dk_call% dk_findProgram NOTEPADPP_EXE "notepad++.exe" "%ProgramFiles%" || %dk_call% dk_printLastError
	%dk_call% dk_printVar NOTEPADPP_EXE

	%dk_call% dk_findProgram WSL_EXE "wsl.exe" "%windir:\=/%/System32" || %dk_call% dk_printLastError
	%dk_call% dk_printVar WSL_EXE
%endfunction%

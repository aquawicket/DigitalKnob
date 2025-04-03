@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
:: dk_findProgram(<var> name [path1 path2 ...])
::
:dk_findProgram
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 2 9

	set "_var_=%~1"
	set "_val_=!%_var_%!"
	if exist "%_val_%" (
		dk_return "dk_findProgram: %_var_% already set"
	)

	set "_filename_=%~2"
	set "_pattern_=%~3"
	set "_recursive_="
	if defined _pattern_ (
		set "_pattern_=%_pattern_:/=\%"
		set "_recursive_=/R"
	)

	%dk_call% dk_commandToVariable where %_recursive_% "%_pattern_%" "%_filename_%" 2>nul
	if not defined dk_commandToVariable (
		dk_return -1 "%_filename_% not found"
	)

	%dk_call% dk_assertPath "%dk_commandToVariable:\=/%"
	set "dk_findProgram=%dk_commandToVariable:\=/%"

	
	endlocal & (
		set "%~1=%dk_findProgram%"
	)
	dk_return
%endfunction%










::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 0
	

	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_findProgram PWSH_EXE "pwsh.exe" "%DKTOOLS_DIR%" || %dk_call% dk_printLastError
	%dk_call% dk_printVar PWSH_EXE

	%dk_call% dk_findProgram POWERSHELL_EXE "powershell.exe" || %dk_call% dk_printLastError
	%dk_call% dk_printVar POWERSHELL_EXE

	%dk_call% dk_findProgram CMD_EXE "cmd.exe" "C:/Windows/System32" || %dk_call% dk_printLastError
	%dk_call% dk_printVar CMD_EXE

	%dk_call% dk_findProgram CMD_EXE "cmd.exe" || %dk_call% dk_printLastError
	%dk_call% dk_printVar CMD_EXE
	
	%dk_call% dk_findProgram NOTEPADPP_EXE "notepad++.exe" "%ProgramFiles%" || %dk_call% dk_printLastError
	%dk_call% dk_printVar NOTEPADPP_EXE

%endfunction%

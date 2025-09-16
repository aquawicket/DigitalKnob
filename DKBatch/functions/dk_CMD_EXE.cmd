@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_CMD_EXE()
::#
::#
:dk_CMD_EXE
	%dk_call% dk_warning "dk_CMD_EXE is deprecated.  use %%dk_call%% dk_depend cmake"
	%dk_call% dk_validate cmd_exe "%dk_call% dk_depend cmd"
	%return%
	
%setlocal%
	%dk_call% dk_debugFunc 0

	if EXIST "%cmd_exe%" (%return%)

	::###### FIX ComSpec system environment varioble case ######
	for %%A in ("%ComSpec%") do (
		if "%ComSpec%" neq "%%~fA" (
			set "ComSpec=%%~fA"
			setx /M ComSpec "%%~fA"
		)
	)
	
	set "cmd_exe=%ComSpec:\=/%"
	if NOT EXIST "%cmd_exe%" (%dk_call% dk_findProgram cmd_exe "cmd.exe" "%windir%")
	
	%dk_call% dk_assertPath "%cmd_exe:\=/%"

	endlocal & (
		set "cmd_exe=%cmd_exe:\=/%"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_CMD_EXE
	%dk_call% dk_printVar cmd_exe
%endfunction%

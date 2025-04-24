@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_CMD_EXE()
::#
::#
:dk_CMD_EXE
setlocal
	%dk_call% dk_debugFunc 0

	if exist "%CMD_EXE%" (%return%)

	::###### FIX ComSpec system environment varioble case ######
	for %%A in ("%ComSpec%") do (
		if "%ComSpec%" neq "%%~fA" (
			set "ComSpec=%%~fA"
			setx /M ComSpec "%%~fA"
		)
	)
	
	set "CMD_EXE=%ComSpec:\=/%"
	if not exist "%CMD_EXE%" (%dk_call% dk_findProgram CMD_EXE "cmd.exe" "%WINDIR:\=/%")
	
	%dk_call% dk_assertPath "%CMD_EXE:\=/%"

	endlocal & (
		set "CMD_EXE=%CMD_EXE:\=/%"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_CMD_EXE
	%dk_call% dk_printVar CMD_EXE
%endfunction%

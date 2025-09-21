@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
%setlocal%
	%dk_call% dk_debugFunc 0

	if NOT defined "%cmd_exe%" (set "cmd_exe=cmd.exe")
	
	::### Test if already valid
	if EXIST "%cmd_exe%" (%cmd_exe:/=\% /c ver 1>nul 2>nul & %return%)

	if NOT EXIST "%cmd_exe%" (set "cmd_exe=%windir:\=/%/System32/cmd.exe")
	if NOT EXIST "%cmd_exe%" (%dk_call% dk_findProgram cmd_exe "cmd.exe")
	if NOT EXIST "%cmd_exe%" (set "cmd_exe=cmd.exe")
	

	::### Test exists
	if NOT EXIST "%cmd_exe%" (%dk_call% dk_error "cmd_exe:%cmd_exe% not found" & %return%)
	
	::### Test command
	"%cmd_exe:/=\%" /c ver 1>nul 2>nul || (%dk_call% dk_error "cmd_exe:%cmd_exe% failed to run" & %return%)

	endlocal & (set "cmd_exe=%cmd_exe:\=/%")
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate cmd_exe "%dk_call% dk_depend cmd_exe"
	%dk_call% dk_echo "cmd_exe = %cmd_exe%"
	
	%dk_call% dk_validate cmd_exe "%dk_call% dk_depend cmd_exe"
	%dk_call% dk_echo "cmd_exe = %cmd_exe%"
%endfunction%
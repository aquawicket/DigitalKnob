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

	::### Test if already valid
	if EXIST "%wsl_exe%" ("%wsl_exe%" --status 1>nul 2>nul && %return%)


	if NOT EXIST "%wsl_exe%" (set "wsl_exe=%windir:\=/%/System32/wsl.exe")
	if NOT EXIST "%wsl_exe%" (%dk_call% dk_findProgram wsl_exe "wsl.exe")
	if NOT EXIST "%wsl_exe%" (set "wsl_exe=wsl.exe")

	
	::### Test exists
	if NOT EXIST "%wsl_exe%" (%dk_call% dk_error "wsl_exe:%wsl_exe% not found" && %return%)
	
	::### Test command
	%wsl_exe% --status 1>nul 2>nul || (%dk_call% dk_error "wsl_exe:%wsl_exe% failed to run" && %return%)

	endlocal & (
		set "wsl_exe=%wsl_exe:\=/%"
	)
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate wsl_exe "%dk_call% dk_depend wsl_exe"
	%dk_call% dk_echo "wsl_exe = %wsl_exe%"
	
	%dk_call% dk_validate wsl_exe "%dk_call% dk_depend wsl_exe"
	%dk_call% dk_echo "wsl_exe = %wsl_exe%"
%endfunction%
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
	if EXIST "%wslpath_exe%" ("%wslpath_exe%" --status 1>nul 2>nul && %return%)


	if NOT EXIST "%wslpath_exe%" (set "wslpath_exe=%windir:\=/%/System32/wslpath.exe")
	if NOT EXIST "%wslpath_exe%" (%dk_call% dk_findProgram wslpath_exe "wslpath.exe")
	if NOT EXIST "%wslpath_exe%" (set "wslpath_exe=wslpath.exe")

	
	::### Test exists
	if NOT EXIST "%wslpath_exe%" (%dk_call% dk_error "wslpath_exe:%wslpath_exe% not found" && %return%)
	
	::### Test command
	%wslpath_exe% --status 1>nul 2>nul || (%dk_call% dk_error "wslpath_exe:%wslpath_exe% failed to run" && %return%)

	endlocal & (
		set "wslpath_exe=%wslpath_exe:\=/%"
	)
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate wslpath_exe "%dk_call% dk_depend wslpath_exe"
	%dk_call% dk_echo "wslpath_exe = %wslpath_exe%"
	
	%dk_call% dk_validate wslpath_exe "%dk_call% dk_depend wslpath_exe"
	%dk_call% dk_echo "wslpath_exe = %wslpath_exe%"
%endfunction%
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
	if EXIST "%sudo_exe%" (
		%sudo_exe% --version 1>nul 2>nul && %return%
	)

	if NOT EXIST "%sudo_exe%" (set "sudo_exe=%windir:\=/%/System32/sudo.exe")
	if NOT EXIST "%sudo_exe%" (%dk_call% dk_findProgram sudo_exe "sudo.exe")
	if NOT EXIST "%sudo_exe%" (set "sudo_exe=sudo.exe")

	::### Test exists
	if NOT EXIST "%sudo_exe%" (%dk_call% dk_error "sudo_exe:%sudo_exe% not found" & %return%)
	
	::### Test command
	%sudo_exe% --version 1>nul 2>nul || (%dk_call% dk_error "sudo_exe:%sudo_exe% failed to run" & %return%)

	endlocal & (
		set "sudo_exe=%sudo_exe:\=/%"
	)
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate sudo_exe "%dk_call% dk_depend sudo_exe"
	%dk_call% dk_echo "sudo_exe = %sudo_exe%"
	
	%dk_call% dk_validate sudo_exe "%dk_call% dk_depend sudo_exe"
	%dk_call% dk_echo "sudo_exe = %sudo_exe%"
%endfunction%
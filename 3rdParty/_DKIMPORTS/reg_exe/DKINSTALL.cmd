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

	if EXIST "%reg_exe%" (%return%)

	if NOT EXIST "%reg_exe%" (set "reg_exe=%windir:\=/%/System32/reg.exe")
	if NOT EXIST "%reg_exe%" (%dk_call% dk_findProgram reg_exe "reg.exe")
	if NOT EXIST "%reg_exe%" (set "reg_exe=reg.exe")
	
	::### Test reg_exe
	%reg_exe% /? 1>nul 2>nul || (
		%dk_call% dk_error "reg_exe:%reg_exe% failed to run"
		%return%
	)

	endlocal & (
		set "reg_exe=%reg_exe:\=/%"
	)
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate reg_exe "%dk_call% dk_depend reg_exe"
	%dk_call% dk_echo "reg_exe = %reg_exe%"
%endfunction%
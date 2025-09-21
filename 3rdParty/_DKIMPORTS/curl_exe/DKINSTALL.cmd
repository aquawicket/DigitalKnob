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

	if EXIST "%curl_exe%" (%return%)

	if NOT EXIST "%curl_exe%" (set "curl_exe=%windir:\=/%/System32/curl.exe")
	if NOT EXIST "%curl_exe%" (%dk_call% dk_findProgram curl_exe "curl.exe")
	
	%curl_exe% --version || (
		%dk_call% dk_error "curl_exe:%curl_exe% failed to run"
		%return%
	)

	endlocal & (
		set "curl_exe=%curl_exe:\=/%"
	)
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate curl_exe "%dk_call% dk_depend curl_exe"
	%dk_call% dk_echo "curl_exe = %curl_exe%"
%endfunction%
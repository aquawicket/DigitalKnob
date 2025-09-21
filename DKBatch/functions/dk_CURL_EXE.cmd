@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_curl_exe()
::#
::#
:dk_curl_exe
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_notice "dk_CURL_EXE is obsolete.  use dk_depend curl_exe"
		
	if defined curl_exe (%return%)
	%dk_call% dk_validate curl_exe "%dk_call% dk_depend curl_exe"
	
	endlocal & (
		set "curl_exe=%curl_exe%"
	)
	
	%return%

	set "curl_exe=%windir:\=/%/System32/curl.exe"
	if NOT EXIST "%curl_exe%" (%dk_call% dk_findProgram curl_exe "curl.exe" "%windir%/System32")
	%dk_call% dk_assertPath "%curl_exe%"
	
	endlocal & (
		set "curl_exe=%curl_exe%"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_curl_exe
	%dk_call% dk_echo "curl_exe = %curl_exe%"
%endfunction%

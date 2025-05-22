@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_CURL_EXE()
::#
::#
:dk_CURL_EXE
%setlocal%
	%dk_call% dk_debugFunc 0

	if defined CURL_EXE (%return%)

	set "CURL_EXE=%WINDIR:\=/%/System32/curl.exe"
	if not exist "%CURL_EXE%" (%dk_call% dk_findProgram CURL_EXE "curl.exe" "%WINDIR:\=/%/System32")
	%dk_call% dk_assertPath "%CURL_EXE%"
	
	endlocal & (
		set "CURL_EXE=%CURL_EXE%"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_CURL_EXE
	%dk_call% dk_echo "CURL_EXE = %CURL_EXE%"
%endfunction%

@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_title(string)
::#
::#
:dk_title
%setlocal%
	%dk_call% dk_debugFunc 0 99

	::############ SET ############
	if "%~1" neq "" (
		set "dk_title=%~1"
		title !dk_title!
	
	rem ############ GET ############
	) else (
		rem TODO
		echo %dk_title%
	)
	
	::###### output ######
	endlocal & (
		set "dk_title=%dk_title%"
	)
	
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::### SET ###
	%dk_call% dk_title "------------DKBatch: dk_title TEST 1 .............."
	
	::### GET ###
	%dk_call% dk_title
	%dk_call% dk_echo "dk_title = %dk_title%"
	%dk_call% dk_pause
	
	
	::### SET ###
    %dk_call% dk_title "------------DKBatch: dk_title TEST 2 .............."
	
	::### GET ###
	%dk_call% dk_title
	%dk_call% dk_echo "dk_title = %dk_title%"
	%dk_call% dk_pause
	
	
	::### SET ###
	%dk_call% dk_title "------------DKBatch: dk_title TEST 3 .............."
	
	::### GET ###
	%dk_call% dk_title
	%dk_call% dk_echo "dk_title = %dk_title%"
	%dk_call% dk_pause
%endfunction%

@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_callDKJavascript(function, arguments...)
::#
::#
:dk_callDKJava
%setlocal%
	%dk_call% dk_debugFunc 1 99

	set "_func_=%~1"
	set "_path_=%DKJAVA_FUNCTIONS_DIR:\=/%/%_func_%.java"
	
	::### Get DKJAVA_FUNCTIONS_DIR
	%dk_call% dk_validate DKJAVA_FUNCTIONS_DIR  "%dk_call% dk_DKBRANCH_DIR"
	
	::### Get DKHTTP_DKJAVA_FUNCTIONS_DIR
	if NOT defined DKHTTP_DKJAVA_DIR			(set "DKHTTP_DKJAVA_DIR=%DKHTTP_DKBRANCH_DIR%/DKJavas")
	if NOT defined DKHTTP_DKJAVA_FUNCTIONS_DIR	(set "DKHTTP_DKJAVA_FUNCTIONS_DIR=%DKHTTP_DKJAVA_DIR%/functions")
	
	::### Download files if missing
	if NOT EXIST "%DKJAVA_FUNCTIONS_DIR%/DK.js"	(%dk_call% dk_download "%DKHTTP_DKJAVA_FUNCTIONS_DIR%/DK.js"  "%DKJAVA_FUNCTIONS_DIR%/DK.js")
	if NOT EXIST "%_path_%"						(%dk_call% dk_download "%DKHTTP_DKJAVA_FUNCTIONS_DIR%/%~1.js" "%_path_%")

	%dk_call% dk_allButFirstArgs %*
	
	%dk_call% dk_validate JAVA_EXE "%dk_call% dk_JAVA_EXE.cmd"
	set DKCOMMAND=%ComSpec% /c %JAVAC_EXE%  %DKJAVA_FUNCTIONS_DIR%/DK.js; %DKJAVA_FUNCTIONS_DIR%/%1.js; %ALL_BUT_FIRST%
	
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_callDKJava=%dk_exec%"
		set "%_func_%=%dk_exec%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_echo
	%dk_call% dk_callDKJava dk_testReturn inputA
	%dk_call% dk_echo "dk_callDKJava = %dk_callDKJava%"
	%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"
	%dk_call% dk_echo
	
	%dk_call% dk_echo
	%dk_call% dk_callDKJava dk_basename "C:/Users/Administrator/DigitalKnob/Development"
	%dk_call% dk_echo "dk_callDKJava = %dk_callDKJava%"
	%dk_call% dk_echo "dk_basename = %dk_basename%"
	%dk_call% dk_echo
%endfunction%

@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_callDKJavascript(function, arguments...)
::#
::#
:dk_callDKJava
setlocal
	%dk_call% dk_debugFunc 1 99
 
	::### Get DKJAVA_FUNCTIONS_DIR
	%dk_call% dk_validate DKJAVA_FUNCTIONS_DIR  "%dk_call% dk_DKBRANCH_DIR"
	
	::### Get DKHTTP_DKJAVA_FUNCTIONS_DIR
	if not defined DKHTTP_DKJAVA_DIR			(set "DKHTTP_DKJAVA_DIR=%DKHTTP_DKBRANCH_DIR%/DKJavas")
	if not defined DKHTTP_DKJAVA_FUNCTIONS_DIR	(set "DKHTTP_DKJAVA_FUNCTIONS_DIR=%DKHTTP_DKJAVA_DIR%/functions")
	
	::### Download files if missing
	if not exist %DKJAVA_FUNCTIONS_DIR%/DK.js	(%dk_call% dk_download "%DKHTTP_DKJAVA_FUNCTIONS_DIR%/DK.js"  "%DKJAVA_FUNCTIONS_DIR%/DK.js")
	if not exist %DKJAVA_FUNCTIONS_DIR%/%~1.js	(%dk_call% dk_download "%DKHTTP_DKJAVA_FUNCTIONS_DIR%/%~1.js" "%DKJAVA_FUNCTIONS_DIR%/%~1.js")

	::### ALL_BUT_FIRST ###
	set "ALL_BUT_FIRST=%*"
	if defined ALL_BUT_FIRST (set "ALL_BUT_FIRST=!ALL_BUT_FIRST:%~1 =!")
	
	:: ############# TODO #################
	%dk_call% dk_todo("dk_callDKJAVA")
	::### JAVA_EXE ###
	%dk_call% dk_validate JAVA_EXE "dk_JAVA_EXE.cmd"
	set DKJAVA_COMMAND="%CMD_EXE:/=\%" /V:ON /k call "%DKJAVA_EXE:\=/%" "%DKJAVA_FUNCTIONS_DIR:\=/%/%1.java" %ALL_BUT_FIRST%
	echo DKJAVA_COMMAND = %DKJAVA_COMMAND%
	set DKJAVA_COMMAND=%COMSPEC% /c %JAVAC_EXE%  %DKJAVA_FUNCTIONS_DIR%/DK.js; %DKJAVA_FUNCTIONS_DIR%/%1.js; %ALL_BUT_FIRST%
	
	echo DKJAVA_COMMAND = %DKJAVA_COMMAND%
	for /f "delims=" %%Z in ('%DKJAVA_COMMAND%') do (
		echo %%Z						&rem  Display the command's stdout
		set "dk_callDKJava=%%Z"	&rem  Set the return value to the last line of output
	)
	endlocal & (
		set "dk_callDKJava=%dk_callDKJava%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKJava dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKJava = %dk_callDKJava%"
%endfunction%

@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_callDKBatch(function, arguments..., rtn_var)
::#
::#   Reference: https://stackoverflow.com/questions/34451444/how-to-get-a-returned-value-from-powershell-and-get-it-in-a-batch-file
::#
:dk_callDKBatch
%setlocal%
	%dk_call% dk_debugFunc 1 99

	set "_func_=%~1"
	set "_path_=%DKBATCH_FUNCTIONS_DIR_%%_func_%.cmd"
	%dk_call% dk_allButFirstArgs %*

::	:DeEscape
::	echo %_ARGS_% | findstr /c:"^^" >nul && (
::		set _ARGS_=%_ARGS_:^^=^%
::		goto :DeEscape
::	)
		
	set DKCOMMAND=%_path_% %dk_allButFirstArgs%
	
	set "dk_exec_ECHO_OUTPUT=0"
	set "dk_exec_ECHO_ERROR=0"
	::set "dk_exec_PRINT_CALL=1" 		&:: dk_exec_call
	::set "dk_exec_PRINT_COMMAND=1" 	&:: dk_exec_command
	::set "dk_exec_PRINT_EXITCODES=1"	&:: dk_exec_exitcodes
	::set "dk_exec_PRINT_EXITCODE=1"	&:: dk_exec_exitcode
	::set "dk_exec_PRINT_STDERR=1"		&:: dk_exec_stderr[]
	::set "dk_exec_PRINT_STDOUT=1"		&:: dk_exec_stdout[]
	::set "dk_exec_PRINT_OUTPUT=1"		&:: dk_exec
	
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set dk_callDKBatch=%dk_exec%
		set "%_func_%=%dk_exec%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

::	%dk_call% dk_echo
::	%dk_call% dk_callDKBatch dk_testReturn inputA
::	%dk_call% dk_echo "dk_callDKBatch = %dk_callDKBatch%"
::	%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"
::	%dk_call% dk_echo
	
	%dk_call% dk_echo
	%dk_call% dk_callDKBatch dk_basename "C:/Users/Administrator/DigitalKnob/Development"
	%dk_call% dk_echo "dk_callDKBatch = %dk_callDKBatch%"
	%dk_call% dk_echo "dk_basename = %dk_basename%"
	%dk_call% dk_echo
%endfunction%		

@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_callDKBatch(function, arguments..., rtn_var)
::#
::#   Reference: https://stackoverflow.com/questions/34451444/how-to-get-a-returned-value-from-powershell-and-get-it-in-a-batch-file
::#
:dk_callDKBatch
%setlocal%
	::%dk_call% dk_debugFunc 1 99

::	echo dk_callDKBatch %*
	::%dk_call% dk_validate CMD_EXE "%dk_call% dk_CMD_EXE"
	
	set "_func_=%~1"
	
	::### All but first Args ###
	%dk_call% dk_allButFirstArgs %*
	::for /f %%G in ("!dk_allButFirstArgs!") do (set dk_allButFirstArgs=%%~G)

::	:DeEscape
::	echo %_ARGS_% | findstr /c:"^^" >nul && (
::		set _ARGS_=%_ARGS_:^^=^%
::		goto :DeEscape
::	)
	
	::############ DKBatch function call ############
	::set DKCOMMAND=%CMD_EXE% /c (set "DK.cmd=") & (set "DKSCRIPT_PATH=%DKSCRIPT_PATH%") & (set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_FUNCTIONS_DIR%") &
	
::	echo %dk_call% dk_exec %_ARGS_%
::	%dk_call% dk_exec %_ARGS_%


::	%dk_call% dk_exec %ComSpec% /c call "%DKBATCH_FUNCTIONS_DIR_%%_func_%.cmd" %dk_allButFirstArgs%
	%dk_call% dk_exec %_func_%.cmd %dk_allButFirstArgs%
	endlocal & (
		set "dk_callDKBatch=%dk_exec%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

::	set "dk_exec_ECHO_OUTPUT=1"
::	set "dk_exec_ECHO_ERROR=1"
::	set "dk_exec_PRINT_CALL=1"
::	set "dk_exec_PRINT_COMMAND=1"
::	set "dk_exec_PRINT_EXITCODES=1"
::	set "dk_exec_PRINT_EXITCODE=1"
::	set "dk_exec_PRINT_STDERR=1"
::	set "dk_exec_PRINT_STDOUT=1"
::	set "dk_exec_PRINT_OUTPUT=1"

	echo(
	%dk_call% dk_callDKBatch dk_test "arg1" "arg2" "arg3"
	%dk_call% dk_echo "dk_callDKBatch = %dk_callDKBatch%"

	echo(
	%dk_call% dk_callDKBatch dk_basename "C:/Users/Administrator/DigitalKnob/Development"
	%dk_call% dk_echo "dk_callDKBatch = %dk_callDKBatch%"
%endfunction%		


	::###### dk_setEx ######
	::	                  ALL: " ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ "
	::                  VALID: "     # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ "
	%dk_call% dk_setEx myVar   "     # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ "
	::	              INVALID: " ! "     %                                                       "
	echo "%%myVar%%" = "%myVar%"
	echo  ^^!myVar^^!  =  !myVar!

	::###### dk_test ######
::	%dk_call% dk_callDKBatch dk_test "     # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ "
::	%dk_call% dk_callDKBatch dk_test " " "!" "#" "$" "%" "&" "'" "(" ")" "*" "+" "," "-" "." "/" ":" ";" "<" "=" ">" "?" "@" "[" "\" "]" "^" "_" "`" "{" "|" "}" "~"
	%dk_call% dk_callDKBatch dk_test "     # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ "
::	%dk_call% dk_callDKBatch dk_test "!myVar!"
::	%dk_call% dk_callDKBatch dk_test myVar
::	%dk_call% dk_callDKBatch dk_test !myVar!

::	echo dk_callDKBatch = %dk_callDKBatch%
%endfunction%

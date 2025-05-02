@echo off&::########################################## DigitalKnob DKBatch ########################################################################
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
	
	::### All but first Args ###
	::%dk_call% dk_allButFirstArgs %*

	set _ARGS_=%*
	:DeEscape
	echo %_ARGS_% | findstr /c:"^^" >nul && (
		set _ARGS_=%_ARGS_:^^=^%
		goto :DeEscape
	)
	
	::############ DKBatch function call ############
	::set DKCOMMAND=%CMD_EXE% /c (set "DK.cmd=") & (set "DKSCRIPT_PATH=%DKSCRIPT_PATH%") & (set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_FUNCTIONS_DIR%") & 
	
	echo %dk_call% dk_exec %_ARGS_%
	%dk_call% dk_exec %_ARGS_%
::	echo %dk_call% dk_exec %~1 !dk_allButFirstArgs!
::	endlocal & (
::		set "dk_callDKCmake=%dk_exec%"
::	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::	                  ALL: " ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ "
	::                  VALID: "     # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ "
	%dk_call% dk_setEx myVar   "     # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ "
	::	              INVALID: " ! "     %                                                       "
	echo "%%myVar%%" = "%myVar%"
	echo  ^^!myVar^^!  =  !myVar!

::	%dk_call% dk_callDKBatch dk_test "     # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ "
::	%dk_call% dk_callDKBatch dk_test " " "!" "#" "$" "%" "&" "'" "(" ")" "*" "+" "," "-" "." "/" ":" ";" "<" "=" ">" "?" "@" "[" "\" "]" "^" "_" "`" "{" "|" "}" "~"
	%dk_call% dk_callDKBatch dk_test "     # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ "
::	%dk_call% dk_callDKBatch dk_test "!myVar!"
::	%dk_call% dk_callDKBatch dk_test myVar
::	%dk_call% dk_callDKBatch dk_test !myVar!

::	echo dk_callDKBatch = %dk_callDKBatch%
%endfunction%

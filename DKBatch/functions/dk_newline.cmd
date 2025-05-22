@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_newline()
::#
::#    creates a newline variable assigned to %\n%
::#
:dk_newline
%setlocal%
	%dk_call% dk_debugFunc 0
	
:: ###### METHOD A:  work with !\n!, Can be quoted or unquoted ######
endlocal & (set \n=^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)

:: ###### METHOD B:  only works with %\n% (unquoted) ###
:: ::DO NOT ALTER THE EMPTY LINES BELOW
:: set NLM=^
::
::
:: set \n=^^^%NLM%%NLM%^%NLM%%NLM%
:: ::DO NOT ALTER THE EMPTY LINES ABOVE
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_newline

::	echo:
::	echo This should display %\n%a new line
::	echo:
::	echo "This should display %\n%a new line"
	echo:
	echo This is a sting with !\n!a new line
	echo:
	echo "This is a quoted string with !\n!a new line"
	
%endfunction%
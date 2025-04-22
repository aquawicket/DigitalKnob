@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_assertVar(var)
::#
::#		Check if a variable is defined and throw an Assertion if it is not.
::#
if defined %~1   %return%
:dk_assertVar
setlocal
	%dk_call% dk_debugFunc 1

	%dk_call% dk_fatal "ASSERTION: dk_assertVar(%*): %~1 not defined"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_set myVar string
	%dk_call% dk_echo "dk_assertVar(myVar)"  && %dk_call% dk_assertVar myVar

	%dk_call% dk_set myVarB 15
	%dk_call% dk_echo "dk_assertVar(myVarB)" && %dk_call% dk_assertVar myVarB

	%dk_call% dk_set myVarC "  "
	%dk_call% dk_echo "dk_assertVar(myVarC)" && %dk_call% dk_assertVar myVarC

	%dk_call% dk_set myVarD " "
	%dk_call% dk_echo "dk_assertVar(myVarD)" && %dk_call% dk_assertVar myVarD

	%dk_call% dk_set myVarE 99
	%dk_call% dk_unset myVarE
	%dk_call% dk_echo "dk_assertVar(myVarE)" && %dk_call% dk_assertVar myVarE

	%dk_call% dk_echo "dk_assertVar(noVar)"  && %dk_call% dk_assertVar noVar
%endfunction%

@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

if defined %~1   %return%
::################################################################################
::# dk_assertVar(expression)
::#
:dk_assertVar
    call dk_debugFunc 1
 setlocal
 
    %dk_call% dk_fatal "ASSERTION: dk_assertVar(%*): %~1 not defined"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
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

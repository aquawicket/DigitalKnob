@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_test(args)
::#
::#
dk_test
 setlocal
    call dk_debugFunc 1 99
    
    echo dk_test_string
    goto:eof
    
    
    %dk_call% dk_unset _testvar_
    setlocal EnableDelayedExpansion
    if defined %1 (
        %dk_call% dk_set _testvar_ "!!%1!!"
        echo isVariable
        goto:printTestVar
    )
    if defined %1[0] (
        ::echo !!%1[0]!!
        ::echo !!%1[1]!!
        ::echo !!%1[2]!!
        %dk_call% dk_set _testvar_ "!!%~1[0]!!"
        %dk_call% dk_set _testvar_[0] "!!%~1[0]!!"
        echo isArray
        goto:printTestVar
    )
    endlocal
    if not defined _testvar_ (
        %dk_call% dk_set _testvar_ "%~1"
        echo isValue
    )
    
    :printTestVar
    echo "_testvar_ = %_testvar_%"
    echo "_testvar_[0] = %_testvar_%[0]"
    
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_test "functions can recieve strings as arguments"

    %dk_call% dk_set myVar "Or they can accept expanded variables"
    %dk_call% dk_test "%myVar%"

    %dk_call% dk_set myVarB "Or, they can even take in just the name of the variable"
    %dk_call% dk_test myVarB

    %dk_call% dk_set myVarC[0] "Or, we can also take"
    %dk_call% dk_set myVarC[1] "the name of an"
    %dk_call% dk_set myVarC[2] "array variable"
    %dk_call% dk_test myVarC
goto:eof

@echo off
call DK

::####################################################################
::# dk_test(<args>)
::#
::#
:dk_test () {
	call dk_debugFunc
	
	call dk_unset _testvar_
	setlocal EnableDelayedExpansion
	if defined %1 (
		call dk_set _testvar_ "!!%1!!"
		echo isVariable
		goto:printTestVar
	)
	if defined %1[0] (
		::echo !!%1[0]!!
		::echo !!%1[1]!!
		::echo !!%1[2]!!
		call dk_set _testvar_ "!!%~1[0]!!"
		call dk_set _testvar_[0] "!!%~1[0]!!"
		echo isArray
		goto:printTestVar
	)
	endlocal
	if not defined _testvar_ (
		call dk_set _testvar_ "%~1"
		echo isValue
	)
	
	:printTestVar
	echo "_testvar_ = %_testvar_%"
	echo "_testvar_[0] = %_testvar_%[0]"
	
goto:eof

)


:DKTEST ############################## DKTEST ##############################


call dk_test "functions can recieve strings as arguments"

call dk_set myVar "Or they can accept expanded variables"
call dk_test "%myVar%"

call dk_set myVarB "Or, they can even take in just the name of the variable"
call dk_test myVarB

call dk_set myVarC[0] "Or, we can also take"
call dk_set myVarC[1] "the name of an"
call dk_set myVarC[2] "array variable"
call dk_test myVarC
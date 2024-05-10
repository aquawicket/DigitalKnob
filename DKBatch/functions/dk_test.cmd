@echo off
call DK

::####################################################################
::# dk_test(<args>)
::#
::#
:dk_test () {
	call dk_debugFunc
	
	set "_testvar_="
	setlocal EnableDelayedExpansion
	if defined %1 (
		set "_testvar_=!!%1!!"
		echo isVariable
		goto:printTestVar
	)
	if defined %1[0] (
		::echo !!%1[0]!!
		::echo !!%1[1]!!
		::echo !!%1[2]!!
		set "_testvar_=!!%~1[0]!!"
		echo isArray
		goto:printTestVar
	)
	endlocal
	if not defined _testvar_ (
		set "_testvar_=%~1"
		echo isValue
	)
	
	:printTestVar
	echo "_testvar_ = %_testvar_%"
	::echo "_testvar_[0] = %_testvar_%[0]"
	
goto:eof

)


:DKTEST ############################## DKTEST ##############################


call dk_test "functions can recieve strings as arguments"

set "myVar=Or they can accept expanded variables"
call dk_test "%myVar%"

set "myVarB=Or, they can even take in just the name of the variable"
call dk_test myVarB

set "myVarC[0]=Or, we can also take"
set "myVarC[1]=the name of an"
set "myVarC[2]=array variable"
call dk_test myVarC
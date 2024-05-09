@echo off
call DK

::####################################################################
::# dk_test(<args>)
::#
::#
:dk_test () {
	call dk_debugFunc
	if defined %1 (call set "_arg1_=%%%~1%%") else (set "_arg1_=%~1")
	echo %_arg1_%
goto:eof




:DKTEST ############################## DKTEST ##############################


call dk_test "functions can recieve strings as arguments"

set "myVar=Or they can accept expanded variables"
call dk_test "%myVar%"

set "myVarB=Or, they can even take in just the name of the variable"
call dk_test myVarB


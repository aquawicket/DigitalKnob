@echo off

set HALT_ON_ERROR=0
::####################################################################
::# test_dk_toVariableInfo.cmd
::#
::#
::###### DK_Init ######
call "../functions/DK.cmd"

call dk_echo "\n############ Testing dk_toVariableInfo ############\n"

	set "myVar=this is my variable"

	:: test dk_toVariableInfo with a message containing a valid variable name
	set "message=myVar"
	call dk_toVariableInfo message
	echo %message%
	
	:: test dk_toVariableInfo with a message containing an undefined variable name
	set "message=noVar"
	call dk_toVariableInfo message
	echo %message%

	:: test dk_toVariableInfo with a message string containing no variable name
	set "message=this is just a message"
	call dk_toVariableInfo message
	echo %message%

	:: test dk_toVariableInfo with an empty message
	set "message="
	call dk_toVariableInfo message
	echo %message%

	:: test dk_toVariableInfo with no parameters
	call dk_toVariableInfo

call dk_echo "\n################### Test done #####################\n"

call dk_exit
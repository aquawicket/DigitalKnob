@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::call dk_source dk_debugFunc
::call dk_source dk_source
::####################################################################
::# dk_call(command args)
::#
::#
::set "dk_call=call dk_call"
:dk_call
	call dk_debugFunc 1 99
	
	call dk_source "%~1"
	::call dk_echo "call %*"
	call %*	
goto:eof








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	set "dk_call=call dk_call"
	
	echo %dk_call% dk_color
	%dk_call% dk_color
	echo "return from dk_color"
	
	call dk_call dk_color
	echo "return from dk_color"
	
	%dk_call% dk_color
	echo "return from dk_color"
	
	call dk_call dk_color
	echo "return from dk_color"
	
	%dk_call% dk_color
	echo "return from dk_color"
goto:eof

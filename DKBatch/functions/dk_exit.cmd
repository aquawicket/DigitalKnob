@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_exit()
::#
::#
:dk_exit
	call dk_debugFunc
	if %__ARGC__% gtr 1 call dk_error "%__FUNCTION__%:%__ARGV__% too many arguments"
	
	exit %~1
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_exit 0
goto:eof

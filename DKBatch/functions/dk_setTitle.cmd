@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_setTitle(string)
::#
::#
:dk_setTitle
	call dk_debugFunc 1 99
	
	title %*
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_setTitle "DKTEST()"
goto:eof

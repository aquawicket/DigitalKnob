@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_setTitle(string)
::#
::#
:dk_setTitle
 setlocal
	call dk_debugFunc 0 99
	
	title %*
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_setTitle "DKTEST()"
goto:eof

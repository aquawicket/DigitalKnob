@if (@X) == (@Y) @end /*
@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::##################################################################################
::# dk_pause()
::#
::#    Pause execution and wait for <enter> keypress to continue
::#
:dk_pause
	call dk_debugFunc 0
	
	pause
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_pause
goto:eof
*/
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_urlEncode(url rtn_var)
::#
::#
:dk_urlEncode
 setlocal
	call dk_debugFunc 2
	
	%dk_call% dk_todo "dk_urlEncode"
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_urlEncode https%3A%2F%2Ftwitter.com%2FSomeProfile%2Fstatus%2F1234567890
goto:eof

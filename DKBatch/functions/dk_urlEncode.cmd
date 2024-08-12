@echo off


if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_urlEncode(url rtn_var)
::#
::#
:dk_urlEncode
	call dk_debugFunc 2
	
	
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_urlEncode https%3A%2F%2Ftwitter.com%2FSomeProfile%2Fstatus%2F1234567890

goto:eof

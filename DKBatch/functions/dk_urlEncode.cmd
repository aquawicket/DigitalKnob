@echo off


call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_urlEncode(url rtn_var)
::#
::#
:dk_urlEncode
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGC__%:%__ARGV__% incorrect number of arguments"
	
	
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_urlEncode https%3A%2F%2Ftwitter.com%2FSomeProfile%2Fstatus%2F1234567890

goto:eof

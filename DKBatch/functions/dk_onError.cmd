@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"
::https://ss64.com/nt/syntax-error.html

::SomeCommand && (
::  Echo success
::) || (
::  Echo failed/error
::)

::set "dk_onError=&& (echo success) || (echo error)



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	set "dk_onError=&& (call dk_echo "success") || (call dk_error "error")"
	set "dk_onError=&& (echo success) || (echo error)"
	
	(call ) %dk_onError%
	(call) %dk_onError%
goto:eof

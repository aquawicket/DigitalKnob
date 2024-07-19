@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_assertPath(expression)
::#
:dk_assertPath
    call dk_debugFunc
	if %__ARGC__% neq 1 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	set "_var_=%~1"
	call set "_value_=%%%_var_%%%"	&:: FIXME: remove the need for call here
	if not exist "%_value_%" (
		call dk_error "Assertion failed: %__FILE__%:%__LINE__%  %__FUNCTION__%(%*): %_value_% is not found!"
	)
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	

	call dk_set sys32path "C:\Windows\System32"
	call dk_assertPath sys32path
	
	call dk_assertPath "C:\NonExistentPath"
goto:eof

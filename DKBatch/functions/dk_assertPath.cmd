@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_assertPath(expression)
::#
:dk_assertPath
 setlocal
    call dk_debugFunc 1
	
	set "_var_=%~1"
	if "!DE!" neq "" call set "_value_=%%%_var_%%%"	&:: FIXME: remove the need for call here
	if "!DE!" equ "" set "_value_=!_var_!"
	if not exist "%_value_%" (
		%dk_call% dk_error "Assertion failed: assertPath:  %__FILE__%:%__LINE__%  %__FUNCTION__%(%*): %_value_% is not found!"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_set sys32path "C:\Windows\System32"
	%dk_call% dk_assertPath sys32path
	
	%dk_call% dk_assertPath "C:\NonExistentPath"
%endfunction%

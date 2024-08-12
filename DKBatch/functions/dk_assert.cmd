@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::call dk_source dk_debugFunc
::call dk_source dk_error
::################################################################################
::# dk_assert(expression)
::#
:dk_assert
    call dk_debugFunc 1
	
	setlocal
	if not defined %~1 (
		%dk_call% dk_error "Assertion failed: %__FILE__%:%__LINE__%  %__FUNCTION__%(%*)"
	)
	endlocal
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0

	%dk_call% dk_set myVar string
	%dk_call% dk_info "dk_assert myVar" && %dk_call% dk_assert myVar

	%dk_call% dk_set myVarB 15
	%dk_call% dk_info "dk_assert myVarB" && %dk_call% dk_assert myVarB

	%dk_call% dk_set myVarC "  "
	%dk_call% dk_info "dk_assert myVarC" && %dk_call% dk_assert myVarC

	%dk_call% dk_set myVarD ""
	%dk_call% dk_info "dk_assert myVarD" && %dk_call% dk_assert myVarD

	%dk_call% dk_unset myVarE
	%dk_call% dk_assert myVarE

	%dk_call% dk_assert noVar
goto:eof

@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_assert(expression)
::#
:dk_assert
 setlocal
    call dk_debugFunc 1
	
	if not defined %~1 (
		%dk_call% dk_error "Assertion failed: dk_assert():  %__FILE__%:%__LINE__%  %__FUNCTION__%(%__ARGS__%)"
	)
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
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

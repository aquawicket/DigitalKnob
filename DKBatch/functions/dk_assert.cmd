@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

call dk_source dk_debugFunc
call dk_source dk_error
::################################################################################
::# dk_assert(expression)
::#
:dk_assert
    call dk_debugFunc 1
	
	setlocal
	if not defined %~1 (
		call dk_error "Assertion failed: %__FILE__%:%__LINE__%  %__FUNCTION__%(%*)"
	)
	endlocal
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0

	call dk_set myVar string
	call dk_info "dk_assert myVar" && call dk_assert myVar

	call dk_set myVarB 15
	call dk_info "dk_assert myVarB" && call dk_assert myVarB

	call dk_set myVarC "  "
	call dk_info "dk_assert myVarC" && call dk_assert myVarC

	call dk_set myVarD ""
	call dk_info "dk_assert myVarD" && call dk_assert myVarD

	call dk_unset myVarE
	call dk_assert myVarE

	call dk_assert noVar
goto:eof

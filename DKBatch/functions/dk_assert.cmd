@echo off
call DK

::################################################################################
::# dk_assert(<expression>)
::#
:dk_assert () {
    call dk_debugFunc
	if %__ARGC__% NEQ 1 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
::	set "_expression_=%~1"
	
::	if ( [ ! -n "${!_expression}" ]   ||
::         [ -z "${!_expression}" ]     ||
::         [ ! -n "${!_expression+x}" ] )
::	then
	
	::lastErrorFile="${BASH_SOURCE[1]}"
	::export lastErrorFile=$(realpath ${lastErrorFile})
	::export lastErrorLine="${BASH_LINENO[1-1]}"
		
	if not defined %~1 (
		rem call dk_error "Assertion failed: %~1" && return $false
		call dk_error "Assertion failed: %~1"
	)

goto:eof




:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	call dk_info "testing dk_assert . . ."

	set "myVar=string"
	call dk_assert myVar

	set "myVarB=15"
	call dk_assert myVarB

	set "myVarC=" ""
	call dk_assert myVarC

	set "myVarD="""
    call dk_assert myVarD

	set "myVarE="
	call dk_assert myVarE

	call dk_assert noVar

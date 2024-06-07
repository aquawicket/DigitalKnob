@echo off
call DK

::################################################################################
::# dk_assertPath(expression)
::#
:dk_assertPath () {
    call dk_debugFunc
	if %__ARGC__% neq 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
::	call dk_set _expression_ "%~1"
	
::	if ( [ ! -n "${!_expression}" ]   ||
::         [ -z "${!_expression}" ]     ||
::         [ ! -n "${!_expression+x}" ] )
::	then
	
	::lastErrorFile="${BASH_SOURCE[1]}"
	::export lastErrorFile=$(realpath ${lastErrorFile})
	::export lastErrorLine="${BASH_LINENO[1-1]}"
		
	if not exist "%~1" (
		call dk_error "Assertion failed: %~1"
	)

goto:eof




:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	call dk_info "testing dk_assert . . ."

	call dk_set sys32path "C:\Windows\System32"
	call dk_assertPath sys32path
	
	call dk_assertPath "C:\NonExistentPath"


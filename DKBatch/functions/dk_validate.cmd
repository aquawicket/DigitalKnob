call dk_includeGuard

::################################################################################
::# dk_validate(<variable> <function>)
::#
::#    Check if a variable is valid, otherwise run the function that defines said variable.
::#
:dk_validate () {
	call dk_debugFunc
	::if "%1"==""  call dk_error "parameter 1 is invalid"
	if "%2"==""  call dk_error "parameter 2 is invalid"

	if defined %1  goto:eof
	call %2
goto:eof
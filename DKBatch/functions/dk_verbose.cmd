::dk_include_guard()

::################################################################################
::# dk_verbose(<message>)
::#
::#
:dk_verbose () {
	::call dk_verbose "dk_verbose(%*)"
	
	if %LOG_VERBOSE% == 1 ( 
		echo %cyan% VERBOSE: %1 %clr%
	)
goto:eof
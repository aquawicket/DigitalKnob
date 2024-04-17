::dk_include_guard()

::################################################################################
::# dk_info(<message>)
::#
::#
:dk_info () {
	::call dk_verbose "dk_info(%*)"
	
	echo %white%    INFO: %1 %clr%
goto:eof
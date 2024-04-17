::dk_include_guard()

::################################################################################
::# dk_print_var(<variable>)
::#
::#
:dk_print_var () {
	::call dk_verbose "dk_print_var(%*)"
	
    set "var=%1"
    call set "value=%%%var%%%"
	if "%value%" == "" echo %var%
    if "%value%" NEQ "" echo %var%: %value%
	
    ::echo %1 = !!!INVALID!!!
goto:eof
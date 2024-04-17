::dk_include_guard()

::####################################################################
::# dk_prepend_cmake_args(<string>)
::#
::#
:dk_prepend_cmake_args () {
	call:dk_verbose "dk_prepend_cmake_args(%*)"
	
    if "%*" == "" echo ERROR: dk_prepend_cmake_args is empty! & goto:eof
    set CMAKE_ARGS="%*" %CMAKE_ARGS%
	echo prepended %*
goto:eof
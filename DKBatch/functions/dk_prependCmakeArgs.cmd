::dk_includeGuard()

::####################################################################
::# dk_prepend_cmake_args(<string>)
::#
::#
:dk_prepend_cmake_args () {
	call dk_debugFunc
	
    if "%*" == "" echo ERROR: dk_prepend_cmake_args is empty! & goto:eof
    set CMAKE_ARGS="%*" %CMAKE_ARGS%
	echo prepended %*
goto:eof
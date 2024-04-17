::dk_include_guard()

::####################################################################
::# dk_append_cmake_args(<string>)
::#
::#
:dk_append_cmake_args () {
	call:dk_verbose "dk_append_cmake_args(%*)"
	
    if "%*" == "" echo ERROR: dk_append_cmake_args is empty! & goto:eof
    set CMAKE_ARGS=%CMAKE_ARGS% "%*"
	echo appended %*
goto:eof
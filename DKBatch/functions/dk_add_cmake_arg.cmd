::dk_include_guard()

::#################################################################################
:: dk_add_cmake_arg() <arg>
::
::
:dk_add_cmake_arg () {
	call dk_verbose "%0(%*)"
	
    if "%*" == "" echo ERROR: dk_add_cmake_arg is empty! & goto:eof
    echo added %*
    set CMAKE_ARGS=%CMAKE_ARGS% "%*"
goto:eof
::dk_include_guard()

::####################################################################
::# dk_appendCmakeArgs(<string>)
::#
::#
:dk_appendCmakeArgs () {
	call dk_verbose "dk_appendCmakeArgs(%*)"
	
    if "%*" == "" echo ERROR: dk_appendCmakeArgs is empty! & goto:eof
    set CMAKE_ARGS=%CMAKE_ARGS% "%*"
	echo appended %*
goto:eof
@echo off
call dk_includeGuard
call DK

::####################################################################
::# dk_appendCmakeArgs(<string>)
::#
::#
:dk_appendCmakeArgs () {
	call dk_debugFunc
	
    if "%*" == "" echo ERROR: dk_appendCmakeArgs is empty! & goto:eof
    set CMAKE_ARGS=%CMAKE_ARGS% "%*"
	echo appended %*
goto:eof
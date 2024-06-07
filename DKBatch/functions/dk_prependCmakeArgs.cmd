@echo off
call DK

::####################################################################
::# dk_prependCmakeArgs(string)
::#
::#
:dk_prependCmakeArgs () {
	call dk_debugFunc
    if "%*" == "" echo ERROR: dk_prependCmakeArgs is empty! & goto:eof
	
    set CMAKE_ARGS="%*" %CMAKE_ARGS%
	echo prepended %*
goto:eof
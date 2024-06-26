@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

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
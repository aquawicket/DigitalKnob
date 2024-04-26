@echo off

::###### Settings ######
set ENABLE_dk_debugFunc=1

::####################################################################
::# test_dk_debugFunc.cmd
::#
::#
::###### DK_Init ######
call ../functions/DK.cmd

::###### Exception Handling ######
::setlocal disableDelayedExpansion
::if not defined @Try call exception init


::call dk_debugFunc
call :main
goto:eof


:main () {
	call dk_debugFunc
	echo.
	echo ":main(%*)"
	
	echo.
	call dk_info "test"
	
	echo.
	call :func1 1 "2" '3'
	
	echo.
	call test_dk_debugFuncB "arg1" "arg2" "arg3"
	
	call dk_pause
goto:eof


:func1 () {
	echo.
	echo ":func1(%*)"
	call dk_debugFunc
goto:eof
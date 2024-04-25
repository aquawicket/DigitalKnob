@echo off
echo ":test_dk_debugFunc.cmd(%*)"

::setlocal disableDelayedExpansion
::if not defined @Try call exception init


set ENABLE_dk_debugFunc=1

::###### Load Function files ######
call ../functions/DK.cmd


::call dkdebugFunc
call :main
call dk_pause


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
goto:eof

:func1 () {
	echo.
	echo ":func1(%*)"
	call dk_debugFunc
goto:eof



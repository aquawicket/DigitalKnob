@echo off
if not defined DKINIT (call DK & call :TEST_dk_test)
call dk_includeGuard


::####################################################################
::# dk_test(<args>)
::#
::#
:dk_test () {
	call dk_debugFunc
	::if "%1"=="" call dk_error "Incorrect number of parameters"

	echo %~1
goto:eof


::################################ DKTEST #########################################
:TEST_dk_test
	call :dk_test "called from TEST portion of the script"
	call dk_exit
goto:eof
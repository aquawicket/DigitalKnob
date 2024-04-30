@echo off
if not defined DKINIT (call DK & call :TEST_dk_test)
call dk_includeGuard

::####################################################################
::# dk_test(<args>)
::#
::#
:dk_test () {
	call dk_debugFunc

	echo %~1
goto:eof



::################################ DKTEST #########################################
:TEST_dk_test
	call :dk_test "called from TEST portion of the script"
	call dk_exit
goto:eof
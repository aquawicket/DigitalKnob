@echo off
call DK
call dk_includeGuard

::####################################################################
::# dk_test(<args>)
::#
::#
:dk_test () {
	call dk_debugFunc
	
	echo %~1
	call dk_exit
goto:eof




:DKTEST ############################## DKTEST ##############################

call :dk_test "called from TEST portion of dk_test.cmd"

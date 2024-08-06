@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# test_comman_substitution.cmd
::#
::#


setlocal enabledelayedexpansion

:main()
	set funcA=(call :funcA echo test)
	%funcA%
	echo funcA = %funcA%
	call dk_pause
goto:eof


:funcA
	::for /f "usebackq tokens=*" %%a in (`echo Test`) do my_command %%a
	%* > bla.txt
	set /p VV=<bla.txt
	set funcA=%VV%
	::FOR /F "usebackq" %%x IN (`%*`) DO set "funcA=%%x"
goto:eof


:funcB
	echo 1 = %1
	!%1!
	echo funcB(%*)
goto:eof

call DK_pause
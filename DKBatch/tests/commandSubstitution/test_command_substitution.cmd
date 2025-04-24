@echo off
<<<<<<< HEAD
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../functions/")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
>>>>>>> Development

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
%endfunction%


:funcA
	::for /f "usebackq tokens=*" %%a in (`echo Test`) do my_command %%a
	%* > bla.txt
	set /p VV=<bla.txt
	set funcA=%VV%
	::FOR /F "usebackq" %%x IN (`%*`) DO set "funcA=%%x"
%endfunction%


:funcB
	echo 1 = %1
	!%1!
	echo funcB(%*)
%endfunction%

call DK_pause
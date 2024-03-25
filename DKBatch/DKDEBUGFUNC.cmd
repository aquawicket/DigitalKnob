@echo off
setlocal EnableDelayedExpansion
::### keep window open ###
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

goto:END_DKDEBUGFUNC
:DKDEBUGFUNC
	setlocal
	::echo :DKDEBUGFUNC(%0 %1 %2 %3 %4 %5 %6 %7 %8 %9)
	::set args=%*
	::echo :DKDEBUGFUNC(%0 %args%)
	shift
	if "%~1" neq "" set args=%1
	if "%~2" neq "" set args=%args% %2
	if "%~3" neq "" set args=%args% %3
	if "%~4" neq "" set args=%args% %4
	if "%~5" neq "" set args=%args% %5
	if "%~6" neq "" set args=%args% %6
	if "%~7" neq "" set args=%args% %7
	if "%~8" neq "" set args=%args% %8
	if "%~9" neq "" set args=%args% %9
	::echo :DKDEBUGFUNC(%0 %1)
	::set "args="
	:::parse
	::	if "%~1" neq "" (
	::		set args=%args% %1
	::		shift
	::		goto :parse
	::	)
	::echo :DKDEBUGFUNC(%0 %1 %2 %3 %4 %5 %6 %7 %8 %9)
	::if defined args set args=%args:~1%
	::echo :DKDEBUGFUNC(%0 %args%)
	
	echo.
	echo %~nx0(%args%)


	:: https://ss64.com/nt/syntax-args.html
	:: Parameter Extensions
	echo.
	echo                                   * = %*
	echo              Raw argument:        0 = %0
	echo Fully qualified path name:      ~f0 = %~f0
	echo         Drive letter only:      ~d0 = %~d0
	echo                 Path only:      ~p0 = %~p0
	echo Without extension or path:      ~n0 = %~n0
	echo       File extension only:      ~x0 = %~x0
	echo            Short 8.3 name:      ~s0 = %~s0
	echo            Without quotes:       ~0 = %~0
	echo           File attributes:      ~a0 = %~a0
	echo            File date/time:      ~t0 = %~t0
	echo                 File size:      ~z0 = %~z0
	echo          PATH environment: ~$PATH:0 = %~$PATH:0
	::Combined Parameter Extensions
	echo                                ~dp0 = %~dp0
	echo                                ~sp0 = %~sp0
	echo                                ~nx0 = %~nx0
	goto:eof
:END_DKDEBUGFUNC
set "DKDEBUGFUNC=call:DKDEBUGFUNC"


:main
	%DKDEBUGFUNC% %0 %*
	call:test_function One 2 "three" FOUR "5"
goto:eof


:test_function <args>
	%DKDEBUGFUNC% %0 %*
goto:eof
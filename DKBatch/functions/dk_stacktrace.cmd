@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_stacktrace()
::#
::#
:dk_stacktrace
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	::echo DKSTACK_length = %DKSTACK_length%
	::echo DKSTACK_marker = %DKSTACK_marker%
	set /a dk_stacktrace_count=%DKSTACK_length%-1
	::set /a dk_stacktrace_marker=%DKSTACK_marker%
	set /a dk_stacktrace_marker=%dk_stacktrace_count%
	::echo dk_stacktrace_marker = %dk_stacktrace_marker%
	
	:dk_stacktrace_Loop
		::set "OUTPUT="[%dk_stacktrace_count%]  %%DKSTACK[%dk_stacktrace_marker%].__FILE__%%   %%DKSTACK[%dk_stacktrace_marker%].__FUNCTION__%%    %%DKSTACK[%dk_stacktrace_marker%].__ARGS__%%"
		call dk_textFormat OUTPUT "[%dk_stacktrace_count%]"  "%%DKSTACK[%dk_stacktrace_marker%].__FILE__%%"  "%%DKSTACK[%dk_stacktrace_marker%].__FUNCTION__%%"  "%%DKSTACK[%dk_stacktrace_marker%].__ARGS__%%"
		call echo %OUTPUT%
		set /a dk_stacktrace_count-=1
		
		set /a dk_stacktrace_marker=%dk_stacktrace_count%
		::if "%dk_stacktrace_marker%" equ "0" (
		::	set /a dk_stacktrace_marker=%DKSTACK_length%
		::) else (
		::	set /a dk_stacktrace_marker-=1
		::)
	if %dk_stacktrace_count% GEQ 0 goto:dk_stacktrace_Loop
	
	echo done
goto:eof







::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_debug "test putting a function on the stack"
	echo 0 = %0
    echo ~f0 = %~f0
    echo ~nx0 = %~nx0
	call :func1 abc
goto:eof

:func1
	call dk_debugFunc
	echo 0 = %0
    echo ~f0 = %~f0
    echo ~nx0 = %~nx0
	call :func2 123
goto:eof

:func2 
	call dk_debugFunc
	echo 0 = %0
    echo ~f0 = %~f0
    echo ~nx0 = %~nx0
	call :func3 x y z
goto:eof

:func3
	call dk_debugFunc
	echo 0 = %0
    echo ~f0 = %~f0
    echo ~nx0 = %~nx0
	pause
	call dk_stacktrace
goto:eof

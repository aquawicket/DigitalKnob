@echo off
call dk_includeGuard
call DK

::################################################################################
::# dk_stacktrace()
::#
::#
:dk_stacktrace () {
	call dk_debugFunc
	
	echo DKSTACK_length = %DKSTACK_length%
	echo DKSTACK_marker = %DKSTACK_marker%
	set /a dk_stacktrace_count=%DKSTACK_length%-1
	::set /a dk_stacktrace_marker=%DKSTACK_marker%
	set /a dk_stacktrace_marker=%dk_stacktrace_count%
	::echo dk_stacktrace_marker = %dk_stacktrace_marker%
	
	:dk_stacktrace_Loop
		::set "OUTPUT="[%dk_stacktrace_count%]  %%DKSTACK[%dk_stacktrace_marker%].FILE%%   %%DKSTACK[%dk_stacktrace_marker%].FUNCTION%%    %%DKSTACK[%dk_stacktrace_marker%].ARGS%%"
		call dk_textFormat OUTPUT "[%dk_stacktrace_count%]"  "%%DKSTACK[%dk_stacktrace_marker%].FILE%%"  "%%DKSTACK[%dk_stacktrace_marker%].FUNCTION%%"  "%%DKSTACK[%dk_stacktrace_marker%].ARGS%%"
		call echo %OUTPUT%
		set /a dk_stacktrace_count-=1
		
		set /a dk_stacktrace_marker=%dk_stacktrace_count%
		::if "%dk_stacktrace_marker%" EQU "0" (
		::	set /a dk_stacktrace_marker=%DKSTACK_length%
		::) else (
		::	set /a dk_stacktrace_marker-=1
		::)
	if %dk_stacktrace_count% GEQ 0 goto:dk_stacktrace_Loop
	
	echo done
	
goto:eof

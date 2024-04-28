call dk_includeGuard

::################################################################################
::# dk_stacktrace()
::#
::#
:dk_stacktrace () {
	call dk_debugFunc
	
	echo DKSTACK_length = %DKSTACK_length%
	set /a dk_stacktrace_frame=%DKSTACK_length%-1
	echo dk_stacktrace_frame = %dk_stacktrace_frame%
	
	:dk_stacktrace_Loop
	

	call dk_textFormat OUTPUT "[%dk_stacktrace_frame%]"  "%%DKSTACK[%dk_stacktrace_frame%].FILE%%"  "%%DKSTACK[%dk_stacktrace_frame%].FUNCTION%%"  "%%DKSTACK[%dk_stacktrace_frame%].ARGS%%"
	call echo %OUTPUT%
	::call echo "%clr%[%dk_stacktrace_frame%] %%DKSTACK[%dk_stacktrace_frame%].FILE%%,      %%DKSTACK[%dk_stacktrace_frame%].FUNCTION%%,      %%DKSTACK[%dk_stacktrace_frame%].ARGS%%"
	set /a dk_stacktrace_frame-=1
	if %dk_stacktrace_frame% GEQ 0 goto:dk_stacktrace_Loop
	
	echo done
	
goto:eof

@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::BATCH_SOURCE
::BATCH_ARGC[]
::BATCH_ARGV[]
::BATCH_LINENO[]
::FUNCNAME[]


if not defined ENABLE_dk_debugFunc     set "ENABLE_dk_debugFunc=0"
if not defined MAX_STACK_LINES         set "MAX_STACK_LINES=200"
if not defined DKSTACK[0].__FILE__     set "DKSTACK[0].__FILE__=DK.cmd"
if not defined DKSTACK[0].__FUNCTION__ set "DKSTACK[0].__FUNCTION__=DK"
if not defined DKSTACK[0].__ARGS__     set "DKSTACK[0].__ARGS__= "
if not defined DKSTACK_length          set /a "DKSTACK_length=1"
if not defined DKSTACK_marker          set /a "DKSTACK_marker=1"
::################################################################################
::# dk_debugFunc()
::#
::#
:dk_debugFunc
	if "%*" neq "" call dk_error "%__FUNCTION__%(): too many arguments"
	
	::if not exist "%DKBATCH_FUNCTIONS_DIR_%dk_callStack.cmd" powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_callStack.cmd', '%DKBATCH_FUNCTIONS_DIR_%dk_callStack.cmd')"
	call dk_callStack
	:dk_callStackReturn
	
	:: find the first matching __CALLER__ in the stack.  If a match is found, replace that frame with the current frame, and remove all elements after
	set "DKSTACK[%DKSTACK_marker%].__FILE__=%__FILE__%"
	set "DKSTACK[%DKSTACK_marker%].__FUNCTION__=%__FUNCTION__%"
	set "DKSTACK[%DKSTACK_marker%].__ARGS__=%__ARGS__%"
	
	::title %__FUNCTION__%
::	call echo "DKSTACK[%DKSTACK_marker%].__FILE__ = %%DKSTACK[%DKSTACK_marker%].__FILE__%%"	
::	call echo "DKSTACK[%DKSTACK_marker%].__FUNCTION__ = %%DKSTACK[%DKSTACK_marker%].__FUNCTION__%%"	
::	call echo "DKSTACK[%DKSTACK_marker%].__ARGS__ = %%DKSTACK[%DKSTACK_marker%].__ARGS__%%"
	
::	set /a "DKSTACK_prev_marker=DKSTACK_marker-1"
::	call echo "DKSTACK[%DKSTACK_prev_marker%].__FILE__ = %%DKSTACK[%DKSTACK_prev_marker%].__FILE__%%"	
::	call echo "DKSTACK[%DKSTACK_prev_marker%].__FUNCTION__ = %%DKSTACK[%DKSTACK_prev_marker%].__FUNCTION__%%"	
::	call echo "DKSTACK[%DKSTACK_prev_marker%].__ARGS__ = %%DKSTACK[%DKSTACK_prev_marker%].__ARGS__%%"
	
	set /a "__ARGC__=0"
	FOR /L %%a IN (1,1,9) DO (
	   if defined ARGV[%%a] (
		  rem call echo ARGV[%%a] = '%%ARGV[%%a]%%'
	      set /a "__ARGC__=%%a"
	   )
	)
	set "DKSTACK[%DKSTACK_marker%].__ARGC__=%__ARGC__%"

	::NOTE: determin when we need to remove the topmost DKStack_marker 
	::Example
	::
	::	main()				0
	::  	func1()			1
	::			func2()     2
	::				func3() 3
	::				funcA() 4	<-- THIS is where we need to drop func3() from the call stack
	::			funcB()     5   <-- THIS is where we need to drop func2() from the call stack
	::		funcC()         6   <-- THIS is where we need to drop func1() from the call stack
	::
	::Example
	::
	::	main()				0
	::  	func1()			1
	::			func2()     2
	::				func3() 3
	::		funcC()         6   <-- THIS is where we need to replace func1() with funcC() and remove everything after
	::
	
	
	
	::echo __FILE__ = %__FILE__%
	::echo __FUNCTION__ = %__FUNCTION__%
	::echo __ARGS__ = %__ARGS__%
	::echo __ARGC__ = %__ARGC__%
		
	set /a DKSTACK_length+=1
	set /a DKSTACK_marker=%DKSTACK_length%	
::	if %DKSTACK_length% LSS %MAX_STACK_LINES% (
::		set /a DKSTACK_length+=1
::		echo "growing DKSTACK_length to %DKSTACK_length%"
::	) else (
::		echo "DKSTACK_length is capped at %DKSTACK_length%"
::	)
::	if %DKSTACK_marker% LSS %DKSTACK_length% (
::		set /a DKSTACK_marker+=1
::		echo "advancing DKSTACK_marker to %DKSTACK_marker%"
::	) else (
::		set /a DKSTACK_marker=0
::		echo "resetting DKSTACK_marker to %DKSTACK_marker%"

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	if "%ENABLE_dk_debugFunc%" neq "1" goto:eof
	
	::set "indent="%indent% L "
	set "indent=" L "
	
	set "ESC="
	set "cyan=%ESC%[36m"
	set "blue=%ESC%[34m"
	set "clr=%ESC%[0m"
	
	set "__LINE__=0"
	echo %indent%%cyan%%__FILE__%:%__LINE__%    %blue%%__FUNCTION__%(%__ARGS__%)%clr%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::	
goto:eof



::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
goto:eof


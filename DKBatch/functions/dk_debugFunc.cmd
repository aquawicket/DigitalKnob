<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::BATCH_SOURCE
::BATCH_ARGC[]
::BATCH_ARGV[]
::BATCH_LINENO[]
::FUNCNAME[]


::set "ENABLE_dk_debugFunc=1"
if not defined MAX_STACK_LINES         set "MAX_STACK_LINES=200"
if not defined DKSTACK[0].__FILE__     set "DKSTACK[0].__FILE__=DK.cmd"
if not defined DKSTACK[0].__FUNCTION__ set "DKSTACK[0].__FUNCTION__=DK"
if not defined DKSTACK[0].__ARGS__     set "DKSTACK[0].__ARGS__= "
if not defined DKSTACK_length          set /a "DKSTACK_length=1"
if not defined DKSTACK_marker          set /a "DKSTACK_marker=1"
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


>>>>>>> Development
::################################################################################
::# dk_debugFunc()
::#
::#   This function is placed at the entry point of every function in the library. It provides debugging information for the parent function at execution time when enabled.
::#   This function also implements a managed callstack for languages that do not have a implemented debugging callstack. Various other debugging tasks can be preformed 
::#   such as argument count and type checking, parameter variable value watching, function execution timing and trigger breakpoints before and after function calls.
::#   Any functions named in the breakpoint list will pause execution when execution encounters the function call. Breakpoints may pause execution at the function entry point,
::#   before the function is entered into the callstack, after entry and the trace is printed, or at the start of the next call, before the next calls callstack is entered.
::#
::#   <TIMESTAMP> <ELAPSED_TIME>
::#   1: ###### PREVIOUS FUNCTION EXIT BREAKPOINT / CURRENT FUNCTION PRE-INIT BREAKPOINT ######
::#      If the previous function has a breakpoint set for the end of the call, pause execution here, before creating a new callstack entry.
::#      OR, If the current function has a breakpoint set for before entry, pause execution here, before creating a new callstack entry.
::#
::#   2: ###### CREATE CALLSTACK ENTRY ######
::#      Create a callstack entry containing the Timestamp, Current file, function, line number, arguments, argument count and argument values. 
::#      As well as the calling function, file and line number
::#
::#   3: ###### VALIDATE ARGUMENTS ######
::#      Check that the function paramter definition arguments match what the function received.  For example.  
::#          dk_debugFunc(string, int, rtn:string)      "The function expects 3 arguments. Parameter 1 a string followed by an int amd a return string variable;
::#      If the received arguments don't match the count or type defined, dk_debugFunc will throw an error and print the callstack.
::#
::#   4: ###### DEBUG FUNCTION TRACE PRINTING ######
::#      If debug tracing is enabled, each function and parameter values will printed as the functions are called. Timestamp and Elapsed time since last callstack entry 
::#      will also be printed to the debugging console. Any functions named in the exclusion list will not be printed. Any functions named in the inclusion list will always be printed.
::#      unless debug tracing is explicitly turned off. 
::#
::#   5: ###### ENTRY BREAKPOINT ######
::#      If the current function has a breakpoint set for at entry, pause execution here, after creating and printing the new callstack entry. 
::#   <TIMESTAMP>
::#   
:dk_debugFunc
<<<<<<< HEAD
    ::if "%~3" neq "" call dk_error "dk_debugFunc: too many arguments (%*)"
 ::setlocal

    ::###<TIMESTAMP> <ELAPSED_TIME>###
    ::call dk_timer timestamp
    ::echo timestamp = %timestamp%

    ::1: ###### PREVIOUS FUNCTION EXIT BREAKPOINT / CURRENT FUNCTION PRE-INIT BREAKPOINT ######
    ::     TODO

    ::2: ###### CREATE CALLSTACK ENTRY ######
    call dk_callStack
    :dk_callStackReturn
    
    set "DKSTACK[%DKSTACK_marker%].__TIME__=%__TIME__%"
    set "DKSTACK[%DKSTACK_marker%].__FILE__=%__FILE__%"
    ::set "DKSTACK[%DKSTACK_marker%].__LINE__=%__LINE__%"
    set "DKSTACK[%DKSTACK_marker%].__FUNCTION__=%__FUNCTION__%"
    set "DKSTACK[%DKSTACK_marker%].__ARGC__=%__ARGC__%"
	set "DKSTACK[%DKSTACK_marker%].__ARGS__=%__ARGS__%"
	set "DKSTACK[%DKSTACK_marker%].__ARGV__=%__ARGV__%"
    set /a DKSTACK_length+=1
    set /a DKSTACK_marker=%DKSTACK_length%  
    ::echo %__TIME__%:%__FILE__%: %__FUNCTION__%:%__ARGC__%(%__ARGS__%)


    ::3: ###### VALIDATE ARGUMENTS ######
    if "%~1" == ""                                                echo %red%"ERROR: %__FUNCTION__%(%__ARGS__%): dk_debugFunc ArgsMin ArgsMax is not set."%clr%               && %dk_call% dk_exit 13
    if not "%~1" == "" if defined __ARGC__ if %__ARGC__% lss %~1  echo %red%"ERROR: %__FUNCTION__%(%__ARGS__%): not enough arguments. Minimum is %~1, got %__ARGC__%"%clr%   && %dk_call% dk_exit 13
    if "%~2" == "" if %__ARGC__% gtr %~1                          echo %red%"ERROR: %__FUNCTION__%(%__ARGS__%): too many arguments. Maximum is %~1, got %__ARGC__%"%clr%     && %dk_call% dk_exit 13
    if not "%~2" == "" if %__ARGC__% gtr %~2                      echo %red%"ERROR: %__FUNCTION__%(%__ARGS__%): too many arguments. Maximum is %~2, got %__ARGC__%"%clr%     && %dk_call% dk_exit 13

    ::NOTE: determin when we need to remove the topmost DKStack_marker 
    ::Example
    ::
    ::  main()              0
    ::      func1()         1
    ::          func2()     2
    ::              func3() 3
    ::              funcA() 4   <-- THIS is where we need to drop func3() from the call stack
    ::          funcB()     5   <-- THIS is where we need to drop func2() from the call stack
    ::      funcC()         6   <-- THIS is where we need to drop func1() from the call stack
    ::
    ::Example
    ::
    ::  main()              0
    ::      func1()         1
    ::          func2()     2
    ::              func3() 3
    ::      funcC()         6   <-- THIS is where we need to replace func1() with funcC() and remove everything after
    ::

        
    
::  if %DKSTACK_length% LSS %MAX_STACK_LINES% (
::      set /a DKSTACK_length+=1
::      echo "growing DKSTACK_length to %DKSTACK_length%"
::  ) else (
::      echo "DKSTACK_length is capped at %DKSTACK_length%"
::  )
::  if %DKSTACK_marker% LSS %DKSTACK_length% (
::      set /a DKSTACK_marker+=1
::      echo "advancing DKSTACK_marker to %DKSTACK_marker%"
::  ) else (
::      set /a DKSTACK_marker=0
::      echo "resetting DKSTACK_marker to %DKSTACK_marker%"

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::@echo on
    if not defined ENABLE_dk_debugFunc %return%

    ::set "indent="%indent% L "
    set "indent=-^> "

    set "ESC="
    set "cyan=%ESC%[36m"
    set "blue=%ESC%[34m"
    set "clr=%ESC%[0m"

    set "__LINE__=0"
    for %%Z in ("%__FILE__%") do set "basename=%%~nxZ"
    echo %indent%%cyan%%basename%:%__LINE__%    %blue%%__FUNCTION__%:%__ARGS__%%clr%
    ::echo %indent%%blue%%__FUNCTION__%%clr%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::  
=======
setlocal enableDelayedExpansion	
	
	if "%__FUNC__%" equ "dk_debugFunc" %endfunction%
	if not defined __FUNC__ (%endfunction%)
	
    :: ###### VALIDATE ARGUMENTS ######
    if "%~1" equ ""													(%dk_call% dk_fatal "%FUNC%(%ARGV%): dk_debugFunc ArgsMin ArgsMax is not set.")
    if not "%~1" equ ""	if defined __ARGC__ if %__ARGC__% lss %~1	(%dk_call% dk_fatal "%FUNC%(%ARGV%): not enough arguments. Minimum is %~1, got %__ARGC__%")
    if "%~2" equ ""		if defined __ARGC__ if %__ARGC__% gtr %~1	(%dk_call% dk_fatal "%FUNC%(%ARGV%): too many arguments. Maximum is %~1, got %__ARGC__%")
    if not "%~2" equ ""	if defined __ARGC__ if %__ARGC__% gtr %~2	(%dk_call% dk_fatal "%FUNC%(%ARGV%): too many arguments. Maximum is %~2, got %__ARGC__%")

>>>>>>> Development
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
	:::::::::::::::::::::::::
=======
setlocal enableDelayedExpansion	

    %dk_call% dk_debugFunc 0

>>>>>>> Development
%endfunction%


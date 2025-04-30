@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


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
setlocal enableDelayedExpansion	
	
	if "%__FUNC__%" equ "dk_debugFunc" %endfunction%
	if not defined __FUNC__ (%endfunction%)
	
    :: ###### VALIDATE ARGUMENTS ######
    if "%~1" equ ""													(%dk_call% dk_fatal "%FUNC%(%ARGV%): dk_debugFunc ArgsMin ArgsMax is not set.")
    if "%~1" neq ""	if defined __ARGC__ if %__ARGC__% lss %~1	(%dk_call% dk_fatal "%FUNC%(%ARGV%): not enough arguments. Minimum is %~1, got %__ARGC__%")
    if "%~2" equ ""		if defined __ARGC__ if %__ARGC__% gtr %~1	(%dk_call% dk_fatal "%FUNC%(%ARGV%): too many arguments. Maximum is %~1, got %__ARGC__%")
    if "%~2" neq ""	if defined __ARGC__ if %__ARGC__% gtr %~2	(%dk_call% dk_fatal "%FUNC%(%ARGV%): too many arguments. Maximum is %~2, got %__ARGC__%")

%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal enableDelayedExpansion	

    %dk_call% dk_debugFunc 0

%endfunction%


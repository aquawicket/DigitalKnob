@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ################################################################################
rem # dk_debugFunc()
rem #
rem #   This function is placed at the entry point of every function in the library. It provides debugging information for the parent function at execution time when enabled.
rem #   This function also implements a managed callstack for languages that do NOT have a implemented debugging callstack. Various other debugging tasks can be preformed
rem #   such as argument count and type checking, parameter variable value watching, function execution timing and trigger breakpoints before and after function calls.
rem #   Any functions named in the breakpoint list will pause execution when execution encounters the function call. Breakpoints may pause execution at the function entry point,
rem #   before the function is entered into the callstack, after entry and the trace is printed, or at the start of the next call, before the next calls callstack is entered.
rem #
rem #   <TIMESTAMP> <ELAPSED_TIME>
rem #   1: ###### PREVIOUS FUNCTION EXIT BREAKPOINT / CURRENT FUNCTION PRE-INIT BREAKPOINT ######
rem #      If the previous function has a breakpoint set for the end of the call, pause execution here, before creating a new callstack entry.
rem #      OR, If the current function has a breakpoint set for before entry, pause execution here, before creating a new callstack entry.
rem #
rem #   2: ###### CREATE CALLSTACK ENTRY ######
rem #      Create a callstack entry containing the Timestamp, Current file, function, line number, arguments, argument count and argument values.
rem #      As well as the calling function, file and line number
rem #
rem #   3: ###### VALIDATE ARGUMENTS ######
rem #      Check that the function paramter definition arguments match what the function received.  For example. 
rem #          dk_debugFunc(string, int, rtn:string)      "The function expects 3 arguments. Parameter 1 a string followed by an int amd a return string variable;
rem #      If the received arguments don't match the count or type defined, dk_debugFunc will throw an error and print the callstack.
rem #
rem #   4: ###### DEBUG FUNCTION TRACE PRINTING ######
rem #      If debug tracing is enabled, each function and parameter values will printed as the functions are called. Timestamp and Elapsed time since last callstack entry
rem #      will also be printed to the debugging console. Any functions named in the exclusion list will NOT be printed. Any functions named in the inclusion list will always be printed.
rem #      unless debug tracing is explicitly turned off.
rem #
rem #   5: ###### ENTRY BREAKPOINT ######
rem #      If the current function has a breakpoint set for at entry, pause execution here, after creating and printing the new callstack entry.
rem #   <TIMESTAMP>
rem #  
:dk_debugFunc
%setlocal%
	
	if NOT defined __FUNCTION__ (%endfunction%)
	if /i "%__FUNCTION__%" equ "dk_debugFunc" %endfunction%
	
    rem ###### VALIDATE ARGUMENTS ######
    if "%~1" equ ""												(%dk_call% dk_fatal "%__FUNCTION__%(%__ARGS__%): dk_debugFunc ArgsMin ArgsMax is NOT set.")
    if "%~1" neq ""	if defined __ARGC__ if %__ARGC__% lss %~1	(%dk_call% dk_fatal "%__FUNCTION__%(%__ARGS__%): NOT enough arguments. Minimum is %~1, got %__ARGC__%")
    if "%~2" equ ""	if defined __ARGC__ if %__ARGC__% gtr %~1	(%dk_call% dk_fatal "%__FUNCTION__%(%__ARGS__%): too many arguments. Maximum is %~1, got %__ARGC__%")
    if "%~2" neq ""	if defined __ARGC__ if %__ARGC__% gtr %~2	(%dk_call% dk_fatal "%__FUNCTION__%(%__ARGS__%): too many arguments. Maximum is %~2, got %__ARGC__%")

%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%	


%endfunction%


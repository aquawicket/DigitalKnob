:: dk_include_guard


if "%ENABLE_dk_debugFunc%"=="" set ENABLE_dk_debugFunc=0
if "%DKSTACK[0].FILE%"==""     set "DKSTACK[0].FILE=%0"
if "%DKSTACK[0].FUNCTION%"=="" set "DKSTACK[0].FUNCTION=main"
if "%DKSTACK[0].ARGS%"==""     set "DKSTACK[0].ARGS=0"
if "%DKSTACK_length%"==""      set /a DKSTACK_length=1
::################################################################################
::# dk_debugFunc()
::#
::#
:dk_debugFunc () {

<:dk_caller <nul call %DKBATCH_DIR%\functions\dk_caller.cmd
	
	:: To iterate the element of array

	:DKSTACK_length_iterator
	::if defined DKSTACK[%len%] ( 
	::   set /a DKSTACK_length+=1
	::   goto:DKSTACK_length_iterator 
	::)
	set DKSTACK[%DKSTACK_length%].FILE=%_filename%
	set DKSTACK[%DKSTACK_length%].FUNCTION=%_func%
	set DKSTACK[%DKSTACK_length%].ARGS=%_args%
	set /a DKSTACK_length+=1
	
	if [%ENABLE_dk_debugFunc%] NEQ [1] goto:eof
	set "cyan=[36m"
	set "clr=[0m"
	echo %_filename%: %cyan%%_func%(%_args%)%clr%
	
	::echo.
	::echo _path           = %_path%
	::echo _callerpath     = %_callerpath%
	::echo _callertype     = %_callertype%
	::echo _filename       = %_filename%
	::echo _func           = %_func%
	::echo _args           = %_args%
	::echo.
	::echo _returnVar      = %_returnVar%
	::echo.
	::echo _lastpath       = %_lastpath%
	::echo _lastcallerpath = %_lastcallerpath%
	::echo _lastfilename   = %_lastfilename%
	::echo _lastfunc       = %_lastfunc%
	::echo _lastargs       = %_lastargs%
goto:eof
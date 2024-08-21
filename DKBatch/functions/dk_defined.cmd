@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::##################################################################################
::# dk_defined(<variable> rtn_var)
::#
:dk_defined
	call dk_debugFunc 1 2

	setlocal
	::%dk_call% dk_set variable "%1"
	if defined %~1 (
		if defined "%~2" (endlocal & call set "%2=true")
		(call ) %NO_STD%
		goto:eof
	)
	
	if defined "%~2" (endlocal & call set "%2=false")
    (call) %NO_STD%
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
    ::###### Using if return value
	%dk_call% dk_echo
	%dk_call% dk_set _variable_ "is defined"
	%dk_call% dk_defined _variable_ result
	if "%result%" equ "true" (echo _variable_ is defined) else (echo _variable_ is NOT defined)
	
	%dk_call% dk_echo
	%dk_call% dk_unset _variable_
	%dk_call% dk_defined _variable_ result
	if "%result%" equ "true" (echo _variable_ is defined) else (echo _variable_ is NOT defined)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using if ERRORLEVEL
	%dk_call% dk_echo
	%dk_call% dk_set _variable_ "is defined"
	%dk_call% dk_defined _variable_
	if not ERRORLEVEL 1 (echo _variable_ is defined) else (echo _variable_ is NOT defined)
	
	%dk_call% dk_echo
	%dk_call% dk_unset _variable_
	%dk_call% dk_defined _variable_
	if not ERRORLEVEL 1 (echo _variable_ is defined) else (echo _variable_ is NOT defined)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using && and || conditionals
	%dk_call% dk_echo
	%dk_call% dk_set _variable_ "is defined"
	%dk_call% dk_defined _variable_ && (echo _variable_ is defined) || (echo _variable_ is NOT defined)

	%dk_call% dk_echo
	%dk_call% dk_unset _variable_
	%dk_call% dk_defined _variable_ && (echo _variable_ is defined) || (echo _variable_ is NOT defined)
	::FIXME: ERRORLEVEL is still 1
goto:eof

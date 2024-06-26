@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::##################################################################################
::# dk_defined(<variable> rtn_var)
::#
:dk_defined () {
	call dk_debugFunc
	if "%~1" equ "" call dk_error "%__FUNCTION__%(): argument 1 is invalid"
	if "%~3" neq "" call dk_error "%__FUNCTION__%(): too many arguments"

	::call dk_set variable "%1"
	if defined %~1 (
		if defined "%~2" (endlocal & call dk_set %2 "true")
		(call )
		goto:eof
	)
	
	if defined "%~2" (endlocal & call dk_set %2 "false")
    (call)
goto:eof






:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

    ::###### Using if return value
	echo.
	call dk_set _variable_ "is defined"
	call dk_defined _variable_ result
	if "%result%" equ "true" (echo _variable_ is defined) else (echo _variable_ is NOT defined)
	
	echo.
	call dk_unset _variable_
	call dk_defined _variable_ result
	if "%result%" equ "true" (echo _variable_ is defined) else (echo _variable_ is NOT defined)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using if ERRORLEVEL
	echo.
	call dk_set _variable_ "is defined"
	call dk_defined _variable_
	if not ERRORLEVEL 1 (echo _variable_ is defined) else (echo _variable_ is NOT defined)
	
	echo.
	call dk_unset _variable_
	call dk_defined _variable_
	if not ERRORLEVEL 1 (echo _variable_ is defined) else (echo _variable_ is NOT defined)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using && and || conditionals
	echo.
	call dk_set _variable_ "is defined"
	call dk_defined _variable_ && (echo _variable_ is defined) || (echo _variable_ is NOT defined)

	echo.
	call dk_unset _variable_
	call dk_defined _variable_ && (echo _variable_ is defined) || (echo _variable_ is NOT defined)
	::FIXME: ERRORLEVEL is still 1
	
@echo off
call DK

::##################################################################################
::# dk_defined(<variable> <result>)
::#
:dk_defined () {
	call dk_debugFunc
	if "%~1" equ "" call dk_error "%__FUNCTION__%(): argument 1 is invalid"
	if "%~3" neq "" call dk_error "%__FUNCTION__%(): too many arguments"

	::set "variable=%1"
	if defined %~1 (
		if not defined "%~2" goto:eof
		
		endlocal & set "%2=true"
		call dk_printVar "%2"
		(call )
		goto:eof
	)
	
	if not defined "%~2" goto:eof
	
	endlocal & set "%2=false"
	call dk_printVar "%2"
    (call)
goto:eof






:DKTEST ########################################################################

    ::###### Using if return value
	echo.
	
	set "_variable_=is defined"
	call dk_defined _variable_ result
	if "%result%" equ "true" (echo _variable_ is defined) else (echo _variable_ is NOT defined)
	
	set "_variable_="
	call dk_defined _variable_ result
	if "%result%" equ "true" (echo _variable_ is defined) else (echo _variable_ is NOT defined)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using if ERRORLEVEL
	echo.
	
	set "_variable_=is defined"
	call dk_defined _variable_
	if not ERRORLEVEL 1 (echo _variable_ is defined) else (echo _variable_ is NOT defined)
	
	set "_variable_="
	call dk_defined _variable_
	if not ERRORLEVEL 1 (echo _variable_ is defined) else (echo _variable_ is NOT defined)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using && and || conditionals
	echo.
	
	set "_variable_=is defined"
	call dk_defined _variable_ && (echo _variable_ is defined) || (echo _variable_ is NOT defined)

	set "_variable_="
	call dk_defined _variable_ && (echo _variable_ is defined) || (echo _variable_ is NOT defined)
	::FIXME: ERRORLEVEL is still 1
	
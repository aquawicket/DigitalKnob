@echo off
call DK

::##################################################################################
::# dk_defined(<variable> <result>)
::#
:dk_defined () {
	call dk_debugFunc
	if "%~1" equ "" call dk_error "%__FUNCTION__%(%*): argument 1 is invalid"

	::set "variable=%1"
	if defined %1 (
		if "%~2" neq "" endlocal & set "%2=true"
		(call )
		goto:eof
	)
	
	if "%~2" neq "" endlocal & set "%2=false"
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
	
@echo off
call DK

::####################################################################
::# dk_fileExists(<path> <result>)
::#
:dk_fileExists () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	::set "dk_fileExists=NOT ERRORLEVEL 1"
	
	if exist "%~1" (
		if "%~2" neq "" endlocal & set "%2=true"
		call dk_printVar "%2"
        (call )
		goto:eof
	)
	
    if "%~2" neq "" endlocal & set "%2=false"
	call dk_printVar "%2"
	(call)
goto:eof






:DKTEST #############################################################

	::###### Using if return value
	echo.
	
	set "_path_=C:\Windows"
	call dk_fileExists "%_path_%" result
	if "%result%" equ "true" (echo %_path_% exists) else (echo %_path_% does NOT exists)
	
	set "_path_=C:\NonExistent"
	call dk_fileExists "%_path_%" result
	if "%result%" equ "true" (echo %_path_% exists) else (echo %_path_% does NOT exists)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using if ERRORLEVEL
	echo.
	
	set "_path_=C:\Windows"
	call dk_fileExists "%_path_%"
	if not ERRORLEVEL 1 (echo %_path_% exists) else (echo %_path_% does NOT exists)
	
	set "_path_=C:\NonExistent"
	call dk_fileExists "%_path_%"
	if not ERRORLEVEL 1 (echo %_path_% exists) else (echo %_path_% does NOT exists)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using && and || conditionals
	echo.
	
	set "_path_=C:\Windows"	
	call dk_fileExists "%_path_%" && (echo %_path_% exists) || (echo %_path_% does NOT exists)
	
	set "_path_=C:\NonExistent"	
	call dk_fileExists "%_path_%" && (echo %_path_% exists) || (echo %_path_% does NOT exists)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Experimental
::	echo.
::	
::	set "_path_=C:\Windows"
::	call dk_fileExists "%_path_%"
::	if %dk_fileExists% (echo %_path_% exists) else (echo %_path_% does NOT exists)
::	
::	set "_path_=C:\NonExistent"
::	call dk_fileExists "%_path_%"
::	if %dk_fileExists% (echo %_path_% exists) else (echo %_path_% does NOT exists)
	

	if not ERRORLEVEL 1 (echo ERRORLEVEL is 0) else (echo ERRORLEVEL is 1)
@echo off
call DK

::####################################################################
::# dk_pathExists(<path> <result>)
::#
:dk_pathExists () {
	call dk_debugFunc
	if "%~1" equ "" call dk_error "%__FUNCTION__%(%*): argument 1 is invalid"
	::set "dk_pathExists=NOT ERRORLEVEL 1"
	
	::set "_path=%~1"
	if exist "%~1" (
		if "%~2" neq "" endlocal & set "%2=true"
        (call )
		goto:eof
	)
	
    if "%~2" neq "" endlocal & set "%2=false"
	(call)
goto:eof






:DKTEST #############################################################

	::###### Using if return value
	echo.
	
	set "_path_=C:\Windows"
	call dk_pathExists "%_path_%" result
	if "%result%" equ "true" (echo %_path_% exists) else (echo %_path_% does NOT exists)
	
	set "_path_=C:\NonExistent"
	call dk_pathExists "%_path_%" result
	if "%result%" equ "true" (echo %_path_% exists) else (echo %_path_% does NOT exists)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using if ERRORLEVEL
	echo.
	
	set "_path_=C:\Windows"
	call dk_pathExists "%_path_%"
	if not ERRORLEVEL 1 (echo %_path_% exists) else (echo %_path_% does NOT exists)
	
	set "_path_=C:\NonExistent"
	call dk_pathExists "%_path_%"
	if not ERRORLEVEL 1 (echo %_path_% exists) else (echo %_path_% does NOT exists)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using && and || conditionals
	echo.
	
	set "_path_=C:\Windows"	
	call dk_pathExists "%_path_%" && (echo %_path_% exists) || (echo %_path_% does NOT exists)
	
	set "_path_=C:\NonExistent"	
	call dk_pathExists "%_path_%" && (echo %_path_% exists) || (echo %_path_% does NOT exists)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Experimental
::	echo.
::	
::	set "_path_=C:\Windows"
::	call dk_pathExists "%_path_%"
::	if %dk_pathExists% (echo %_path_% exists) else (echo %_path_% does NOT exists)
::	
::	set "_path_=C:\NonExistent"
::	call dk_pathExists "%_path_%"
::	if %dk_pathExists% (echo %_path_% exists) else (echo %_path_% does NOT exists)
::	if not ERRORLEVEL 1 (echo ERRORLEVEL is 0) else (echo ERRORLEVEL is 1)
@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_pathExists(path rtn_var)
::#
:dk_pathExists
	call dk_debugFunc
	if %__ARGC__% lss 1 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	::set "dk_pathExists=NOT ERRORLEVEL 1"
	
	::set "_path=%~1"
	if exist "%~1" (
		if defined "%~2" (endlocal & set "%2=true")
        (call )
		goto:eof
	)
	
    if defined "%~2" (endlocal & set "%2=false")
	(call)
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc

	::###### Using if return value
	call dk_echo
	set "_path_=C:\Windows"
	call dk_pathExists "%_path_%" result
	if "%result%" equ "true" (echo %_path_% exists) else (echo %_path_% does NOT exists)
	
	call dk_echo
	set "_path_=C:\NonExistent"
	call dk_pathExists "%_path_%" result
	if "%result%" equ "true" (echo %_path_% exists) else (echo %_path_% does NOT exists)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using if ERRORLEVEL
	call dk_echo
	set "_path_=C:\Windows"
	call dk_pathExists "%_path_%"
	if not ERRORLEVEL 1 (echo %_path_% exists) else (echo %_path_% does NOT exists)
	
	call dk_echo
	set "_path_=C:\NonExistent"
	call dk_pathExists "%_path_%"
	if not ERRORLEVEL 1 (echo %_path_% exists) else (echo %_path_% does NOT exists)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using && and || conditionals
	call dk_echo
	set "_path_=C:\Windows"	
	call dk_pathExists "%_path_%" && (echo %_path_% exists) || (echo %_path_% does NOT exists)
	
	call dk_echo
	set "_path_=C:\NonExistent"	
	call dk_pathExists "%_path_%" && (echo %_path_% exists) || (echo %_path_% does NOT exists)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Experimental
	::	call dk_echo
	::	set "_path_=C:\Windows"
	::	call dk_pathExists "%_path_%"
	::	if %dk_pathExists% (echo %_path_% exists) else (echo %_path_% does NOT exists)
	::
	::  call dk_echo
	::	set "_path_=C:\NonExistent"
	::	call dk_pathExists "%_path_%"
	::	if %dk_pathExists% (echo %_path_% exists) else (echo %_path_% does NOT exists)
	::	if not ERRORLEVEL 1 (echo ERRORLEVEL is 0) else (echo ERRORLEVEL is 1)
goto:eof
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_pathExists(path rtn_var)
::#
:dk_pathExists
 setlocal
	call dk_debugFunc 1 2

	::set "dk_pathExists=NOT ERRORLEVEL 1"
	
	::set "_path=%~1"
	if exist "%~1" (
		if defined "%~2" (endlocal & set "%2=true")
        (call ) %NO_STD%
		goto:eof
	)
	
    if defined "%~2" (endlocal & set "%2=false")
	(call) %NO_STD%
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0

	::###### Using if return value
	%dk_call% dk_echo
	set "_path_=C:\Windows"
	%dk_call% dk_pathExists "%_path_%" result
	if "%result%" equ "true" (echo %_path_% exists) else (echo %_path_% does NOT exists)
	
	%dk_call% dk_echo
	set "_path_=C:\NonExistent"
	%dk_call% dk_pathExists "%_path_%" result
	if "%result%" equ "true" (echo %_path_% exists) else (echo %_path_% does NOT exists)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using if ERRORLEVEL
	%dk_call% dk_echo
	set "_path_=C:\Windows"
	%dk_call% dk_pathExists "%_path_%"
	if not ERRORLEVEL 1 (echo %_path_% exists) else (echo %_path_% does NOT exists)
	
	%dk_call% dk_echo
	set "_path_=C:\NonExistent"
	%dk_call% dk_pathExists "%_path_%"
	if not ERRORLEVEL 1 (echo %_path_% exists) else (echo %_path_% does NOT exists)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Using && and || conditionals
	%dk_call% dk_echo
	set "_path_=C:\Windows"	
	%dk_call% dk_pathExists "%_path_%" && (echo %_path_% exists) || (echo %_path_% does NOT exists)
	
	%dk_call% dk_echo
	set "_path_=C:\NonExistent"	
	%dk_call% dk_pathExists "%_path_%" && (echo %_path_% exists) || (echo %_path_% does NOT exists)
	::FIXME: ERRORLEVEL is still 1 
	
	
	::###### Experimental
	::	%dk_call% dk_echo
	::	set "_path_=C:\Windows"
	::	%dk_call% dk_pathExists "%_path_%"
	::	if %dk_pathExists% (echo %_path_% exists) else (echo %_path_% does NOT exists)
	::
	::  %dk_call% dk_echo
	::	set "_path_=C:\NonExistent"
	::	%dk_call% dk_pathExists "%_path_%"
	::	if %dk_pathExists% (echo %_path_% exists) else (echo %_path_% does NOT exists)
	::	if not ERRORLEVEL 1 (echo ERRORLEVEL is 0) else (echo ERRORLEVEL is 1)
goto:eof
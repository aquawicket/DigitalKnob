@echo off&::###### DK.cmd #########################################################################################################################
if NOT exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

set "dk_pathExists_CASE_SENSITIVE=1"
::####################################################################
::# dk_pathExists(>path> <rtn_var:Optional>)
::#
::#		Check if a case sensitive path exists
::#
:dk_pathExists
%setlocal%
    %dk_call% dk_debugFunc 1 2

	set "dk_pathExists=true"
	for %%G in ("%~1") do (set "_path_=%%~fG")
	
	if NOT exist "%_path_:\=/%" (
		set "dk_pathExists=false"
	)
	
	if "%dk_pathExists_CASE_SENSITIVE%" equ "1" (
		if "%~1" neq "%_path_:\=/%" (set "dk_pathExists=false")
	)
    
	endlocal & (
		set "dk_pathExists=%dk_pathExists%"
		if "%~2" neq "" (set "%~2=%dk_pathExists%")
	)
    
	exit /b %dk_pathExists:false=1%
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	 ::###### Using if return value
    echo(
    set "_path_=C:/Windows"
    %dk_call% dk_pathExists "%_path_%"
	echo errorlevel = %errorlevel%
    if /i "%dk_pathExists%" equ "TRUE" (echo %_path_% exists) else (echo %_path_% does NOT exist)
	
    ::###### Using if return value
    echo(
    set "_path_=C:/windows"
    %dk_call% dk_pathExists "%_path_%"
	echo errorlevel = %errorlevel%
    if /i "%dk_pathExists%" equ "true" (echo %_path_% exists) else (echo %_path_% does NOT exist)
   
    echo(
    set "_path_=C:/NonExistent"
    %dk_call% dk_pathExists "%_path_%"
	echo errorlevel = %errorlevel%
    if /i "%dk_pathExists%" equ "TRUE" (echo %_path_% exists) else (echo %_path_% does NOT exist)
    ::FIXME: ERRORLEVEL is still 1
   
   
    ::###### Using if ERRORLEVEL
    echo(
    set "_path_=C:/Windows"
    %dk_call% dk_pathExists "%_path_%"
	echo errorlevel = %errorlevel%
    if NOT ERRORLEVEL 1 (echo %_path_% exists) else (echo %_path_% does NOT exist)
   
    echo(
    set "_path_=C:/NonExistent"
    %dk_call% dk_pathExists "%_path_%"
	echo errorlevel = %errorlevel%
    if NOT ERRORLEVEL 1 (echo %_path_% exists) else (echo %_path_% does NOT exist)
    ::FIXME: ERRORLEVEL is still 1
   
   
    ::###### Using && and || conditionals
    echo(
    set "_path_=C:/Windows"
    %dk_call% dk_pathExists "%_path_%" && (echo %_path_% exists) || (echo %_path_% does NOT exist)
   
    echo(
    set "_path_=C:/NonExistent"
    %dk_call% dk_pathExists "%_path_%" && (echo %_path_% exists) || (echo %_path_% does NOT exist)
    ::FIXME: ERRORLEVEL is still 1
   
   
    ::###### Experimental
    ::  %dk_call% dk_echo
    ::  set "_path_=C:/Windows"
    ::  %dk_call% dk_pathExists "%_path_%"
    ::  if %dk_pathExists% (echo %_path_% exists) else (echo %_path_% does NOT exist)
    ::
    ::  %dk_call% dk_echo
    ::  set "_path_=C:/NonExistent"
    ::  %dk_call% dk_pathExists "%_path_%"
    ::  if %dk_pathExists% (echo %_path_% exists) else (echo %_path_% does NOT exist)
    ::  if NOT ERRORLEVEL 1 (echo ERRORLEVEL is 0) else (echo ERRORLEVEL is 1)
%endfunction%
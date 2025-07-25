@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_isEmptyDirectory(path rtn_var)
::#
::#
:dk_isEmptyDirectory
%setlocal%
	%dk_call% dk_debugFunc 1 2
	
	set "dk_isEmptyDirectory=0"
	if not exist %~1\* (
		%dk_call% dk_error "%~1 is not a directory"
		set "dk_isEmptyDirectory=1"
	)
	
	for /F %%i in ('dir /b /a "%~1\*" 2^>nul') do (
		set "dk_isEmptyDirectory=1"
	)
	
	endlocal & (
		set "dk_isEmptyDirectory=%dk_isEmptyDirectory%"
		if "%~2" neq "" (set "%~2=%dk_isEmptyDirectory%")
		exit /b %dk_isEmptyDirectory%
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
  
	::###### Create The Directories and Files ######
	set "EmptyDir=C:/NotEmptyDir/EmptyDir"
	set "NotEmptyDir=C:/NotEmptyDir"
	set "NotDir=C:/NotEmptyDir/file.txt"
	set "NonExistentDir=C:/NonExistentDir"
	if not exist "%EmptyDir%" (%dk_call% dk_mkdir "%EmptyDir%")
	if not exist "%NotDir%" (echo( > %NotDir%)

    ::###### Using if return value
	%dk_call% dk_echo
    %dk_call% dk_isEmptyDirectory "%EmptyDir%" result
    if %result% equ 0 (%dk_call% dk_info "'EmptyDir' is a empty directory")       else (%dk_call% dk_info "'EmptyDir' is NOT a empty directory")
    %dk_call% dk_isEmptyDirectory "%NotEmptyDir%" result
    if %result% equ 0 (%dk_call% dk_info "'NotEmptyDir' is a empty directory")    else (%dk_call% dk_info "'NotEmptyDir' is NOT a empty directory")
	%dk_call% dk_isEmptyDirectory "%NotDir%" result
    if %result% equ 0 (%dk_call% dk_info "'NotDir' is a empty directory")         else (%dk_call% dk_info "'NotDir' is NOT a empty directory")
	%dk_call% dk_isEmptyDirectory "%NonExistentDir%" result
    if %result% equ 0 (%dk_call% dk_info "'NonExistentDir' is a empty directory") else (%dk_call% dk_info "'NonExistentDir' is NOT a empty directory")
   
    ::###### Using if ERRORLEVEL
	%dk_call% dk_echo
    %dk_call% dk_isEmptyDirectory "%EmptyDir%"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'EmptyDir' is a empty directory")       else (%dk_call% dk_info "'EmptyDir' is NOT a empty directory")
    %dk_call% dk_isEmptyDirectory "%NotEmptyDir%"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'NotEmptyDir' is a empty directory")    else (%dk_call% dk_info "'NotEmptyDir' is NOT a empty directory")
	%dk_call% dk_isEmptyDirectory "%NotDir%"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'NotDir' is a empty directory")         else (%dk_call% dk_info "'NotDir' is NOT a empty directory")
	%dk_call% dk_isEmptyDirectory "%NonExistentDir%"
    if not ERRORLEVEL 1 (%dk_call% dk_info "'NonExistentDir' is a empty directory") else (%dk_call% dk_info "'NonExistentDir' is NOT a empty directory")
   
    ::###### Using && and || conditionals
	%dk_call% dk_echo
    %dk_call% dk_isEmptyDirectory "%EmptyDir%"       && %dk_call% dk_info "'EmptyDir' is a empty directory"       || %dk_call% dk_info "'EmptyDir' is NOT a empty directory"
    %dk_call% dk_isEmptyDirectory "%NotEmptyDir%"    && %dk_call% dk_info "'NotEmptyDir' is a empty directory"    || %dk_call% dk_info "'NotEmptyDir' is NOT a empty directory"
	%dk_call% dk_isEmptyDirectory "%NotDir%"         && %dk_call% dk_info "'NotDir' is a empty directory"         || %dk_call% dk_info "'NotDir' is NOT a empty directory"
	%dk_call% dk_isEmptyDirectory "%NonExistentDir%" && %dk_call% dk_info "'NonExistentDir' is a empty directory" || %dk_call% dk_info "'NonExistentDir' is NOT a empty directory"

	%dk_call% dk_delete "%NotEmptyDir%"
%endfunction%

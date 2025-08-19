@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_isNonEmptyDirectory(path rtn_var)
::#
::#
:dk_isNonEmptyDirectory
%setlocal%
	%dk_call% dk_debugFunc 1 2
	
	set "dk_isNonEmptyDirectory=1"
	if NOT EXIST %~1\* (
		%dk_call% dk_error "%~1 is NOT a directory"
		set "dk_isNonEmptyDirectory=1"
	)
	
	for /F %%i in ('dir /b /a "%~1\*" 2^>nul') do (
		set "dk_isNonEmptyDirectory=0"
	)
	
	endlocal & (
		set "dk_isNonEmptyDirectory=%dk_isNonEmptyDirectory%"
		if "%~2" neq "" (set "%~2=%dk_isNonEmptyDirectory%")
		exit /b %dk_isNonEmptyDirectory%
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
	if NOT EXIST "%EmptyDir%" (%dk_call% dk_mkdir "%EmptyDir%")
	if NOT EXIST "%NotDir%" (echo( > %NotDir%)

    ::###### Using if return value
	%dk_call% dk_echo
    %dk_call% dk_isNonEmptyDirectory "%EmptyDir%" result
    if %result% equ 0 (%dk_call% dk_info "'EmptyDir' is a non-empty directory")       else (%dk_call% dk_info "'EmptyDir' is NOT a non-empty directory")
    %dk_call% dk_isNonEmptyDirectory "%NotEmptyDir%" result
    if %result% equ 0 (%dk_call% dk_info "'NotEmptyDir' is a non-empty directory")    else (%dk_call% dk_info "'NotEmptyDir' is NOT a non-empty directory")
	%dk_call% dk_isNonEmptyDirectory "%NotDir%" result
    if %result% equ 0 (%dk_call% dk_info "'NotDir' is a non-empty directory")         else (%dk_call% dk_info "'NotDir' is NOT a non-empty directory")
	%dk_call% dk_isNonEmptyDirectory "%NonExistentDir%" result
    if %result% equ 0 (%dk_call% dk_info "'NonExistentDir' is a non-empty directory") else (%dk_call% dk_info "'NonExistentDir' is NOT a non-empty directory")
   
    ::###### Using if ERRORLEVEL
	%dk_call% dk_echo
    %dk_call% dk_isNonEmptyDirectory "%EmptyDir%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_info "'EmptyDir' is a non-empty directory")       else (%dk_call% dk_info "'EmptyDir' is NOT a non-empty directory")
    %dk_call% dk_isNonEmptyDirectory "%NotEmptyDir%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_info "'NotEmptyDir' is a non-empty directory")    else (%dk_call% dk_info "'NotEmptyDir' is NOT a non-empty directory")
	%dk_call% dk_isNonEmptyDirectory "%NotDir%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_info "'NotDir' is a empty non-directory")         else (%dk_call% dk_info "'NotDir' is NOT a non-empty directory")
	%dk_call% dk_isNonEmptyDirectory "%NonExistentDir%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_info "'NonExistentDir' is a non-empty directory") else (%dk_call% dk_info "'NonExistentDir' is NOT a non-empty directory")
   
    ::###### Using && and || conditionals
	%dk_call% dk_echo
    %dk_call% dk_isNonEmptyDirectory "%EmptyDir%"       && %dk_call% dk_info "'EmptyDir' is a non-empty directory"       || %dk_call% dk_info "'EmptyDir' is NOT a non-empty directory"
    %dk_call% dk_isNonEmptyDirectory "%NotEmptyDir%"    && %dk_call% dk_info "'NotEmptyDir' is a non-empty directory"    || %dk_call% dk_info "'NotEmptyDir' is NOT a non-empty directory"
	%dk_call% dk_isNonEmptyDirectory "%NotDir%"         && %dk_call% dk_info "'NotDir' is a empty non-directory"         || %dk_call% dk_info "'NotDir' is NOT a non-empty directory"
	%dk_call% dk_isNonEmptyDirectory "%NonExistentDir%" && %dk_call% dk_info "'NonExistentDir' is a non-empty directory" || %dk_call% dk_info "'NonExistentDir' is NOT a non-empty directory"

	%dk_call% dk_delete "%NotEmptyDir%"
%endfunction%

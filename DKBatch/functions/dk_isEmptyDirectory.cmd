@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_isEmptyDirectory(path rtn_var)
::#
::#
:dk_isEmptyDirectory
%setlocal%
	%dk_call% dk_debugFunc 1 2
	
	set "dk_isEmptyDirectory=0"
	if NOT EXIST "%~1\*" (
		%dk_call% dk_error "%~1 is NOT a directory"
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
	if NOT EXIST "%EmptyDir%" (%dk_call% dk_mkdir "%EmptyDir%")
	if NOT EXIST "%NotDir%" (echo( > %NotDir%)

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
    if NOT ERRORLEVEL 1 (%dk_call% dk_info "'EmptyDir' is a empty directory")       else (%dk_call% dk_info "'EmptyDir' is NOT a empty directory")
    %dk_call% dk_isEmptyDirectory "%NotEmptyDir%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_info "'NotEmptyDir' is a empty directory")    else (%dk_call% dk_info "'NotEmptyDir' is NOT a empty directory")
	%dk_call% dk_isEmptyDirectory "%NotDir%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_info "'NotDir' is a empty directory")         else (%dk_call% dk_info "'NotDir' is NOT a empty directory")
	%dk_call% dk_isEmptyDirectory "%NonExistentDir%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_info "'NonExistentDir' is a empty directory") else (%dk_call% dk_info "'NonExistentDir' is NOT a empty directory")
   
    ::###### Using && and || conditionals
	%dk_call% dk_echo
    %dk_call% dk_isEmptyDirectory "%EmptyDir%"       && %dk_call% dk_info "'EmptyDir' is a empty directory"       || %dk_call% dk_info "'EmptyDir' is NOT a empty directory"
    %dk_call% dk_isEmptyDirectory "%NotEmptyDir%"    && %dk_call% dk_info "'NotEmptyDir' is a empty directory"    || %dk_call% dk_info "'NotEmptyDir' is NOT a empty directory"
	%dk_call% dk_isEmptyDirectory "%NotDir%"         && %dk_call% dk_info "'NotDir' is a empty directory"         || %dk_call% dk_info "'NotDir' is NOT a empty directory"
	%dk_call% dk_isEmptyDirectory "%NonExistentDir%" && %dk_call% dk_info "'NonExistentDir' is a empty directory" || %dk_call% dk_info "'NonExistentDir' is NOT a empty directory"

	%dk_call% dk_delete "%NotEmptyDir%"
%endfunction%

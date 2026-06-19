@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ####################################################################
rem # dk_isNonEmptyDirectory(path rtn_var)
rem #
rem #
:dk_isNonEmptyDirectory
%setlocal%
	
	set "dk_isNonEmptyDirectory=1"
	if NOT EXIST "%~1\*" (
		rem %dk_call% dk_warning "%~1 is NOT a directory"
		set "dk_isNonEmptyDirectory=1"
	)
	
	for /F %%i in ('dir /b /a "%~1\*" 2^>nul') do (
		set "dk_isNonEmptyDirectory=0"
	)
	
	endlocal & (
		set "dk_isNonEmptyDirectory=%dk_isNonEmptyDirectory%"
		if "%~2" neq "" (set "%~2=%dk_isNonEmptyDirectory%")
		echo %dk_isNonEmptyDirectory%
		exit /b %dk_isNonEmptyDirectory%
	)
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
	rem ###### Create The Directories and Files ######
	set "EmptyDir=C:/NotEmptyDir/EmptyDir"
	set "NotEmptyDir=C:/NotEmptyDir"
	set "NotDir=C:/NotEmptyDir/file.txt"
	set "NonExistentDir=C:/NonExistentDir"
	%dk_call% dk_mkdir "%EmptyDir%"
	if NOT EXIST "%NotDir%" (echo. > %NotDir%)

    rem ###### Using if return value
	%dk_call% dk_echo
    %dk_call% dk_isNonEmptyDirectory "%EmptyDir%" result
    if %result% equ 0 (%dk_call% dk_info "'EmptyDir' is a non-empty directory")       else (%dk_call% dk_info "'EmptyDir' is NOT a non-empty directory")
    %dk_call% dk_isNonEmptyDirectory "%NotEmptyDir%" result
    if %result% equ 0 (%dk_call% dk_info "'NotEmptyDir' is a non-empty directory")    else (%dk_call% dk_info "'NotEmptyDir' is NOT a non-empty directory")
	%dk_call% dk_isNonEmptyDirectory "%NotDir%" result
    if %result% equ 0 (%dk_call% dk_info "'NotDir' is a non-empty directory")         else (%dk_call% dk_info "'NotDir' is NOT a non-empty directory")
	%dk_call% dk_isNonEmptyDirectory "%NonExistentDir%" result
    if %result% equ 0 (%dk_call% dk_info "'NonExistentDir' is a non-empty directory") else (%dk_call% dk_info "'NonExistentDir' is NOT a non-empty directory")
   
    rem ###### Using if ERRORLEVEL
	%dk_call% dk_echo
    %dk_call% dk_isNonEmptyDirectory "%EmptyDir%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_info "'EmptyDir' is a non-empty directory")       else (%dk_call% dk_info "'EmptyDir' is NOT a non-empty directory")
    %dk_call% dk_isNonEmptyDirectory "%NotEmptyDir%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_info "'NotEmptyDir' is a non-empty directory")    else (%dk_call% dk_info "'NotEmptyDir' is NOT a non-empty directory")
	%dk_call% dk_isNonEmptyDirectory "%NotDir%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_info "'NotDir' is a empty non-directory")         else (%dk_call% dk_info "'NotDir' is NOT a non-empty directory")
	%dk_call% dk_isNonEmptyDirectory "%NonExistentDir%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_info "'NonExistentDir' is a non-empty directory") else (%dk_call% dk_info "'NonExistentDir' is NOT a non-empty directory")
   
    rem ###### Using && and || conditionals
	%dk_call% dk_echo
    %dk_call% dk_isNonEmptyDirectory "%EmptyDir%"       && %dk_call% dk_info "'EmptyDir' is a non-empty directory"       || %dk_call% dk_info "'EmptyDir' is NOT a non-empty directory"
    %dk_call% dk_isNonEmptyDirectory "%NotEmptyDir%"    && %dk_call% dk_info "'NotEmptyDir' is a non-empty directory"    || %dk_call% dk_info "'NotEmptyDir' is NOT a non-empty directory"
	%dk_call% dk_isNonEmptyDirectory "%NotDir%"         && %dk_call% dk_info "'NotDir' is a empty non-directory"         || %dk_call% dk_info "'NotDir' is NOT a non-empty directory"
	%dk_call% dk_isNonEmptyDirectory "%NonExistentDir%" && %dk_call% dk_info "'NonExistentDir' is a non-empty directory" || %dk_call% dk_info "'NonExistentDir' is NOT a non-empty directory"

	%dk_call% dk_delete "%NotEmptyDir%"
%endfunction%

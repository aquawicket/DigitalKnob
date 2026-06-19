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
rem # dk_isEmptyDirectory(path)
rem #
rem #
:dk_isEmptyDirectory
%setlocal%
	
	set "dk_isEmptyDirectory_argv1=%~1"
	set "dk_isEmptyDirectory=0"
	
	if NOT EXIST "%~1\*" (
		set /a "dk_isEmptyDirectory=1"
	)
	
	for /F %%i in ('dir /b /a "%~1\*" 2^>nul') do (
		set /a "dk_isEmptyDirectory=1"
	)
	
	:return
	endlocal & (
		set "dk_isEmptyDirectory=%dk_isEmptyDirectory%"
		set "dk_isEmptyDirectory_argv1=%dk_isEmptyDirectory_argv1%"
	)
	%return% %dk_isEmptyDirectory%
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
    %dk_call% dk_isEmptyDirectory "%EmptyDir%"
	if "%dk_isEmptyDirectory%" equ "0" (%dk_call% dk_success "dk_isEmptyDirectory '!dk_isEmptyDirectory_argv1!' = %dk_isEmptyDirectory%")	else (%dk_call% dk_error "dk_isEmptyDirectory '!dk_isEmptyDirectory_argv1!' = %dk_isEmptyDirectory%")

    %dk_call% dk_isEmptyDirectory "%NotEmptyDir%"
    if "%dk_isEmptyDirectory%" equ "0" (%dk_call% dk_error "dk_isEmptyDirectory '!dk_isEmptyDirectory_argv1!' = %dk_isEmptyDirectory%")	else (%dk_call% dk_success "dk_isEmptyDirectory '!dk_isEmptyDirectory_argv1!' = %dk_isEmptyDirectory%")
	
	%dk_call% dk_isEmptyDirectory "%NotDir%"
    if "%dk_isEmptyDirectory%" equ "0" (%dk_call% dk_error "dk_isEmptyDirectory '!dk_isEmptyDirectory_argv1!' = %dk_isEmptyDirectory%")	else (%dk_call% dk_success "dk_isEmptyDirectory '!dk_isEmptyDirectory_argv1!' = %dk_isEmptyDirectory%")
	
	%dk_call% dk_isEmptyDirectory "%NonExistentDir%"
    if "%dk_isEmptyDirectory%" equ "0" (%dk_call% dk_error "dk_isEmptyDirectory '!dk_isEmptyDirectory_argv1!' = %dk_isEmptyDirectory%")	else (%dk_call% dk_success "dk_isEmptyDirectory '!dk_isEmptyDirectory_argv1!' = %dk_isEmptyDirectory%")
   
    rem ###### Using if ERRORLEVEL
	%dk_call% dk_echo
	%dk_call% dk_isEmptyDirectory "%EmptyDir%"
	if NOT ERRORLEVEL 1 (echo.%green%)	else (echo.%red%)
	echo %__CALL__% "%__PATH__:/=\%" %__ARGS__%
	echo %clr%
	
	%dk_call% dk_isEmptyDirectory "%NotEmptyDir%"
	if NOT ERRORLEVEL 1 (%dk_call% dk_error "'!dk_isEmptyDirectory_argv1!' is a empty directory")	else (%dk_call% dk_success "'!dk_isEmptyDirectory_argv1!' is NOT a empty directory")
	%dk_call% dk_isEmptyDirectory "%NotDir%"
	if NOT ERRORLEVEL 1 (%dk_call% dk_error "'!dk_isEmptyDirectory_argv1!' is a empty directory")	else (%dk_call% dk_success "'!dk_isEmptyDirectory_argv1!' is NOT a empty directory")
	%dk_call% dk_isEmptyDirectory "%NonExistentDir%"
	if NOT ERRORLEVEL 1 (%dk_call% dk_error "'!dk_isEmptyDirectory_argv1!' is a empty directory")	else (%dk_call% dk_success "'!dk_isEmptyDirectory_argv1!' is NOT a empty directory")
   
    rem ###### Using && and || conditionals
	echo.
	%dk_call% dk_isEmptyDirectory "%EmptyDir%"       && %dk_call% dk_success "'!dk_isEmptyDirectory_argv1!' is a empty directory"	|| %dk_call% dk_error "'!dk_isEmptyDirectory_argv1!' is NOT a empty directory"
	%dk_call% dk_isEmptyDirectory "%NotEmptyDir%"    && %dk_call% dk_error "'!dk_isEmptyDirectory_argv1!' is a empty directory"		|| %dk_call% dk_success "'!dk_isEmptyDirectory_argv1!' is NOT a empty directory"
	%dk_call% dk_isEmptyDirectory "%NotDir%"         && %dk_call% dk_error "'!dk_isEmptyDirectory_argv1!' is a empty directory"		|| %dk_call% dk_success "'!dk_isEmptyDirectory_argv1!' is NOT a empty directory"
	%dk_call% dk_isEmptyDirectory "%NonExistentDir%" && %dk_call% dk_error "'!dk_isEmptyDirectory_argv1!' is a empty directory"		|| %dk_call% dk_success "'!dk_isEmptyDirectory_argv1!' is NOT a empty directory"
	
	rem ###### called directly Using && and || conditionals
	echo.
	call "%DKBATCH_FUNCTIONS_DIR_%dk_isEmptyDirectory.cmd" "%EmptyDir%"       && %dk_call% dk_success "'!dk_isEmptyDirectory_argv1!' is a empty directory"	|| %dk_call% dk_error "'!dk_isEmptyDirectory_argv1!' is NOT a empty directory"
	call "%DKBATCH_FUNCTIONS_DIR_%dk_isEmptyDirectory.cmd" "%NotEmptyDir%"    && %dk_call% dk_error "'!dk_isEmptyDirectory_argv1!' is a empty directory"	|| %dk_call% dk_success "'!dk_isEmptyDirectory_argv1!' is NOT a empty directory"
	call "%DKBATCH_FUNCTIONS_DIR_%dk_isEmptyDirectory.cmd" "%NotDir%"         && %dk_call% dk_error "'!dk_isEmptyDirectory_argv1!' is a empty directory"	|| %dk_call% dk_success "'!dk_isEmptyDirectory_argv1!' is NOT a empty directory"
	call "%DKBATCH_FUNCTIONS_DIR_%dk_isEmptyDirectory.cmd" "%NonExistentDir%" && %dk_call% dk_error "'!dk_isEmptyDirectory_argv1!' is a empty directory"	|| %dk_call% dk_success "'!dk_isEmptyDirectory_argv1!' is NOT a empty directory"
	
	:cleanup
	%dk_call% dk_delete "%NotEmptyDir%"
%endfunction%

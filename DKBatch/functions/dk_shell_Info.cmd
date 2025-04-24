<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::################################################################################
::# dk_shell_Info()
::#
::#
:dk_shell_Info
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
    echo %PSModulePath% | findstr %USERPROFILE% >NUL
    if %ERRORLEVEL% equ 0 set "DKSHELL_NAME=powershell" & goto done
    echo %PSModulePath% | findstr %USERPROFILE% >NUL
    if %ERRORLEVEL% equ 0 set "DKSHELL_NAME=powershell" & goto done
    if not defined DKSHELL_NAME for %%Z in ("%SHELL%") do set "DKSHELL_NAME=%%~nZ"
    if not defined DKSHELL_NAME for %%Z in ("%ComSpec%") do set "DKSHELL_NAME=%%~nZ"
    
    :done
    echo DKSHELL_NAME = %DKSHELL_NAME%
    
    if "%DKSHELL%"=="powershell" for /F "tokens=* USEBACKQ" %%F IN (`where powershell.exe`) do set DKSHELL_PATH=%%F
    if not defined DKSHELL_PATH set "DKSHELL_PATH=%SHELL%"
    if not defined DKSHELL_PATH set "DKSHELL_PATH=%ComSpec%"
    echo DKSHELL_PATH = %DKSHELL_PATH%
=======
setlocal
	%dk_call% dk_debugFunc 0
	
	echo %PSModulePath% | findstr %USERPROFILE% >NUL
	if %ERRORLEVEL% equ 0 set "DKSHELL_NAME=powershell" & goto done
	echo %PSModulePath% | findstr %USERPROFILE% >NUL
	if %ERRORLEVEL% equ 0 set "DKSHELL_NAME=powershell" & goto done
	if not defined DKSHELL_NAME for %%Z in ("%SHELL%") do set "DKSHELL_NAME=%%~nZ"
	if not defined DKSHELL_NAME for %%Z in ("%ComSpec%") do set "DKSHELL_NAME=%%~nZ"

	:done
	echo DKSHELL_NAME = %DKSHELL_NAME%

	if "%DKSHELL_NAME%" equ "powershell" for /F "tokens=* USEBACKQ" %%F IN (`where powershell.exe`) do set DKSHELL_PATH=%%F
	if not defined DKSHELL_PATH set "DKSHELL_PATH=%SHELL%"
	if not defined DKSHELL_PATH set "DKSHELL_PATH=%ComSpec%"
	echo DKSHELL_PATH = %DKSHELL_PATH%
>>>>>>> Development
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
  
=======
setlocal
	%dk_call% dk_debugFunc 0
 
>>>>>>> Development
    %dk_call% dk_shell_Info
%endfunction%


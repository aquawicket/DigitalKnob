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
rem # dk_isFile(path rtn_var)
rem #
rem #
:dk_isFile
%setlocal%

	%dk_call% dk_assertPath "%~1"

	if NOT EXIST "%~1" (
		set "dk_isFile=-1"
		exit /b %dk_isFile%
	)
	
	if NOT EXIST "%~1/*" (
		set "dk_isFile=0"
	) else (
		set "dk_isFile=1"
	)

    endlocal & (
		set "dk_isFile=%dk_isFile%"
		if "%~2" neq "" (set "%~2=%dk_isFile%")
		exit /b %dk_isFile%
	)
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
	rem ############ C:/Windows/notepad.exe ############
    rem ###### Using if return value
	set "myPath=C:/Windows/notepad.exe"
    %dk_call% dk_isFile "%myPath%"
    if "%dk_isFile%" equ "0" (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
	rem ###### Using if ERRORLEVEL
	%dk_call% dk_isFile "%myPath%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
    rem ###### Using && and || conditionals
    %dk_call% dk_isFile "%myPath%" && %dk_call% dk_info "'%myPath%' is a file" || %dk_call% dk_info "'%myPath%' is NOT a file"
	
	rem ############ C:/Windows ############
	rem ###### Using if return value
	set "myPath=C:/Windows"
    %dk_call% dk_isFile "%myPath%"
    if %dk_isFile% equ 0 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
	rem ###### Using if ERRORLEVEL
	%dk_call% dk_isFile "%myPath%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
	rem ###### Using && and || conditionals
    %dk_call% dk_isFile "%myPath%" && %dk_call% dk_info "'%myPath%' is a file" || %dk_call% dk_info "'%myPath%' is NOT a file"
	
	rem ############ C:/Windows/ ############
	rem ###### Using if return value
	set "myPath=C:/Windows/"
    %dk_call% dk_isFile "%myPath%"
    if %dk_isFile% equ 0 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
	rem ###### Using if ERRORLEVEL
	%dk_call% dk_isFile "%myPath%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
	rem ###### Using && and || conditionals
    %dk_call% dk_isFile "%myPath%" && %dk_call% dk_info "'%myPath%' is a file" || %dk_call% dk_info "'%myPath%' is NOT a file"
	
	rem ############ %SystemRoot%\notepad.exe ############
    rem ###### Using if return value
	set "myPath=%SystemRoot%\notepad.exe"
    %dk_call% dk_isFile "%myPath%"
    if %dk_isFile% equ 0 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
	rem ###### Using if ERRORLEVEL
	%dk_call% dk_isFile "%myPath%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
    rem ###### Using && and || conditionals
    %dk_call% dk_isFile "%myPath%" && %dk_call% dk_info "'%myPath%' is a file" || %dk_call% dk_info "'%myPath%' is NOT a file"
	
	rem ############ C:/NonExistent.exe ############
    rem ###### Using if return value
	set "myPath=C:/NonExistent.exe"
    %dk_call% dk_isFile "%myPath%"
    if %dk_isFile% equ 0 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
	rem ###### Using if ERRORLEVEL
	%dk_call% dk_isFile "%myPath%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file"
    rem ###### Using && and || conditionals
    %dk_call% dk_isFile "%myPath%" && %dk_call% dk_info "'%myPath%' is a file" || %dk_call% dk_info "'%myPath%' is NOT a file"
	
	rem ############ C:/NonExistent ############
    rem ###### Using if return value
	set "myPath=C:/NonExistent"
    %dk_call% dk_isFile "%myPath%"
    if %dk_isFile% equ 0 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
	rem ###### Using if ERRORLEVEL
	%dk_call% dk_isFile "%myPath%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a file") else (%dk_call% dk_info "'%myPath%' is NOT a file")
    rem ###### Using && and || conditionals
    %dk_call% dk_isFile "%myPath%" && %dk_call% dk_info "'%myPath%' is a file" || %dk_call% dk_info "'%myPath%' is NOT a file"
%endfunction%

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
rem # dk_isDirectory(path rtn_var)
rem #
rem #
:dk_isDirectory
%setlocal%

	set "dk_isDirectory=1"
    if EXIST "%~1/*" (
		set "dk_isDirectory=0"
    )
   
  
	endlocal & (
		set "dk_isDirectory=%dk_isDirectory%"
		if "%~2" neq "" (set "%~2=%dk_isDirectory%")
		exit /b %dk_isDirectory%
    ) 
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
    rem ###### Using if return value
	set "myPath=C:/Windows"
    %dk_call% dk_isDirectory "%myPath%" result
    if /i "%result%" equ "0" (%dk_call% dk_info "'%myPath%' is a directory") else (%dk_call% dk_info "'%myPath%' is NOT a directory")
	if /i "%dk_isDirectory%" equ "0" (%dk_call% dk_info "'%myPath%' is a directory") else (%dk_call% dk_info "'%myPath%' is NOT a directory")
	
	set "myPath=C:/NotADir"
    %dk_call% dk_isDirectory "%myPath%" result
    if /i "%result%" equ "0" (%dk_call% dk_info "'%myPath%' is a directory") else (%dk_call% dk_info "'%myPath%' is NOT a directory")
   
    rem ###### Using if ERRORLEVEL
	set "myPath=C:/Windows"
	%dk_call% dk_isDirectory "%myPath%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a directory") else (%dk_call% dk_info "'%myPath%' is NOT a directory")
	
    set "myPath=C:/NotADir"
	%dk_call% dk_isDirectory "%myPath%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a directory") else (%dk_call% dk_info "'%myPath%' is NOT a directory")
   
    rem ###### Using && and || conditionals
	set "myPath=C:/Windows"
    %dk_call% dk_isDirectory "%myPath%" && %dk_call% dk_info "'%myPath%' is a directory" || %dk_call% dk_info "'%myPath%' is NOT a directory"
	
	set "myPath=C:/NotADir"
    %dk_call% dk_isDirectory "%myPath%" && %dk_call% dk_info "'%myPath%' is a directory" || %dk_call% dk_info "'%myPath%' is NOT a directory"
%endfunction%

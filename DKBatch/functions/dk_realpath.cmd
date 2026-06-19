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


rem ################################################################################
rem # dk_realpath(path, rtn_var:OPTIONAL)
rem #
rem #    SHELL: https://man7.org/linux/man-pages/man1/realpath.1.html
rem #
:dk_realpath
%setlocal%
   
	set "pathname=%~1"
    set "pathname=%pathname:"=%"
	
    for %%A in ("%pathname%") do (set "dk_realpath=%%~fA")
	if "%dk_realpath:~-1%" equ "\" (set "dk_realpath=%dk_realpath:~0,-1%")
	
	%dk_call% dk_readlink "%dk_realpath%" dk_realpath

	:return
	endlocal & (
		set "dk_realpath=%dk_realpath:\=/%"
		if "%~2" neq "" (set "%~2=%dk_realpath:\=/%")
		set "find.exe=%find.exe%"
		if NOT EXIST "%dk_realpath%" (exit /b 1)
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	echo.
    set "myPath=NonExistent"
    %dk_call% dk_realpath "%myPath%"
    %dk_call% dk_debug "dk_realpath = %dk_realpath%"
	
	echo.
    set "myPath=DK.cmd"
    %dk_call% dk_realpath "%myPath%"
    %dk_call% dk_debug "dk_realpath = %dk_realpath%"
	
	echo.
    set "myPath=Test"
    %dk_call% dk_realpath "%myPath%"
    %dk_call% dk_debug "dk_realpath = %dk_realpath%"
	
	echo.
    set "myPath=../functions"
    %dk_call% dk_realpath "%myPath%"
    %dk_call% dk_debug "dk_realpath = %dk_realpath%"
	
	echo.
    set "myPath=%USERPROFILE:\=/%/Desktop/DKBuilder.cmd"
    %dk_call% dk_realpath "%myPath%"
    %dk_call% dk_debug "dk_realpath = %dk_realpath%"
	
	echo.
	set "myPath=%USERPROFILE:\=/%/Desktop/Digital Knob"
	%dk_call% dk_realpath "%myPath%"
  %dk_call% dk_debug "dk_realpath = %dk_realpath%"
%endfunction%

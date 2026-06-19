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
rem # dk_isSymlink(path)
rem #
:dk_isSymlink
%setlocal%

	%dk_call% dk_fileAttributes "%~1"
	%dk_call% dk_includes "%dk_fileAttributes%" "l" && (set "dk_isSymlink=0") || (set "dk_isSymlink=1")


	:return
	endlocal & (
		set "dk_isSymlink_1=%~1"
		set "dk_isSymlink=%dk_isSymlink%"
		if "%~2" neq "" (set "%~2=%dk_isSymlink%")
	)
    exit /b %dk_isSymlink%
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
    rem ###### Using if return value
rem	set "myPath=C:/Windows/notepad.exe"
rem %dk_call% dk_isSymlink "%myPath%" result
rem if /i "%result%" equ "true" (%dk_call% dk_info "'%myPath%' is a symlink") else (%dk_call% dk_info "'%myPath%' is NOT a symlink")
  
rem	set "myPath=C:/NotADir"
rem %dk_call% dk_isSymlink "%myPath%" result
rem if /i "%result%" equ "true" (%dk_call% dk_info "'%myPath%' is a symlink") else (%dk_call% dk_info "'%myPath%' is NOT a symlink")
   
	rem ###### Using if ERRORLEVEL
rem	set "myPath=C:/Windows"
rem	%dk_call% dk_isSymlink "%myPath%"
rem if NOT ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a symlink") else (%dk_call% dk_info "'%myPath%' is NOT a symlink")
	
rem set "myPath=C:/NotADir"
rem	%dk_call% dk_isSymlink "%myPath%"
rem if NOT ERRORLEVEL 1 (%dk_call% dk_info "'%myPath%' is a symlink") else (%dk_call% dk_info "'%myPath%' is NOT a symlink")
   
	rem ###### Using && and || conditionals
	set "myPath=%USERPROFILE:\=/%/Desktop/DKBuilder.cmd"
    %dk_call% dk_isSymlink "%myPath%" && (%dk_call% dk_debug "'!dk_isSymlink_1!' is a symlink") || (%dk_call% dk_debug "'!dk_isSymlink_1!' is NOT a symlink")
	
	set "myPath=%USERPROFILE:\=/%/Desktop/Digital Knob"
    %dk_call% dk_isSymlink "%myPath%" && (%dk_call% dk_debug "'!dk_isSymlink_1!' is a symlink") || (%dk_call% dk_debug "'!dk_isSymlink_1!' is NOT a symlink")
	
	set "myPath=%USERPROFILE:\=/%/Desktop"
    %dk_call% dk_isSymlink "%myPath%" && (%dk_call% dk_debug "'!dk_isSymlink_1!' is a symlink") || (%dk_call% dk_debug "'!dk_isSymlink_1!' is NOT a symlink")
%endfunction%

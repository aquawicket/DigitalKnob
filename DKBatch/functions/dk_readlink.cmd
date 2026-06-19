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
rem # dk_readlink(path rtn_var:OPTIONAL)
rem #
rem #    read the contents of a symbolic link
rem #
rem #    SHELL: https://man7.org/linux/man-pages/man1/realpath.1.html
rem #    C:     https://pubs.opengroup.org/onlinepubs/9699919799/functions/readlink.html
rem #
:dk_readlink
%setlocal%

    set dk_readlink=%~1
    set dk_readlink=%dk_readlink:"=%
	set dk_readlink=%dk_readlink:/=\%
    if "%dk_readlink:~-1%" equ "\" set dk_readlink=%dk_readlink:~0,-1%
	
	%dk_call% dk_validate find.exe %dk_call% dk_findFile find.exe
	for /f "usebackq tokens=2 delims=[]" %%i in (`dir %dk_readlink%* 2^>nul ^| "%find.exe:/=\%" "<SYMLINK"`) do (
		set "dk_readlink=%%i"
	)

	:return
	endlocal & (
		set "dk_readlink=%dk_readlink:\=/%"
		if "%~2" neq "" (set "%~2=%dk_readlink:\=/%")
		set "find.exe=%find.exe%"
	)
	rem %dk_call% dk_debug "dk_readlink = %dk_readlink%"
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
	set Path=
	
	set "myPath=%USERPROFILE:\=/%/Desktop/DKBuilder.cmd"
    %dk_call% dk_readlink "%myPath%"
    %dk_call% dk_debug "%myPath% = '%dk_readlink%'"
	
    set "myPath=%USERPROFILE:\=/%/Desktop/Digital Knob"
    %dk_call% dk_readlink "%myPath%"
    %dk_call% dk_debug "%myPath% = '%dk_readlink%'"
	
	set "myPath=%USERPROFILE:\=/%/Desktop"
    %dk_call% dk_readlink "%myPath%"
    %dk_call% dk_debug "%myPath% = '%dk_readlink%'"
	
	set "myPath=%USERPROFILE:\=/%/NonExistent"
    %dk_call% dk_readlink "%myPath%"
    %dk_call% dk_debug "%myPath% = '%dk_readlink%'"
%endfunction%

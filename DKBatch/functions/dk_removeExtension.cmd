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


rem ##################################################################################
rem # dk_removeExtension(filepath rtn_var:OPTIONAL)
rem #
rem #
:dk_removeExtension
%setlocal%
   
    set "_filepath_=%~1"
    %dk_call% dk_getExtension "%_filepath_%"
	if defined dk_getExtension (
		set "dk_removeExtension=!_filepath_:%dk_getExtension%=!"
	)
   
	rem %dk_call% dk_debug "dk_removeExtension = %dk_removeExtension%"
    endlocal & (
		set "dk_removeExtension=%dk_removeExtension%"
		if "%~2" neq "" (set "%~2=%dk_removeExtension%")
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
	echo.
	set "myPath=/test/test2/xfile.exten"
	%dk_call% dk_removeExtension "%myPath%"
	%dk_call% dk_debug "dk_removeExtension = %dk_removeExtension%"

	echo.
	set "myPath=test.zip"
	%dk_call% dk_removeExtension "%myPath%"
	%dk_call% dk_debug "dk_removeExtension = %dk_removeExtension%"

	echo.
	set "myPath=test.tar.gz"
	%dk_call% dk_removeExtension "%myPath%"
	%dk_call% dk_debug "dk_removeExtension = %dk_removeExtension%"

	echo.
	set "myPath=test.tar.xz.tar.gz.tar.xz"
	%dk_call% dk_removeExtension "%myPath%"
	%dk_call% dk_debug "dk_removeExtension = %dk_removeExtension%"

	echo.
	set "myPath=test.tar.x.gz"
	%dk_call% dk_removeExtension "%myPath%"
	%dk_call% dk_debug "dk_removeExtension = %dk_removeExtension%"

	echo.
	set "myPath=test.tar.xz"
	%dk_call% dk_removeExtension "%myPath%"
	%dk_call% dk_debug "dk_removeExtension = %dk_removeExtension%"

	echo.
	set "myPath=test.7z.exe.b"
	%dk_call% dk_removeExtension "%myPath%"
	%dk_call% dk_debug "dk_removeExtension = %dk_removeExtension%"

	echo.
	set "myPath=test.7z.exe"
	%dk_call% dk_removeExtension "%myPath%"
	%dk_call% dk_debug "dk_removeExtension = %dk_removeExtension%"
	
	echo.
	set "myPath=noExt"
	%dk_call% dk_removeExtension "%myPath%"
	%dk_call% dk_debug "dk_removeExtension = %dk_removeExtension%"
%endfunction%

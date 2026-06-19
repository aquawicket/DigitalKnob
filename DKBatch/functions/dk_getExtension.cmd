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
rem # dk_getExtension(<pathname>, <rtn_var>:optional)
rem #
rem #
:dk_getExtension
%setlocal%

	rem array of acceptable multi dot extensions
	set "ext[1]=7z.exe"
	set "ext[2]=sfx.exe"
	set "ext[3]=tar.gz"
	set "ext[4]=tar.xz"

	set "dk_getExtension=%~x1"
	set "pathname=%~nx1"
	set "pathname=%pathname:/=\%"
	set "pathname=%pathname:"=%"
	if "%pathname:~-1%" equ "\" set "pathname=%pathname:~0,-1%"
	if "%pathname:~-1%" equ "/" set "pathname=%pathname:~0,-1%"

	for /L %%i in (1,1,10) do (
		set "pathname=!pathname:*.=!"
		for /L %%i in (1,1,4) do (
			if /i "!pathname!" equ "!ext[%%i]!" (
				set "dk_getExtension=.!ext[%%i]!"
				goto:return
			)
		)
	)

	:return
	endlocal & (
		set "dk_getExtension=%dk_getExtension%"
		if "%~2" neq "" (
			set "%~2=%dk_getExtension%"
		)
	)
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	echo.
	set "myPath=/test/test2/xfile.exten"
	%dk_call% dk_getExtension "%myPath%"
	%dk_call% dk_debug "dk_getExtension = %dk_getExtension%"

	echo.
	set "myPath=test.zip"
	%dk_call% dk_getExtension %myPath%
	%dk_call% dk_debug "dk_getExtension = %dk_getExtension%"

	echo.
	set "myPath=test.tar.gz"
	%dk_call% dk_getExtension "test.tar.gz"
	%dk_call% dk_debug "dk_getExtension = %dk_getExtension%"

	echo.
	set "myPath=test.tar.xz.tar.gz.tar.xz"
	%dk_call% dk_getExtension test.tar.xz.tar.gz.tar.xz
	%dk_call% dk_debug "dk_getExtension = %dk_getExtension%"

	echo.
	set "myPath=test.tar.x.gz"
	%dk_call% dk_getExtension "%myPath%"
	%dk_call% dk_debug "dk_getExtension = %dk_getExtension%"

	echo.
	set "myPath=test.tar.xz"
	%dk_call% dk_getExtension %myPath%
	%dk_call% dk_debug "dk_getExtension = %dk_getExtension%"

	echo.
	set "myPath=test.7z.exe.b"
	%dk_call% dk_getExtension "test.7z.exe.b"
	%dk_call% dk_debug "dk_getExtension = %dk_getExtension%"

	echo.
	set "myPath=test.7z.exe"
	%dk_call% dk_getExtension test.7z.exe
	%dk_call% dk_debug "dk_getExtension = %dk_getExtension%"
	
	echo.
	set "myPath=noExt"
	%dk_call% dk_getExtension "%myPath%"
	%dk_call% dk_debug "dk_getExtension = %dk_getExtension%"
%endfunction%

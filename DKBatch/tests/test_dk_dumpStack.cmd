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
::# test_dk_dumpStack.cmd
::#
::#
::###### DK_Init ######
::

:func1
	echo :func1 %*
	call:func2
	echo returned from func2
	::call:func2 & (
	::	(goto) 2>nul
	::	call echo 0 = %%~0
	::	echo returned from func2
	::)
	pause
%endfunction%

:func2
	echo :func2 %*
	call:func3
	echo returned from func3
	::call:func3 123 & (
	::	(goto) 2>nul
	::	call echo 0 = %%~0
	::	echo returned from func3
	::)
%endfunction%

:func3
	echo :func3 %*
	call:func4
	echo returned from func4
	::call:func4 blue & (
	::	(goto) 2>nul
	::	call echo 0 = %%~0
	::	echo returned from func4
	::)
%endfunction%

:func4
	echo :func4 %*
	call:func5 orange
	echo returned from func5
%endfunction%

:func5
	echo :func5 %*
<:dk_dumpStackReturn <nul call dk_callstack
	echo returned from dk_callstack
%endfunction%

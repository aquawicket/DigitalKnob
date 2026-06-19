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
rem # dk_deleteArray(array)
rem #
rem #
:dk_deleteArray
 rem %setlocal%

	set /a "n=0"
	:loop1
	if defined %~1[%n%] (
		set "%~1[%n%]="
		set /a n+=1
		goto loop1
	)

	if defined %~1[0] (%dk_call% dk_error "%__FUNCTION__%: failed to delete array")
	rem DOSTIPS version
	rem :remove_array
	rem for /f "delims==" %%a in ('"set %~1[ 2>NUL"') do set "%%a="
	rem EXIT /b
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	set "myArrayA[0]=a b c"
	set "myArrayA[1]=1 2 3"
	set "myArrayA[2]=d e f"
	set "myArrayA[3]=4 5 6"
	set "myArrayA[4]=h i j"
	%dk_call% dk_printVar myArrayA

	%dk_call% dk_deleteArray myArrayA

	echo.
	%dk_call% dk_printVar myArrayA
%endfunction%

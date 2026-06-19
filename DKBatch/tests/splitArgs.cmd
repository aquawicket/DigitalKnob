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


call :splitArgs dk_cmake -G "MinGW Makefiles" -DTEST=1 "-DSTRING=Test string" "-SC:Windows/System32"
call :splitArgs dk_cmakeEval "dk_test('test dk_info message')" "return_valueA;return_valueB"
pause


:splitArgs
setlocal enableDelayedExpansion

	set __ALL__=%*
	if defined __ALL__ (
		set __CMND__=%1
		set __ARGS__=!__ALL__:*%1=!
	)
	
	echo __ALL__  %__ALL__%
	echo __CMND__ %__CMND__%
	echo __ARGS__ %__ARGS__%
exit /b 0




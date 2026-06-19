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
rem # dk_allButFirst2Args(args)
rem #
rem #
:dk_allButFirst2Args
%setlocal%

	set dk_allButFirst2Args=%*	
	for /f "tokens=2*" %%a in ("!dk_allButFirst2Args!") do (
		set dk_allButFirst2Args=%%b
	)
	
	:return
	endlocal & (
		set "dk_allButFirst2Args=%dk_allButFirst2Args%"
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    call :DKTEST_func abc 123 def 456
	call :DKTEST_func "abc" "123" "def" "456"
	call :DKTEST_func	abc	123	def	456
%endfunction%

:DKTEST_func
%setlocal%
	
	echo.
	echo ### Original Args ###
	call :DKTEST_printArgs %*
	
	%dk_call% dk_allButFirst2Args %*
	
	echo ### allButFirstArgs ###
	call :DKTEST_printArgs %dk_allButFirst2Args%
%endfunction%
	
:DKTEST_printArgs
%setlocal%
	
	echo * = '%*'
	if "%~1" neq "" (echo 1 = '%1')
	if "%~2" neq "" (echo 2 = '%2')
	if "%~3" neq "" (echo 3 = '%3')
	if "%~4" neq "" (echo 4 = '%4')
	if "%~5" neq "" (echo 5 = '%5')
	if "%~6" neq "" (echo 6 = '%6')
	if "%~7" neq "" (echo 7 = '%7')
	if "%~8" neq "" (echo 8 = '%8')
	if "%~9" neq "" (echo 9 = '%9')
%endfunction%

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
rem # dk_allButFirstArgs(args)
rem #
rem #
:dk_allButFirstArgs
%setlocal%

	set dk_allButFirstArgs=%*	
	for /f "tokens=1*" %%a in ("!dk_allButFirstArgs!") do (
		set dk_allButFirstArgs=%%b
	)
	
	:return
	endlocal & (
		set dk_allButFirstArgs=%dk_allButFirstArgs%
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
	
	%dk_call% dk_allButFirstArgs %*
	
	echo ### allButFirstArgs ###
	call :DKTEST_printArgs %dk_allButFirstArgs%
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

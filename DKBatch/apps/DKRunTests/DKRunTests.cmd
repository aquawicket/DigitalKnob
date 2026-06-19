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

if "%~1" neq "" (
	call "%~1" %*
	exit /b 0
)
::#####################################
:MAIN
%setlocal% 
	call :DISABLE dk_callDKBash
	call :DISABLE dk_callDKJava
	call :DISABLE dk_callDKPowershell
	call :DISABLE dk_confirm
	call :DISABLE dk_contains
	call :DISABLE dk_containsCI
	call :DISABLE dk_createFunctionList
	call :DISABLE dk_crlfToLf
	call :DISABLE dk_deleteDigitalKnob
	call :DISABLE dk_dumpStack
	call :DISABLE dk_deleteEmptyDirs
	call :DISABLE dk_evalDKC
	call :DISABLE dk_enterManually
	call :DISABLE dk_evalDKCpp
	call :DISABLE dk_exit
	
	%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR_  %dk_call% dk_DKBRANCH_DIR
	%dk_call% dk_getFiles "%DKBATCH_FUNCTIONS_DIR_%"
	%dk_call% Array/dk_length dk_getFiles
	
	::### Clear log.txt
	echo. > "%~dp0/log.txt"
	
	set "dk_log_ERROR_CALLBACK=call "%~f0" :CALLBACK"
	set "dk_log_FATAL_CALLBACK=call "%~f0" :CALLBACK"
	
	set "READY=1"
	for /l %%x in (0, 1, %dk_length%) do (
		call :RUNTEST "!dk_getFiles[%%x]!"
	)

exit /b 0

::#####################################
:DISABLE
	set "disabled=%disabled%;%~1;"
%endfunction%

::#####################################
:RUNTEST
%setlocal%
	::###### DKTEST MODE ######
	if "#!disabled:;%~n1;=!#" neq "#!disabled!#" (
		echo %yellow% ######### %~nx1 is disabled ######### %clr%
		exit /b 0
	)
	if NOT EXIST "%~1" (exit /b -1)
	%dk_call% dk_fileContains "%~1" ":DKTEST" || exit /b -1
	
	set "CURRENT_TEST_FILE=%~nx1"
	>>"%~dp0/log.txt" (
		echo.
		echo ######### %~nx1 #########
	)
	title TESTING ### %~nx1 ###
	echo.
	echo.%bg_magenta%%white%###### DKTEST MODE ###### %~nx1 ###### DKTEST MODE ######%clr%
	echo.
	call :DKTEST %~1 && (
		>>"%~dp0/log.txt" (echo.        ### passed status:!errorlevel!)
	) || (
		>>"%~dp0/log.txt" (echo.        ### FAILED status:!errorlevel!)
	)
	echo.
	echo.%bg_magenta%%white%######## END TEST ####### %~nx1 ######## END TEST #######%clr%
	echo.
exit /b 0

::#####################################
:DKTEST
::%setlocal%
	if NOT defined READY (goto:MAIN)
	%~1
exit /b !errorlevel!	


:CALLBACK
::%setlocal%
	::echo %red% CALLBACK(%*)
	>>"%~dp0/log.txt" (echo.    %*)
exit /b 0
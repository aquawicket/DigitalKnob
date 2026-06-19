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
rem # dk_isNumber(value)
rem #
rem #		Reference: https://stackoverflow.com/a/17584764
rem #
:dk_isNumber
%setlocal%
	
	:init
	rem ###### Clear and set function variables ######
	set "currentScope=%~n0"
	for /F "delims==" %%a in ('set %~n0 2^>nul') do (
		set "%%a=NULL"
	)
	set %~n0_ARGC=0
	for %%x in (%*) do (
		set /A %~n0_ARGC+=1
		set %~n0_ARGV!%~n0_ARGC!=%%x
	)
	set "%~n0=false"
	if "%~1" equ "" (goto:return)
	rem ##############################################
	

	set "arg1=%~1"
	if defined %~1 (set "arg1=!%~1!")
	
	set "arg1=%arg1:.=%"
	set "arg1=%arg1:+=%"
	set "dk_isNumber=false"
	if %arg1:-=% equ +%arg1:-=% (
		set "dk_isNumber=true"
	)
	echo dk_isNumber = %dk_isNumber%
	
	
	:return
	rem ########################################################
	for /F "tokens=1,2 delims==" %%a in ('set %~n0') do (
		if "%currentScope%" equ "%~n0" endlocal
		if /i "%%b" equ "NULL" (set "%%a=") else (set "%%a=%%b")
	)
	exit /b !%~n0:false=1!
	rem ########################################################
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	set "myNumber=42"
	%dk_call% dk_isNumber myNumber		&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber "myNumber"	&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber %myNumber%	&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber "%myNumber%"	&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber !myNumber!	&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber "!myNumber!"	&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber 69			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber "69"			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber 0				&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber "0"			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber -0			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber "-0"			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber +0			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber "+0"			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber 1				&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber "1"			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber -1			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber "-1"			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber +1			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber "+1"			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber 1.23			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber "1.23"		&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber -1.23			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber "-1.23"		&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber +1.23			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber "+1.23"		&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber 36a			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber "36a"			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber -36a			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber "-36a"		&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber +36a			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber "+36a"		&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber word			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber "word"		&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber -word			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber "-word"		&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber +word			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber "+word"		&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber 123456789		&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber "123456789"	&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber -123456789	&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber "-123456789"	&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber +123456789	&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber "+123456789"	&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber				&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
	%dk_call% dk_isNumber ""			&& (echo !dk_isNumber_ARGV1! is a number) || (call & echo !dk_isNumber_ARGV1! is NOT a number)
%endfunction%

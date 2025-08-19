@echo off
if defined DK.cmd (exit /b %errorlevel%) else (set "DK.cmd=1")

::TODO - switch to UNICODE code page
::chcp 65001 >NUL



::####################################################################
::# DK(<DKSCRIPT_PATH>, <DKSCRIPT_ARGS>)
::#
:DK
::%setlocal%
	call :pushStack %~n0 %*
	(set pushStack=call :pushStack %%~n0%%~0 %%*)

	::if NOT EXIST "%~f1" echo DK.cmd must be called with %%~0 %%*. I.E.  "DK.cmd" %%~0 %%* & pause & exit 1
	
	::### DKSHELL_PATH ###
	if defined ComSpec (set "DKSHELL_PATH=%ComSpec:\=/%")

	::### DKSHELL_NAME ###
	for %%Z in ("%DKSHELL_PATH%") do (set "DKSHELL_NAME=%%~nZ")

	::### DKSHELL_VERSION ###
	for /f "tokens=2 delims=[]" %%v in ('ver') do (set "DKSHELL_VERSION=%%v")
	set "DKSHELL_VERSION=%DKSHELL_VERSION:Version =%"

	::### ESC ###
	set "ESC="

	::### Print DKSHELL_NAME DKSHELL_VERSION ###
	echo %ESC%[42m %ESC%[30m %DKSHELL_NAME% %DKSHELL_VERSION% %ESC%[0m

	::###### PRINT_DE_STATUS #####
	set PRINT_DE_STATUS=if "^!DE^!" equ "" (echo [32mdelayed expansion = ON[0m) else (echo [31mdelayed expansion = OFF[0m)
	%PRINT_DE_STATUS%

	if NOT defined DKBATCH_FUNCTIONS_DIR_	(set "DKBATCH_FUNCTIONS_DIR_=%~dp0")
	if defined DKBATCH_FUNCTIONS_DIR_		(set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR_:\=/%")

	::###### PATH ######
	::set "PATH=%DKBATCH_FUNCTIONS_DIR_%;%PATH%"
	
	::###### _SCOPE ######
	set "setlocal=setlocal EnableDelayedExpansion
	set "NO_STDOUT=1>nul"
	set "NO_STDERR=2>nul"
	set "NO_OUTPUT=1>nul 2>nul"
	set "exit_code=^!errorlevel^!"
	set "endfunction=exit /b ^!errorlevel^!"
	set "return=exit /b ^!errorlevel^!"
	
	call :dk_DKSCRIPT_PATH "%~1"
	call :dk_DKSCRIPT_ARGS "%~1"
	call :dk_DKSCRIPT_FILE
	call :dk_DKSCRIPT_DIR
	call :dk_DKSCRIPT_NAME
	call :dk_DKSCRIPT_EXT
	call :dk_DKCACHE_DIR

	::###### Reload Main Script with cmd ######
	call :dk_reload
	if "!DE!" neq "" (
		echo ERROR: DKBatch requires delayed expansion
		pause
		exit 13
	)

	call :dk_DKHTTP_VARS

	::############ get dk_source and dk_call ######
	call :dk_initFiles
	
	::############### init dk_call ###############
	::call dk_call init
	call %DKBATCH_FUNCTIONS_DIR_%dk_call.cmd init
	
	::############ load dkconfig.txt ############
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	if EXIST "%DKSCRIPT_DIR%/dkconfig.txt" (
		%dk_call% dk_getFileParams "%DKSCRIPT_DIR%/dkconfig.txt"
	) else if EXIST "%DKBRANCH_DIR%/dkconfig.txt" (
		%dk_call% dk_getFileParams "%DKBRANCH_DIR%/dkconfig.txt"
	)
	
	::############ Elevate Permissions ############
	::set "ENABLE_dk_elevate=1"
	if "%ENABLE_dk_elevate%" neq "1" (goto skip_elevate)
		net session >nul 2>&1
		if %errorlevel% equ 0 (goto skip_elevate)
		if "%2" equ "elevated" (set "elevated=1")
		if NOT defined elevated (
			set "elevated=1"
			%dk_call% "%DKBATCH_FUNCTIONS_DIR_%dk_elevate.cmd" %DKSCRIPT_PATH%
		)
	:skip_elevate

	%dk_call% dk_logo

	::%dk_call% dk_validateDK || set "RELOADED=" && call :dk_DKSCRIPT_PATH "%~1" %*
	::%DK% dk_load %DKSCRIPT_PATH%

	::###### DKTEST MODE ######
	if "%DKSCRIPT_EXT%" neq ".cmd" (%endfunction%)
	%dk_call% dk_fileContains "%DKSCRIPT_PATH%" ":DKTEST" || exit /b 1
	echo(
	echo(%bg_magenta%%white%###### DKTEST MODE ###### %DKSCRIPT_FILE% ###### DKTEST MODE ######%clr%
	echo(
	
	call:DKTEST
	echo(
	echo(%bg_magenta%%white%######## END TEST ####### %DKSCRIPT_FILE% ######## END TEST #######%clr%
	echo(
	%dk_call% dk_exit %errorlevel%
%endfunction%





::##################################################################################
::# dk_DKHTTP_VARS
::#
:dk_DKHTTP_VARS
	%pushStack%
	if NOT defined DKHTTP_DIGITALKNOB_DIR		(set "DKHTTP_DIGITALKNOB_DIR=https://raw.githubusercontent.com/aquawicket/DigitalKnob")
	if NOT defined DKHTTP_DKBRANCH_DIR			(set "DKHTTP_DKBRANCH_DIR=%DKHTTP_DIGITALKNOB_DIR%/Development")
	if NOT defined DKHTTP_DKBATCH_DIR			(set "DKHTTP_DKBATCH_DIR=%DKHTTP_DKBRANCH_DIR%/DKBatch")
	if NOT defined DKHTTP_DKBATCH_FUNCTIONS_DIR	(set "DKHTTP_DKBATCH_FUNCTIONS_DIR=%DKHTTP_DKBATCH_DIR%/functions")
%endfunction%

::##################################################################################
::# dk_DKCACHE_DIR
::#
:dk_DKCACHE_DIR
	%pushStack%
	if NOT EXIST "%DKCACHE_DIR%" (set "DKCACHE_DIR=%USERPROFILE:\=/%/.dk")
	if NOT EXIST "%DKCACHE_DIR%" (mkdir "%DKCACHE_DIR:/=\%")
	if EXIST "%DKCACHE_DIR%" (
		if "%DKSCRIPT_NAME%" equ "DKBuilder" (
			copy "%DKSCRIPT_PATH%" "%DKCACHE_DIR%" 1>nul 2>nul
		)
	)
%endfunction%

::##################################################################################
::# dk_DKSCRIPT_EXT
::#
:dk_DKSCRIPT_EXT
	%pushStack%
	if NOT EXIST "%DKSCRIPT_PATH%"	(echo DKSCRIPT_PATH:%DKSCRIPT_PATH% NOT found & pause & exit -1)
	if NOT defined DKSCRIPT_EXT		(for %%Z in ("%DKSCRIPT_PATH%") do set "DKSCRIPT_EXT=%%~xZ")
	if NOT defined DKSCRIPT_EXT		(echo DKSCRIPT_EXT:%DKSCRIPT_EXT% NOT defined & pause & exit -1)
%endfunction%

::##################################################################################
::# dk_DKSCRIPT_NAME
::#
:dk_DKSCRIPT_NAME
	%pushStack%
	if NOT EXIST "%DKSCRIPT_PATH%"	(echo DKSCRIPT_PATH:%DKSCRIPT_PATH% NOT found & pause & exit -1)
	if NOT defined DKSCRIPT_NAME	(for %%Z in ("%DKSCRIPT_PATH%") do set "DKSCRIPT_NAME=%%~nZ")
	if NOT defined DKSCRIPT_NAME	(echo DKSCRIPT_NAME:%DKSCRIPT_NAME% NOT defined & pause & exit -1)
%endfunction%

::##################################################################################
::# dk_DKSCRIPT_DIR
::#
:dk_DKSCRIPT_DIR
	%pushStack%
	if NOT EXIST "%DKSCRIPT_PATH%"	(echo DKSCRIPT_PATH:%DKSCRIPT_PATH% NOT found & pause & exit -1)
	if NOT EXIST "%DKSCRIPT_DIR%"	(for %%Z in ("%DKSCRIPT_PATH%") do set "DKSCRIPT_DIR=%%~dpZ")
	if EXIST 	 "%DKSCRIPT_DIR%"	(set "DKSCRIPT_DIR=%DKSCRIPT_DIR:\=/%")
	if "%DKSCRIPT_DIR:~-1%" equ "/"	(set "DKSCRIPT_DIR=%DKSCRIPT_DIR:~0,-1%")
	if NOT EXIST "%DKSCRIPT_DIR%"	(echo DKSCRIPT_DIR:%DKSCRIPT_DIR% NOT found & pause & exit -1)
%endfunction%

::##################################################################################
::# dk_echo
::#
:dk_echo
	%pushStack%
	echo %~1
%endfunction%

::##################################################################################
::# dk_DKSCRIPT_FILE
::#
:dk_DKSCRIPT_FILE
	%push%
	if NOT EXIST "%DKSCRIPT_PATH%"	(echo DKSCRIPT_PATH:%DKSCRIPT_PATH% NOT found & pause & exit -1)
	if NOT defined DKSCRIPT_FILE	(for %%Z in ("%DKSCRIPT_PATH%") do set "DKSCRIPT_FILE=%%~nxZ")
	if NOT defined DKSCRIPT_FILE	(echo DKSCRIPT_FILE:%DKSCRIPT_FILE% NOT defined & pause & exit -1)
%endfunction%

::##################################################################################
::# dk_DKSCRIPT_ARGS
::#
:dk_DKSCRIPT_ARGS
	%pushStack%
	if NOT defined DKSCRIPT_ARGS	(set DKSCRIPT_ARGS=%*)
	if defined DKSCRIPT_ARGS		(call set "DKSCRIPT_ARGS=%%DKSCRIPT_ARGS:*%~1 =%%")
%endfunction%

::##################################################################################
::# dk_DKSCRIPT_PATH
::#
:dk_DKSCRIPT_PATH
	%pushStack%
	if NOT defined DKSCRIPT_PATH	(set "DKSCRIPT_PATH=%~1")
	if defined DKSCRIPT_PATH		(set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%")
::	if defined DKSCRIPT_PATH		(call :readlink %DKSCRIPT_PATH% DKSCRIPT_PATH)
	if NOT EXIST "%DKSCRIPT_PATH%"	(echo DKSCRIPT_PATH:%DKSCRIPT_PATH% does NOT EXIST & pause & exit -1)
%endfunction%

::##################################################################################
::# dk_initFiles
::#
:dk_initFiles
	%pushStack%
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%dk_download.cmd"			"%CURL_EXE%" -LSs "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_download.cmd" 			-o "%DKBATCH_FUNCTIONS_DIR_%dk_download.cmd"
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%dk_source.cmd"			"%CURL_EXE%" -LSs "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_source.cmd" 			-o "%DKBATCH_FUNCTIONS_DIR_%dk_source.cmd"
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%dk_call.cmd"				"%CURL_EXE%" -LSs "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_call.cmd" 				-o "%DKBATCH_FUNCTIONS_DIR_%dk_call.cmd"
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%dk_return.cmd"			"%CURL_EXE%" -LSs "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_return.cmd" 			-o "%DKBATCH_FUNCTIONS_DIR_%dk_return.cmd"
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%dk_printLastError.cmd"	"%CURL_EXE%" -LSs "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_printLastError.cmd" 	-o "%DKBATCH_FUNCTIONS_DIR_%dk_printLastError.cmd"
%endfunction%

::##################################################################################
::# dk_reload
::#
:dk_reload
	%pushStack%
	if "%DKSCRIPT_EXT%" neq ".cmd" (exit /b -1)
	if defined RELOADED (exit /b -1)

	echo "reloading with /v:on 'delayed expansion',  /k 'keep terminal open' . . . ."
	set "LVL="
	set "ENTRY="
	set "RELOADED=1"
	set "DK.cmd="

	cls
	"%ComSpec%" /V:ON /K "%DKSCRIPT_PATH%" 	&::| %DKBATCH_FUNCTIONS_DIR_%dk_tee.cmd %DKSCRIPT_NAME%.log	

	:: Change console settings
	:: >nul REG ADD HKCU/Console/DigitalKnob FontSize /t reg_sz /d "Consolas" /f
	:: start "DigitalKnob" "%ComSpec%" /V:ON /K "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%
	:: exit

	::####################################
	::############ EXIT POINT ############
	::####################################
	set "exit_code=%errorlevel%"
	echo(
	echo exit_code = %exit_code%
	if "%exit_code%" neq "0" (
		echo(
		echo Press any key to exit . . .
		pause >nul
	)
	exit %exit_code%
	::( >NUL reg delete HKCU/Console/DigitalKnob /f )
%endfunction%

::##################################################################################
::# dk_readlink
::#
:dk_readlink
	%pushStack%
%setlocal%
	%dk_call% dk_debugFunc 1 2
   
    set dk_readlink=%1
	::if NOT EXIST "%dk_readlink%" (%return%)
	
    set dk_readlink=%dk_readlink:"=%
	set dk_readlink=%dk_readlink:/=\%
    if "%dk_readlink:~-1%" equ "\" set dk_readlink=%dk_readlink:~0,-1%

	for /f "tokens=2 delims=[]" %%i in ('dir %dk_readlink%* ^| FIND "<SYMLINK"') do (set "dk_readlink=%%i")
	
	endlocal & (
		set "dk_readlink=%dk_readlink:\=/%"
		if "%~2" neq "" (set "%~2=%dk_readlink:\=/%")
	)
%endfunction%



::####################################################################
::# :setGlobal(name value)
::#
:setGlobal
setlocal enableDelayedExpansion
	set dk_allButFirstArgs=%*
	for /f "tokens=1*" %%a in ("!dk_allButFirstArgs!") do endlocal & (set %1=%%b)
	:: (set dk.gbl.%~1=%argv%)		&:: prefix the variable name with dk.gbl. and assign a value
exit /b !errorlevel!

::####################################################################
::# :pushStack()
::#
:pushStack
	if NOT defined LVL (set /a "LVL=0")
	if NOT defined LVL (set /a "ENTRY=0")
	(set /a LVL+=1)
	(set /a ENTRY+=1)
	call :setGlobal __STACK__%ENTRY% %*
exit /b !errorlevel!


::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%pushStack%
	%dk_call% dk_debugFunc 0

	%DKSCRIPT_PATH:/=\%
%endfunction%

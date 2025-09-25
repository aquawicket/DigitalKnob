@echo off



::if NOT EXIST "%~f1" echo ERROR: DK.cmd must be called with %%~0 %%*. I.E.  "DK.cmd" %%~0 %%* & pause & exit /b 1
if NOT defined argv (set argv=%*)
if NOT defined argv (set argv=%~f0)

::if NOT defined RELOADED (
if "!DE!" neq "" (
	echo "reloading with delayed expansion"
	set "RELOADED=1"
	set "DK.cmd="
	cls
	"%ComSpec%" /A /Q /D /E:ON /V:ON /C %argv%		&rem | %DKBATCH_FUNCTIONS_DIR_%dk_tee.cmd %DKSCRIPT_NAME%.log
	exit /b %errorlevel%
	echo ### ERROR: SHOULD NOT GET HERE ### & pause
)

if not defined DK.cmd (set "DK.cmd=1") else (exit /b %errorlevel%)

if "!DE!" neq "" (
	echo ### ERROR: DKBatch requires delayed expansion ### & pause
	exit /b %errorlevel%
	echo ### ERROR: SHOULD NOT GET HERE ### & pause
)



rem ###### delayed expansion OFF ######
if "!DE!" neq "" (
	title delayedExpansion OFF
	if NOT defined exit (
		set exit=^
		call set err_level=%%errorlevel%% ^& ^
		call set prev_error=%%error_code%% ^& ^
		call set error_code=%%err_level%% ^& ^
		call set last_error=%%err_level%% ^& ^
		call set file=%%~nx0 ^& ^
		call set function=%%~0 ^& ^
		call set args=%%* ^& ^
		call echo EXIT %%file%% %%function%%^(%%args%%^) ^& ^
		call echo error_code = %%error_code%% ^& ^
		call echo prev_error = %%prev_error%% ^& ^
		call echo last_error = %%last_error%% ^& ^
		echo. ^& ^
		call exit /b %%error_code%%)
	if not defined endfunction 	(call set "endfunction=%%exit%%")
	if not defined setlocal		(set setlocal=setlocal)
	
rem ###### delayed expansion ON ######
) else (
	title delayedExpansion ON
	if NOT defined exit (
		set exit=^
		set err_level=^^!errorlevel^^! ^&^
		set prev_error=^^!error_code^^! ^&^
		set error_code=^^!err_level^^! ^&^
		^(if "^!err_level^!" neq "0 " set last_error=^^!err_level^^!^) ^&^
		call set file=%%~nx0 ^&^
		call set function=%%~0 ^&^
		call set args=%%* ^&^
		echo EXIT ^^!file^^! ^^!function^^!^(^^!args^^!^) ^&^
		echo error_code = ^^!error_code^^! ^&^
		echo prev_error = ^^!prev_error^^! ^&^
		echo last_error = ^^!last_error^^! ^&^
		echo. ^&^
		exit /b ^^!error_code^^!)
	if not defined endfunction 	(set endfunction=!exit!)
	if not defined setlocal		(set setlocal=setlocal EnableDelayedExpansion)
)
if not defined return		(set return=call :return)
if not defined clearerror	(set clearerror=cmd /c exit /b 0)
if not defined pushStack	(set pushStack=call :pushStack %%~n0%%~0 %%*)
if NOT defined NO_STDOUT 	(set NO_STDOUT=1>nul)
if NOT defined NO_STDERR 	(set NO_STDERR=2>nul)
if NOT defined NO_OUTPUT 	(set NO_OUTPUT=1>nul 2>nul)
if not defined true 		(set true=0)
if not defined false 		(set false=1)

call :DK %argv%
%return%
echo ### ERROR: SHOULD NOT GET HERE ### ^& pause

::################
:return exit_code
	if "%~1" neq "" (set return_code=%~1) else (set return_code=%errorlevel%)
	%ComSpec% /c exit /b %return_code%
	echo :return(%return_code%)
	pause
	exit /b %return_code%
%endfunction%

::##################################################################################
::# dk_reload
::#
:dk_reload
	%pushStack%
	
	if defined RELOADED (%return% 92)
	if NOT defined DKSCRIPT_PATH	(set "DKSCRIPT_PATH=%~1")
	if NOT defined DKSCRIPT_EXT		(for %%Z in (%DKSCRIPT_PATH%) do set "DKSCRIPT_EXT=%%~xZ")
	
	if "%DKSCRIPT_EXT%" neq ".cmd" 	(%return% 96)

	echo "reloading with delayed expansion"
	set "RELOADED=1"
	set "DK.cmd="
	set "LVL="
	set "ENTRY="

	cls
	"%ComSpec%" /A /Q /D /E:ON /V:ON /C "%DKSCRIPT_PATH%"		&::| %DKBATCH_FUNCTIONS_DIR_%dk_tee.cmd %DKSCRIPT_NAME%.log
	%return% 106

	:: Change console settings
	:: >nul REG ADD HKCU/Console/DigitalKnob FontSize /t reg_sz /d "Consolas" /f
	:: start "DigitalKnob" "%ComSpec%" /V:ON /K "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%
	:: %return% 111
	::( >NUL reg delete HKCU/Console/DigitalKnob /f )
%endfunction%

::####################################################################
::# :pushStack()
::#
:pushStack
	if NOT defined LVL (set /a "LVL=0")
	if NOT defined ENTRY (set /a "ENTRY=0")
	(set /a LVL+=1)
	(set /a ENTRY+=1)
	call :setGlobal __STACK__%ENTRY% %*
%endfunction%

::####################################################################
::# DK(<DKSCRIPT_PATH>, <DKSCRIPT_ARGS>)
::#
::#	  TODO - switch to UNICODE code page
::#   chcp 65001 >NUL
::#
:DK
	%pushStack%

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
	
	
	call :dk_DKSCRIPT_PATH "%~1"
	call :dk_DKSCRIPT_ARGS "%~1"
	call :dk_DKSCRIPT_FILE
	call :dk_DKSCRIPT_DIR
	call :dk_DKSCRIPT_NAME
	call :dk_DKSCRIPT_EXT
	call :dk_DKCACHE_DIR

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
	
	if "%DKOFFLINE%" equ "1" (
		%dk_call% dk_echo "%bg_yellow%%black%###### OFFLINE MODE ###### OFFLINE MODE ###### OFFLINE MODE ######%clr%"
	)
	
	::############ Elevate Permissions ############
	::set "ENABLE_dk_elevate=1"
	if "%ENABLE_dk_elevate%" neq "1" (goto skip_elevate)
		net session >nul 2>&1
		if %errorlevel% equ 0 (goto skip_elevate)
		if /i "%2" equ "elevated" (set "elevated=1")
		if NOT defined elevated (
			set "elevated=1"
			%dk_call% "%DKBATCH_FUNCTIONS_DIR_%dk_elevate.cmd" %DKSCRIPT_PATH%
		)
	:skip_elevate

	%dk_call% dk_logo

	::%dk_call% dk_validateDK || set "RELOADED=" && call :dk_DKSCRIPT_PATH "%~1" %*
	::%DK% dk_load %DKSCRIPT_PATH%

	::###### DKTEST MODE ######
	if "%DKSCRIPT_EXT%" neq ".cmd" (%return%)
	%dk_call% dk_fileContains "%DKSCRIPT_PATH%" ":DKTEST" || (cmd /c exit /b 0 & %return%)
	echo(
	echo(%bg_magenta%%white%###### DKTEST MODE ###### %DKSCRIPT_FILE% ###### DKTEST MODE ######%clr%
	echo(
	call:DKTEST
	echo(
	echo(%bg_magenta%%white%######## END TEST ####### %DKSCRIPT_FILE% ######## END TEST #######%clr%
	echo(
	
	pause
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
	if NOT EXIST "%DKSCRIPT_PATH%"	(echo DKSCRIPT_PATH:%DKSCRIPT_PATH% NOT found & pause & %return% 261)
	if NOT defined DKSCRIPT_EXT		(for %%Z in (%DKSCRIPT_PATH%) do set "DKSCRIPT_EXT=%%~xZ")
	if NOT defined DKSCRIPT_EXT		(echo DKSCRIPT_EXT:%DKSCRIPT_EXT% NOT defined & pause & %return% 263)
%endfunction%

::##################################################################################
::# dk_DKSCRIPT_FILE
::#
:dk_DKSCRIPT_FILE
	%push%
	if NOT EXIST "%DKSCRIPT_PATH%"	(echo DKSCRIPT_PATH:%DKSCRIPT_PATH% NOT found & pause & %return% 271)
	if NOT defined DKSCRIPT_FILE	(for %%Z in (%DKSCRIPT_PATH%) do set "DKSCRIPT_FILE=%%~nxZ")
	if NOT defined DKSCRIPT_FILE	(echo DKSCRIPT_FILE:%DKSCRIPT_FILE% NOT defined & pause & %return% 273)
%endfunction%

::##################################################################################
::# dk_DKSCRIPT_NAME
::#
:dk_DKSCRIPT_NAME
	%pushStack%
	if NOT EXIST "%DKSCRIPT_PATH%"	(echo DKSCRIPT_PATH:%DKSCRIPT_PATH% NOT found & pause & %return% 281)
	if NOT defined DKSCRIPT_NAME	(for %%Z in (%DKSCRIPT_PATH%) do set "DKSCRIPT_NAME=%%~nZ")
	if NOT defined DKSCRIPT_NAME	(echo DKSCRIPT_NAME:%DKSCRIPT_NAME% NOT defined & pause & %return% 283)
%endfunction%

::##################################################################################
::# dk_DKSCRIPT_DIR
::#
:dk_DKSCRIPT_DIR
	%pushStack%
	if NOT EXIST "%DKSCRIPT_PATH%"	(echo DKSCRIPT_PATH:%DKSCRIPT_PATH% NOT found & pause & %return% 291)
	if NOT EXIST "%DKSCRIPT_DIR%"	(for %%Z in (%DKSCRIPT_PATH%) do set "DKSCRIPT_DIR=%%~dpZ")
	if EXIST 	 "%DKSCRIPT_DIR%"	(set "DKSCRIPT_DIR=%DKSCRIPT_DIR:\=/%")
	if "%DKSCRIPT_DIR:~-1%" equ "/"	(set "DKSCRIPT_DIR=%DKSCRIPT_DIR:~0,-1%")
	if NOT EXIST "%DKSCRIPT_DIR%"	(echo DKSCRIPT_DIR:%DKSCRIPT_DIR% NOT found & pause & %return% 295)
%endfunction%

::##################################################################################
::# dk_echo
::#
:dk_echo
	%pushStack%
	echo %~1
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
	if NOT EXIST "%DKSCRIPT_PATH%"	(echo DKSCRIPT_PATH:%DKSCRIPT_PATH% does NOT EXIST & pause & %return% 323)
%endfunction%

::##################################################################################
::# dk_initFiles
::#
:dk_initFiles
	%pushStack%
	if NOT defined DKSTORAGE_DIR			(set "DKSTORAGE_DIR=%SystemDrive%/DKStorage")
	if NOT defined DKARCHIVE 				(set "DKARCHIVE=%DKSTORAGE_DIR%/%DIGITALKNOB%.tar.gz")
	if NOT defined DKBRANCH_DIR				(set "DKBRANCH_DIR=%USERPROFILE:\=/%/DigitalKnob/Development")
	if EXIST "%DKARCHIVE%" (
		if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%dk_download.cmd" 			(tar -zxvf %DKARCHIVE% -C %DKBRANCH_DIR% DKBatch/functions/dk_download.cmd)
		if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%dk_source.cmd" 			(tar -zxvf %DKARCHIVE% -C %DKBRANCH_DIR% DKBatch/functions/dk_source.cmd)
		if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%dk_call.cmd" 				(tar -zxvf %DKARCHIVE% -C %DKBRANCH_DIR% DKBatch/functions/dk_call.cmd)
		if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%dk_return.cmd" 			(tar -zxvf %DKARCHIVE% -C %DKBRANCH_DIR% DKBatch/functions/dk_return.cmd)
		if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%dk_printLastError.cmd" 	(tar -zxvf %DKARCHIVE% -C %DKBRANCH_DIR% DKBatch/functions/dk_printLastError.cmd)
	) else (
		set "curl_exe=%windir%\System32\curl.exe"
		if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%dk_download.cmd"			"%curl_exe%" -LSs "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_download.cmd" 			-o "%DKBATCH_FUNCTIONS_DIR_%dk_download.cmd"
		if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%dk_source.cmd"			"%curl_exe%" -LSs "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_source.cmd" 			-o "%DKBATCH_FUNCTIONS_DIR_%dk_source.cmd"
		if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%dk_call.cmd"				"%curl_exe%" -LSs "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_call.cmd" 				-o "%DKBATCH_FUNCTIONS_DIR_%dk_call.cmd"
		if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%dk_return.cmd"			"%curl_exe%" -LSs "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_return.cmd" 			-o "%DKBATCH_FUNCTIONS_DIR_%dk_return.cmd"
		if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%dk_printLastError.cmd"	"%curl_exe%" -LSs "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_printLastError.cmd" 	-o "%DKBATCH_FUNCTIONS_DIR_%dk_printLastError.cmd"
	)
%endfunction%



::##################################################################################
::# dk_readlink
::#
:dk_readlink
	%pushStack%
%setlocal%
	%dk_call% dk_debugFunc 1 2
   
    set dk_readlink=%1
	::if NOT EXIST "%dk_readlink%" (%return% 361)
	
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
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%pushStack%
	%dk_call% dk_debugFunc 0

	if "%DKSCRIPT_NAME%" equ "DK" (
		echo cannot call DK.cmd from itself
		%return%
	)
	
	%DKSCRIPT_PATH:/=\%
%endfunction%

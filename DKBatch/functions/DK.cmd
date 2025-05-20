@echo off
if defined DK.cmd (exit /b %errorlevel%) else (set "DK.cmd=1")

::TODO - switch to UNICODE code page
::chcp 65001 >NUL

::####################################################################
::# DK(<DKSCRIPT_PATH>, <DKSCRIPT_ARGS>)
::#
:DK
::%setlocal%
	::if not exist "%~f1" echo DK.cmd must be called with %%~0 %%*. I.E.  "DK.cmd" %%~0 %%* & pause & exit 1

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

	if not defined DKBATCH_FUNCTIONS_DIR_	(set "DKBATCH_FUNCTIONS_DIR_=%~dp0")
	if defined DKBATCH_FUNCTIONS_DIR_		(set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR_:\=/%")

	::###### PATH ######
	set "PATH=%DKBATCH_FUNCTIONS_DIR_%;%PATH%"
	
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
	call %DKBATCH_FUNCTIONS_DIR_:/=\%dk_call.cmd init
	
	::############ load dkconfig.txt ############
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	if exist "%DKSCRIPT_DIR%/dkconfig.txt" (
		%dk_call% dk_getFileParams "%DKSCRIPT_DIR%/dkconfig.txt"
	) else if exist "%DKBRANCH_DIR%/dkconfig.txt" (
		%dk_call% dk_getFileParams "%DKBRANCH_DIR%/dkconfig.txt"
	)
	
	::############ Elevate Permissions ############
	::set "ENABLE_dk_elevate=1"
	if "%ENABLE_dk_elevate%" neq "1" (goto skip_elevate)
		net session >nul 2>&1
		if %ERRORLEVEL% equ 0 (goto skip_elevate)
		if "%2" equ "elevated" (set "elevated=1")
		if not defined elevated (
			set "elevated=1"
			call "%DKBATCH_FUNCTIONS_DIR_%dk_elevate.cmd" %DKSCRIPT_PATH%
		)
	:skip_elevate

	::############ LOAD FUNCTION FILES ############
	::%dk_call% dk_source dk_debugFunc
	%dk_call% dk_color
	%dk_call% dk_logo

	::%dk_call% dk_validateDK || set "RELOADED=" && call :dk_DKSCRIPT_PATH "%~1" %*
	::%DK% dk_load %DKSCRIPT_PATH%

	::###### DKTEST MODE ######
	if "%DKSCRIPT_EXT%" neq ".cmd" (%return%)
	%dk_call% dk_fileContains "%DKSCRIPT_PATH%" ":DKTEST" || exit /b 0
	%dk_call% dk_echo
	%dk_call% dk_echo "%bg_magenta%%white%###### DKTEST MODE ###### %DKSCRIPT_FILE% ###### DKTEST MODE ######%clr%"
	%dk_call% dk_echo
	call :DKTEST || %return%
	%dk_call% dk_echo
	%dk_call% dk_echo "%bg_magenta%%white%######## END TEST ####### %DKSCRIPT_FILE% ######## END TEST #######%clr%"
	%dk_call% dk_echo
	%dk_call% dk_exit %errorlevel%
%endfunction%



::##################################################################################
::# dk_DKHTTP_VARS
::#
:dk_DKHTTP_VARS
	if not defined DKHTTP_DIGITALKNOB_DIR		(set "DKHTTP_DIGITALKNOB_DIR=https://raw.githubusercontent.com/aquawicket/DigitalKnob")
	if not defined DKHTTP_DKBRANCH_DIR			(set "DKHTTP_DKBRANCH_DIR=%DKHTTP_DIGITALKNOB_DIR%/Development")
	if not defined DKHTTP_DKBATCH_DIR			(set "DKHTTP_DKBATCH_DIR=%DKHTTP_DKBRANCH_DIR%/DKBatch")
	if not defined DKHTTP_DKBATCH_FUNCTIONS_DIR	(set "DKHTTP_DKBATCH_FUNCTIONS_DIR=%DKHTTP_DKBATCH_DIR%/functions")
%endfunction%

::##################################################################################
::# dk_DKCACHE_DIR
::#
:dk_DKCACHE_DIR
	if not exist "%DKCACHE_DIR%" (set "DKCACHE_DIR=%USERPROFILE:\=/%/.dk")
	if not exist "%DKCACHE_DIR%" (mkdir "%DKCACHE_DIR:/=\%")
	if exist "%DKCACHE_DIR%" (
		if "%DKSCRIPT_NAME%" equ "DKBuilder" (
			copy "%DKSCRIPT_PATH%" "%DKCACHE_DIR%" 1>nul 2>nul
		)
	)
%endfunction%

::##################################################################################
::# dk_DKSCRIPT_EXT
::#
:dk_DKSCRIPT_EXT
	if not exist "%DKSCRIPT_PATH%"	(echo DKSCRIPT_PATH:%DKSCRIPT_PATH% not found & pause & exit -1)
	if not defined DKSCRIPT_EXT		(for %%Z in ("%DKSCRIPT_PATH%") do set "DKSCRIPT_EXT=%%~xZ")
	if not defined DKSCRIPT_EXT		(echo DKSCRIPT_EXT:%DKSCRIPT_EXT% not defined & pause & exit -1)
%endfunction%

::##################################################################################
::# dk_DKSCRIPT_NAME
::#
:dk_DKSCRIPT_NAME
	if not exist "%DKSCRIPT_PATH%"	(echo DKSCRIPT_PATH:%DKSCRIPT_PATH% not found & pause & exit -1)
	if not defined DKSCRIPT_NAME	(for %%Z in ("%DKSCRIPT_PATH%") do set "DKSCRIPT_NAME=%%~nZ")
	if not defined DKSCRIPT_NAME	(echo DKSCRIPT_NAME:%DKSCRIPT_NAME% not defined & pause & exit -1)
%endfunction%

::##################################################################################
::# dk_DKSCRIPT_DIR
::#
:dk_DKSCRIPT_DIR
	if not exist "%DKSCRIPT_PATH%"	(echo DKSCRIPT_PATH:%DKSCRIPT_PATH% not found & pause & exit -1)
	if not exist "%DKSCRIPT_DIR%"	(for %%Z in ("%DKSCRIPT_PATH%") do set "DKSCRIPT_DIR=%%~dpZ")
	if exist 	 "%DKSCRIPT_DIR%"	(set "DKSCRIPT_DIR=%DKSCRIPT_DIR:\=/%")
	if "%DKSCRIPT_DIR:~-1%" equ "/"	(set "DKSCRIPT_DIR=%DKSCRIPT_DIR:~0,-1%")
	if not exist "%DKSCRIPT_DIR%"	(echo DKSCRIPT_DIR:%DKSCRIPT_DIR% not found & pause & exit -1)
	
	cd "%DKSCRIPT_DIR%"
%endfunction%

::##################################################################################
::# dk_echo
::#
:dk_echo
	echo %~1
%endfunction%

::##################################################################################
::# dk_DKSCRIPT_FILE
::#
:dk_DKSCRIPT_FILE
	if not exist "%DKSCRIPT_PATH%"	(echo DKSCRIPT_PATH:%DKSCRIPT_PATH% not found & pause & exit -1)
	if not defined DKSCRIPT_FILE	(for %%Z in ("%DKSCRIPT_PATH%") do set "DKSCRIPT_FILE=%%~nxZ")
	if not defined DKSCRIPT_FILE	(echo DKSCRIPT_FILE:%DKSCRIPT_FILE% not defined & pause & exit -1)
%endfunction%

::##################################################################################
::# dk_DKSCRIPT_ARGS
::#
:dk_DKSCRIPT_ARGS
	if not defined DKSCRIPT_ARGS	(set DKSCRIPT_ARGS=%*)
	if defined DKSCRIPT_ARGS		(call set "DKSCRIPT_ARGS=%%DKSCRIPT_ARGS:*%~1 =%%")
%endfunction%

::##################################################################################
::# dk_DKSCRIPT_PATH
::#
:dk_DKSCRIPT_PATH
	if not defined DKSCRIPT_PATH	(set "DKSCRIPT_PATH=%~1")
	if defined DKSCRIPT_PATH		(set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%")
::	if defined DKSCRIPT_PATH		(call :readlink %DKSCRIPT_PATH% DKSCRIPT_PATH)
	if not exist "%DKSCRIPT_PATH%"	(echo DKSCRIPT_PATH:%DKSCRIPT_PATH% does not exist & exit /b -1)
	
	echo DKSCRIPT_PATH = %DKSCRIPT_PATH%
%endfunction%

::##################################################################################
::# dk_initFiles
::#
:dk_initFiles
	if not exist "%DKBATCH_FUNCTIONS_DIR_%dk_source.cmd"			powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_source.cmd', '%DKBATCH_FUNCTIONS_DIR_%dk_source.cmd')"
	if not exist "%DKBATCH_FUNCTIONS_DIR_%dk_call.cmd"				powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_call.cmd', '%DKBATCH_FUNCTIONS_DIR_%dk_call.cmd')"
	if not exist "%DKBATCH_FUNCTIONS_DIR_%dk_return.cmd"			powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_return.cmd', '%DKBATCH_FUNCTIONS_DIR_%dk_return.cmd')"
	if not exist "%DKBATCH_FUNCTIONS_DIR_%dk_printLastError.cmd"	powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_printLastError.cmd', '%DKBATCH_FUNCTIONS_DIR_%dk_printLastError.cmd')"
%endfunction%

::##################################################################################
::# dk_reload
::#
:dk_reload
	if "%DKSCRIPT_EXT%" neq ".cmd" (exit /b -1)
	if defined RELOADED (exit /b -1)

	echo "reloading with /v:on 'delayed expansion',  /k 'keep terminal open' . . . ."
	set "RELOADED=1"
	set "DK.cmd="

	cls
	"%ComSpec%" /V:ON /K "%DKSCRIPT_PATH%" 	&::| %DKBATCH_FUNCTIONS_DIR_%dk_tee.cmd %DKSCRIPT_NAME%.log	

	:: Change console settings
	:: >nul REG ADD HKCU/Console/digitalknob FontSize /t reg_sz /d "Consolas" /f
	:: start "digitalknob" "%ComSpec%" /V:ON /K "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%
	:: exit

	::####################################
	::############ EXIT POINT ############
	::####################################
	set "exit_code=%errorlevel%"
	echo:
	echo exit_code = %exit_code%
	if "%exit_code%" neq "0" (
		echo:
		echo Press any key to exit . . .
		pause >nul
	)
	exit %exit_code%

	::( >NUL reg delete HKCU/Console/digitalknob /f )
%endfunction%

::##################################################################################
::# dk_readlink
::#
:dk_readlink
%setlocal%
	%dk_call% dk_debugFunc 1 2
    
    set dk_readlink=%1
	::if not exist "%dk_readlink%" (%return%)
	
    set dk_readlink=%dk_readlink:"=%
	set dk_readlink=%dk_readlink:/=\%
    if "%dk_readlink:~-1%" equ "\" set dk_readlink=%dk_readlink:~0,-1%

	for /f "tokens=2 delims=[]" %%i in ('dir %dk_readlink%* ^| FIND "<SYMLINK"') do (set "dk_readlink=%%i")
	
	endlocal & (
		set "dk_readlink=%dk_readlink:\=/%"
		if "%~2" neq "" (set "%~2=%dk_readlink:\=/%")
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
%dk_call% dk_debugFunc 0

	%DKSCRIPT_PATH:/=\%
%endfunction%

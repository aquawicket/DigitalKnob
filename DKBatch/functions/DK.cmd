@echo off
if defined DK_CMD (goto:eof) else (set "DK_CMD=1")

::###### Print Version Info ######
echo:
for %%Z in ("%COMSPEC%") do (set "DKSHELL=%%~nZ")
for /f "tokens=2 delims=[]" %%v in ('ver') do (set "DKSHELL_VERSION=%%v")
if defined COMSPEC (set "DKSHELL_PATH=%COMSPEC:\=/%")
set "ESC="                         &:: escape character
echo %ESC%[42m %ESC%[30m %DKSHELL% %DKSHELL_VERSION% %ESC%[0m
echo DKSHELL_PATH = %DKSHELL_PATH%
if defined DKSCRIPT_PATH (set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%")
echo DKSCRIPT_PATH = %DKSCRIPT_PATH%
echo:
set "DKBATCH_FUNCTIONS_DIR_=%~dp0"
set "PATH=%DKBATCH_FUNCTIONS_DIR_%;%PATH%"
set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR_:\=/%"

::if not exist "%~0.cmd" echo DK.cmd must be called with %%~0 %%*. I.E.  "DK.cmd" %%~0 %%* & pause & exit 1

(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)

(set LF=^
%= This creates a Line Feed - DO NOT ALTER =%
)

::####################################################################
::# DK
::#
:DK
	if "!DE!" == "" (echo delayed expansion = ON) else (echo delayed expansion = OFF)
    set "NO_STDOUT=1>nul"
    set "NO_STDERR=2>nul"
    set "NO_OUTPUT=1>nul 2>nul"
	
	set "endfunction=exit /b !errorlevel!"
    set "return=exit /b !errorlevel!"

    call :dk_DKSCRIPT_PATH "%~1" %*
	call :dk_DKSCRIPT_FILE
    call :dk_DKSCRIPT_DIR
	call :dk_DKSCRIPT_NAME
    call :dk_DKSCRIPT_EXT
	call :dk_DKCACHE_DIR

    ::###### Reload Main Script with cmd ######
    ::if "!DE!" neq "" 
	call :dk_reload 
    if "!DE!" neq "" (
		echo ERROR: DKBatch requires delayed expansion
		pause
		exit 13
	)

    ::call :dk_DKBATCH_VARS
    call :dk_DKHTTP_VARS

    ::############ get dk_source and dk_call ######
    call :dk_initFiles
	
	call %DKBATCH_FUNCTIONS_DIR_%dk_call.cmd init
	
    ::############ Elevate Permissions ############
    ::set "ENABLE_dk_elevate=1"
    if "%ENABLE_dk_elevate%" neq "1" (goto skip_elevate)
        net session >nul 2>&1
        if %ERRORLEVEL% equ 0 (goto skip_elevate)
        if "%2"=="elevated" (set "elevated=1")
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
    pause
    exit %ERRORLEVEL%
%endfunction%


::##################################################################################
::# dk_echo
::#
:dk_echo
    echo %~1
%endfunction%

::##################################################################################
::# dk_DKSCRIPT_PATH
::#
:dk_DKSCRIPT_PATH
    ::if not exist   "%~1"				(echo :dk_DKSCRIPT_PATH must be called with %%~0 %%*. I.E.  "call :dk_DKSCRIPT_PATH" %%~0 %%* & pause & exit 1)
    if not defined  DKSCRIPT_PATH		(set "DKSCRIPT_PATH=%~1")
	if defined  	DKSCRIPT_PATH		(set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%")
    if not exist   "%DKSCRIPT_PATH%"	(echo DKSCRIPT_PATH:%DKSCRIPT_PATH% does not exist && exit /b 13)
	if not defined  DKSCRIPT_ARGS		(set DKSCRIPT_ARGS=%*)
	if defined 		DKSCRIPT_ARGS 		(set DKSCRIPT_ARGS=!DKSCRIPT_ARGS:*%1=!)
%endfunction%

::##################################################################################
::# dk_DKSCRIPT_FILE
::#
:dk_DKSCRIPT_FILE
    if not exist "%DKSCRIPT_PATH%"	(echo DKSCRIPT_PATH:%DKSCRIPT_PATH% not found & pause & exit 1)
    if not defined DKSCRIPT_FILE	(for %%Z in ("%DKSCRIPT_PATH%") do set "DKSCRIPT_FILE=%%~nxZ")
    if not defined DKSCRIPT_FILE	(echo DKSCRIPT_FILE:%DKSCRIPT_FILE% not defined & pause & exit 1)
%endfunction%

::##################################################################################
::# dk_DKSCRIPT_DIR
::#
:dk_DKSCRIPT_DIR
    if not exist "%DKSCRIPT_PATH%"	(echo DKSCRIPT_PATH:%DKSCRIPT_PATH% not found & pause & exit 1)
    if not exist "%DKSCRIPT_DIR%"	(for %%Z in ("%DKSCRIPT_PATH%") do set "DKSCRIPT_DIR=%%~dpZ")
	if exist 	 "%DKSCRIPT_DIR%"	(set "DKSCRIPT_DIR=%DKSCRIPT_DIR:\=/%")
	if "%DKSCRIPT_DIR:~-1%"=="/"	(set "DKSCRIPT_DIR=%DKSCRIPT_DIR:~0,-1%")
    if not exist "%DKSCRIPT_DIR%"	(echo DKSCRIPT_DIR:%DKSCRIPT_DIR% not found & pause & exit 1)
%endfunction%

::##################################################################################
::# dk_DKSCRIPT_NAME
::#
:dk_DKSCRIPT_NAME
    if not exist "%DKSCRIPT_PATH%"	(echo DKSCRIPT_PATH:%DKSCRIPT_PATH% not found & pause & exit 1)
    if not defined DKSCRIPT_NAME	(for %%Z in ("%DKSCRIPT_PATH%") do set "DKSCRIPT_NAME=%%~nZ")
    if not defined DKSCRIPT_NAME	(echo DKSCRIPT_NAME:%DKSCRIPT_NAME% not defined & pause & exit 1)
%endfunction%

::##################################################################################
::# dk_DKSCRIPT_EXT
::#
:dk_DKSCRIPT_EXT
    if not exist "%DKSCRIPT_PATH%"	(echo DKSCRIPT_PATH:%DKSCRIPT_PATH% not found & pause & exit 1)
    if not defined DKSCRIPT_EXT		(for %%Z in ("%DKSCRIPT_PATH%") do set "DKSCRIPT_EXT=%%~xZ")
    if not defined DKSCRIPT_EXT		(echo DKSCRIPT_EXT:%DKSCRIPT_EXT% not defined & pause & exit 1)
%endfunction%

::##################################################################################
::# dk_DKCACHE_DIR
::#
:dk_DKCACHE_DIR
    if not exist   "%DKCACHE_DIR%"     (set "DKCACHE_DIR=%USERPROFILE:\=/%/.dk")
    if not exist   "%DKCACHE_DIR%"     (mkdir %DKCACHE_DIR%)
    if exist       "%DKCACHE_DIR%"     (copy "%DKSCRIPT_PATH%" "%DKCACHE_DIR%" 1>nul 2>nul)
%endfunction%

::##################################################################################
::# dk_DKBATCH_VARS
::#
:dk_DKBATCH_VARS
    if not exist	"%DKBATCH_DIR%"			(for %%Z in ("%DKF%") do set "DKBATCH_DIR=%%~dpZ")
	if not exist	"%DKBATCH_DIR%"			(for %%Z in ("%~dp0") do set "DKBATCH_DIR=%%~dpZ")
	if exist 		"%DKBATCH_DIR%"			(set "DKBATCH_DIR=%DKBATCH_DIR:\=/%")
	if "%DKBATCH_DIR:~-1%"=="/"				(set "DKBATCH_DIR=%DKBATCH_DIR:~0,-1%")
	::for %%Z in ("%DKBATCH_DIR%") do (set "DKBATCH_DIR=%%~dpZ")
    if not exist "%DKBATCH_DIR%"             (echo ERROR: DKBATCH_DIR:%DKBATCH_DIR% does not exist & pause & exit 1)
	
    if not exist "%DKBATCH_FUNCTIONS_DIR%"	(set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_DIR%/functions")
    if not exist "%DKBATCH_FUNCTIONS_DIR%"	(echo ERROR: DKBATCH_FUNCTIONS_DIR:%DKBATCH_FUNCTIONS_DIR% does not exist & pause & exit 1)
	
	if not exist "%DKBATCH_FUNCTIONS_DIR_%"	(set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR%/")
	if not exist "%DKBATCH_FUNCTIONS_DIR_%"	(echo ERROR: DKBATCH_FUNCTIONS_DIR_:%DKBATCH_FUNCTIONS_DIR_% does not exist & pause & exit 1)
    if exist     "%DKBATCH_FUNCTIONS_DIR%"	(set "PATH=%DKBATCH_FUNCTIONS_DIR%;%PATH%")
%endfunction%

::##################################################################################
::# dk_DKHTTP_VARS
::#
:dk_DKHTTP_VARS
    if not defined DKHTTP_DIGITALKNOB_DIR        (set "DKHTTP_DIGITALKNOB_DIR=https://raw.githubusercontent.com/aquawicket/DigitalKnob")
    if not defined DKHTTP_DKBRANCH_DIR           (set "DKHTTP_DKBRANCH_DIR=%DKHTTP_DIGITALKNOB_DIR%/Development")
    if not defined DKHTTP_DKBATCH_DIR            (set "DKHTTP_DKBATCH_DIR=%DKHTTP_DKBRANCH_DIR%/DKBatch")
    if not defined DKHTTP_DKBATCH_FUNCTIONS_DIR  (set "DKHTTP_DKBATCH_FUNCTIONS_DIR=%DKHTTP_DKBATCH_DIR%/functions")
%endfunction%

::##################################################################################
::# dk_initFiles
::#
:dk_initFiles
    if not exist "%DKBATCH_FUNCTIONS_DIR_%dk_source.cmd"	powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_source.cmd', '%DKBATCH_FUNCTIONS_DIR_%dk_source.cmd')"
    if not exist "%DKBATCH_FUNCTIONS_DIR_%dk_call.cmd"		powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_call.cmd', '%DKBATCH_FUNCTIONS_DIR_%dk_call.cmd')"
	if not exist "%DKBATCH_FUNCTIONS_DIR_%dk_getError.cmd"	powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_getError.cmd', '%DKBATCH_FUNCTIONS_DIR_%dk_getError.cmd')"
%endfunction%

::##################################################################################
::# dk_reload
::#
:dk_reload
    if "%DKSCRIPT_EXT%" neq ".cmd" (goto end_dk_reload)
    if defined RELOADED (goto end_dk_reload)
        echo "reloading with delayed expansion . . ."
        set "RELOADED=1"
		set "DK_CMD="

        "%COMSPEC%" /V:ON /K "%DKSCRIPT_PATH%" &::| %DKBATCH_FUNCTIONS_DIR_%dk_tee.cmd %DKSCRIPT_NAME%.log	
	
	&::%DKSCRIPT_ARGS%
	
		:: Change console settings
		:: >nul REG ADD HKCU\Console\digitalknob FontSize /t reg_sz /d "Consolas" /f
		:: start "digitalknob" "%COMSPEC%" /V:ON /K "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%
		:: exit
		
        ::####################################
        ::############ EXIT POINT ############
        ::####################################
			set "exit_code=%errorlevel%"
			echo:
			echo Exit code: %exit_code%
			echo:
			::if "%exit_code%" neq "0" pause
			pause
			exit %exit_code%
    :end_dk_reload
	
	::( >NUL reg delete HKCU\Console\digitalknob /f )
%endfunction%

::##################################################################################
::# dk_DKSCRIPT_VARS
::#
:dk_DKSCRIPT_VARS
	::### DKSCRIPT_PATH ###
    if not exist	"%DKSCRIPT_PATH%"	(set "DKSCRIPT_PATH=%__FILE__%")
    if not exist	"%DKSCRIPT_PATH%"	(set "DKSCRIPT_PATH=%0")
	if defined		DKSCRIPT_PATH		(set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%")
    if not exist	"%DKSCRIPT_PATH%"	(echo ERROR: DKSCRIPT_PATH:%DKSCRIPT_PATH% does not exist & pause & exit 1)
	
	::### DKSCRIPT_ARGS ###
    if not defined  DKSCRIPT_ARGS		(set "DKSCRIPT_ARGS=%__ARGS__%")
	
	::### DKSCRIPT_DIR ###
    if not exist   "%DKSCRIPT_DIR%"		(for %%Z in ("%DKSCRIPT_PATH%") do set "DKSCRIPT_DIR=%%~dpZ")
	if defined		DKSCRIPT_DIR		(set "DKSCRIPT_DIR=%DKSCRIPT_DIR:\=/%")
	if "%DKSCRIPT_DIR:~-1%"=="/"		(set "DKSCRIPT_DIR=%DKSCRIPT_DIR:~0,-1%")
    if not exist   "%DKSCRIPT_DIR%"		(echo ERROR: DKSCRIPT_DIR:%DKSCRIPT_DIR% does not exist & pause & exit 1)
	
	::### DKSCRIPT_NAME ###
    if not defined  DKSCRIPT_NAME		(for %%Z in ("%DKSCRIPT_PATH%") do  set "DKSCRIPT_NAME=%%~nZ")
	
	::### DKSCRIPT_EXT ###
    if not defined  DKSCRIPT_EXT		(for %%Z in ("%DKSCRIPT_PATH%") do  set "DKSCRIPT_EXT=%%~xZ")

    ::### DKCACHE_DIR ###
    if not exist   "%DKCACHE_DIR%"		(set "DKCACHE_DIR=%USERPROFILE:\=/%/.dk")
    if not exist   "%DKCACHE_DIR%"		(mkdir %DKCACHE_DIR:/=\%)
    if exist       "%DKCACHE_DIR%"		(copy "%DKSCRIPT_PATH:/=\%" "%DKCACHE_DIR:/=\%" 1>nul 2>nul)

    ::### DKASSETS_DIR ###
    if exist       "%DKASSETS_DIR%"		(set "DKASSETS_DIR=%DKSCRIPT_DIR%/assets")
    if exist       "%DKASSETS_DIR%"		(set "PATH=%DKASSETS_DIR:/=\%;%PATH%")
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal enableDelayedExpansion
    ::%dk_call% dk_debugFunc 0
	
	%DKSCRIPT_PATH:/=\%
%endfunction%

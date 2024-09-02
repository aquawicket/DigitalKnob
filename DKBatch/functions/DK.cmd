@echo off
if defined DKINIT (goto:eof) else (set "DKINIT=1")

if not exist "%~1" echo DK.cmd must be called with %%~0. I.E.  "DK.cmd" %%~0 & pause & exit 1


(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)

::####################################################################
::# DKINIT
::#
::#
:DK
	:: HOME variable. For analogy with Unix systems.
	if not defined HOME set "HOME=%HOMEDRIVE%%HOMEPATH%"
	set "setlocal=setlocal enableDelayedExpansion"
	set "NO_STDOUT=1>nul"
	set "NO_STDERR=2>nul"
	set "NO_STD=1>nul 2>nul"
	if "!DE!" == ""   set "endfunction=exit /b !errorlevel!"
	if "!DE!" neq ""  set "endfunction=exit /b %errorlevel%"
	if "!DE!" == ""   set "return=exit /b !errorlevel!"
	if "!DE!" neq ""  set "return=exit /b %errorlevel%"
	
    ::###### Initialize Language specifics ######
    call :dk_init
	
	::###### Reload Main Script with cmd ######
    call :dk_reloadWithCmd %~1
	
	::############ Get DKBATCH variables ############
    call :dk_DKBATCH_VARS
	
    ::############ Get DKHTTP variables ############
    call :dk_DKHTTP_VARS

	::############ get dk_source and dk_call ######
	call :dk_initFiles
	
    ::############ Setup dk_callStack ############
	call dk_source dk_callStack
    call dk_callStack
    :dk_callStackReturn

    ::############ Get DKSCRIPT variables ############
    call :dk_DKSCRIPT_VARS
    ::if "%~1" == "%DKBATCH_FUNCTIONS_DIR%\installDKBatch.cmd" for %%Z in (%*) do set "DKSCRIPT_PATH=%%~dpnxZ"      &:: get last argument for DKSCRIPT_PATH
	::echo DKSCRIPT_PATH = %DKSCRIPT_PATH%

    ::############ Elevate Permissions ############
    ::set "ENABLE_dk_elevate=1"
    if "%ENABLE_dk_elevate%" neq "1" goto :skip_elevate
        net session >nul 2>&1
        if %ERRORLEVEL% equ 0 (goto:skip_elevate)
            if "%2" == "elevated" elevated=1
            if not defined elevated (set "elevated=1" & call "%DKBATCH_FUNCTIONS_DIR_%dk_elevate.cmd" %DKSCRIPT_PATH%)
    :skip_elevate

    ::############ Set Options ############
    ::dk_setOptions
	
    ::############ LOAD FUNCTION FILES ############
	set "dk_call=call dk_call"
	::set "dk_call=call"
    call dk_source dk_debugFunc
	%dk_call% dk_color
	%dk_call% dk_logo
	
    if "!DE!" == ""  %dk_call% dk_echo "delayed expansion = ON"
    if "!DE!" neq "" %dk_call% dk_echo "delayed expansion = OFF"
    ::%DK% dk_load %DKSCRIPT_PATH%
	
    ::###### DKTEST MODE ######
    if "%DKSCRIPT_DIR%" neq "%DKBATCH_FUNCTIONS_DIR%" %return%
    %dk_call% dk_echo
    %dk_call% dk_echo "%bg_magenta%%white%###### DKTEST MODE ###### %DKSCRIPT_NAME% ###### DKTEST MODE ######%clr%"
    %dk_call% dk_echo
    call :DKTEST
    %dk_call% dk_echo
    %dk_call% dk_echo "%bg_magenta%%white%########################## END TEST ###############################%clr%"
    %dk_call% dk_echo
    pause
    exit
%endfunction%


::##################################################################################
::# dk_echo
::#
:dk_echo
	echo %~1
%endfunction%


::##################################################################################
::# dk_init
::#
:dk_init
	call :dk_echo "Loading DKBatch DigitalKnob . . ."
%endfunction%


::##################################################################################
::# dk_reloadWithCmd
::#
:dk_reloadWithCmd
	if not exist "%~1" echo :dk_reloadWithCmd must be called with %%~0. I.E.  "call :dk_reloadWithCmd" %%~0 & pause & exit 1
	if not defined DKSCRIPT_PATH    set "DKSCRIPT_PATH=%~1"
	if not exist "%DKSCRIPT_PATH%"  %return%
	if not defined DKSCRIPT_ARGS    for /f "tokens=1,* delims= " %%a in ("%*") do set DKSCRIPT_ARGS=%%b
	
	if defined RELOADED goto:end_dk_reloadWithCmd
		echo "reloading with delayed expansion . . ."
		set "RELOADED=1"
		set "DKINIT="
		
		"%ComSpec%" /V:ON /K %DKSCRIPT_PATH% %DKSCRIPT_ARGS% & pause & exit %ERRORLEVEL%
	:end_dk_reloadWithCmd
%endfunction%


::##################################################################################
::# dk_DKBATCH_VARS
::#
:dk_DKBATCH_VARS
    if not defined DKBATCH_DIR             for %%Z in ("%~dp0..\") do set "DKBATCH_DIR=%%~dpZ"
    if defined DKBATCH_DIR                 set "DKBATCH_DIR=%DKBATCH_DIR:~0,-1%"
    if not defined DKBATCH_FUNCTIONS_DIR   set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_DIR%\functions"
	if not defined DKBATCH_FUNCTIONS_DIR_  set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR%\"
	if exist %DKBATCH_FUNCTIONS_DIR%       set "PATH=%DKBATCH_FUNCTIONS_DIR%;%PATH%"
	if not defined DKTEMP_DIR              for %%Z in ("%~dp0..\..\..\temp\") do set "DKTEMP_DIR=%%~dpZ"
%endfunction%


::##################################################################################
::# dk_DKHTTP_VARS
::#
:dk_DKHTTP_VARS
    if not defined DKHTTP_DIGITALKNOB_DIR        set "DKHTTP_DIGITALKNOB_DIR=https://raw.githubusercontent.com/aquawicket/DigitalKnob"
    if not defined DKHTTP_DKBRANCH_DIR           set "DKHTTP_DKBRANCH_DIR=%DKHTTP_DIGITALKNOB_DIR%/Development"
    if not defined DKHTTP_DKBATCH_DIR            set "DKHTTP_DKBATCH_DIR=%DKHTTP_DKBRANCH_DIR%/DKBatch"
    if not defined DKHTTP_DKBATCH_FUNCTIONS_DIR  set "DKHTTP_DKBATCH_FUNCTIONS_DIR=%DKHTTP_DKBATCH_DIR%/functions"
%endfunction%

::##################################################################################
::# dk_initFiles
::#
:dk_initFiles
	if not exist "%DKBATCH_FUNCTIONS_DIR_%dk_source.cmd" powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_source.cmd', '%DKBATCH_FUNCTIONS_DIR_%dk_source.cmd')"
    if not exist "%DKBATCH_FUNCTIONS_DIR_%dk_call.cmd" powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_call.cmd', '%DKBATCH_FUNCTIONS_DIR_%dk_call.cmd')"
%endfunction%


::##################################################################################
::# dk_DKSCRIPT_VARS
::#
:dk_DKSCRIPT_VARS
	if not defined DKSCRIPT_PATH       set "DKSCRIPT_PATH=%__FILE__%"
	if not exist "%DKSCRIPT_PATH%"     set "DKSCRIPT_PATH=%0"
	set "DKSCRIPT_ARGS=%__ARGS__%"
	for %%Z in ("%DKSCRIPT_PATH%") do  set "DKSCRIPT_DIR=%%~dpZ"
	set "DKSCRIPT_DIR=%DKSCRIPT_DIR:~0,-1%"
	for %%Z in ("%DKSCRIPT_PATH%") do  set "DKSCRIPT_NAME=%%~nZ"
	
	::### ASSETS ###
	if not defined DKASSETS_DIR        set "DKASSETS_DIR=%DKSCRIPT_DIR%\assets"
	if exist %DKASSETS_DIR%            set "PATH=%DKASSETS_DIR%;%PATH%"
%endfunction%








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
	
    %DKSCRIPT_NAME%
%endfunction%

@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::#####################################################################
::# dk_validateDK()
::#
::#
:dk_validateDK
::setlocal
    %dk_call% dk_debugFunc 0
 
	%dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	if not defined DKBRANCH          set "DKBRANCH=Development"
	if not defined DKBRANCH_DIR      set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\%DKBRANCH%"
	
	if exist "%DKBRANCH_DIR%\.git" (if not "%DKSCRIPT_NAME%" equ "DKBuilder" %return%)
	if exist "%DKBRANCH_DIR%\.git" (if "%DKSCRIPT_DIR%" equ "%DKBRANCH_DIR%" %return%)

    if not exist "%DKBRANCH_DIR%\.git" (%dk_call% dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git %DKBRANCH%)
	
	if "%DKSCRIPT_NAME%" equ "DKBuilder" set "DKSCRIPT_PATH=%DKBRANCH_DIR%\%DKSCRIPT_NAME%%DKSCRIPT_EXT%"
	if not exist "%DKSCRIPT_PATH%"  %dk_call% dk_fatal "DKSCRIPT_PATH:%DKSCRIPT_PATH% does not exist"
	
	if "%DKSCRIPT_NAME%" equ "DKBuilder" set "DKSCRIPT_ARGS=%DKSCRIPT_PATH%"
	for %%Z in ("%DKSCRIPT_PATH%") do set "DKSCRIPT_DIR=%%~dpZ"
	if "%DKSCRIPT_DIR:~-1%" equ "\" set "DKSCRIPT_DIR=%DKSCRIPT_DIR:~0,-1%"
	if "%DKSCRIPT_DIR:~-1%" equ "/" set "DKSCRIPT_DIR=%DKSCRIPT_DIR:~0,-1%"
	set "RELOADED="
	
	::set "DKSCRIPT_DIR=%DKBRANCH_DIR%"
	::set "DKSCRIPT_NAME="
	::set "DKSCRIPT_EXT="
	::set "DKBATCH_DIR="
	::set "DKBATCH_FUNCTIONS_DIR=%DKBRANCH_DIR%\DKBatch\functions"
	::set "DKBATCH_FUNCTIONS_DIR_="
	::set "DKASSETS_DIR="
	
	exit /b 1
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
    %dk_call% dk_debugFunc 0
    
    %dk_call% dk_validateDK
%endfunction%

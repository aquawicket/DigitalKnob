@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#####################################################################
::# dk_validateDK()
::#
::#
:dk_validateDK
 ::setlocal
    call dk_debugFunc 0
	
	if not defined DIGITALKNOB_DIR   set "C:\Users\Administrator\digitalknob"
	if not defined DKBRANCH          set "DKBRANCH=Development"
	if not defined DKBRANCH_DIR      set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\%DKBRANCH%"
	
	if exist "C:\Users\Administrator\digitalknob\Development\.git" if "%DKSCRIPT_NAME%" neq "DKBuilder" %return%
	if exist "C:\Users\Administrator\digitalknob\Development\.git" if "%DKSCRIPT_DIR%" equ "%DKBRANCH_DIR%" %return%
	
    if not exist "C:\Users\Administrator\digitalknob\Development\.git"  %dk_call% dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git Development
	
	if "%DKSCRIPT_NAME%" equ "DKBuilder" set "DKSCRIPT_PATH=%DKBRANCH_DIR%\%DKSCRIPT_NAME%%DKSCRIPT_EXT%"
	if not exist %DKSCRIPT_PATH%  %dk_call% dk_fatal "DKSCRIPT_PATH:%DKSCRIPT_PATH% does not exist" && %return%
	
	if "%DKSCRIPT_NAME%" equ "DKBuilder" set "DKSCRIPT_ARGS=%DKSCRIPT_PATH%"
	set "DKSCRIPT_DIR="
	set "DKSCRIPT_NAME="
	set "DKSCRIPT_EXT="
	set "DKBATCH_DIR="
	set "DKBATCH_FUNCTIONS_DIR="
	set "DKBATCH_FUNCTIONS_DIR_="
	set "DKASSETS_DIR="
	set "RELOADED="
	
	exit /b 1
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
    
    %dk_call% dk_validateDK
%endfunction%

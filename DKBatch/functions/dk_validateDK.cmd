@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#####################################################################
::# dk_validateDK()
::#
::#
:dk_validateDK
 ::setlocal
    call dk_debugFunc 0
	
	if not defined DIGITALKNOB_DIR   %dk_call% dk_setDIGITALKNOB_DIR
	if not defined DKBRANCH          set "DKBRANCH=Development"
	if not defined DKBRANCH_DIR      set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\%DKBRANCH%"
    if exist "%DKBRANCH_DIR%\.git" %return%
	
    if not exist "%DKBRANCH_DIR%\.git"  %dk_call% dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git Development
	exit /b 1
::	echo DKSCRIPT_PATH %DKSCRIPT_PATH%
::	echo DKSCRIPT_DIR %DKSCRIPT_DIR%
::	echo DKBRANCH_DIR %DKBRANCH_DIR%
::	
::	echo "%DKBRANCH_DIR%\%DKSCRIPT_NAME%"
::	echo "%DKSCRIPT_DIR%" neq "%DKBRANCH_DIR%"
::	::set "RELOADED="
::	::set "DKINIT="
::	if "%DKSCRIPT_DIR%" neq "%DKBRANCH_DIR%" "%ComSpec%" /V:ON /K "%DKSCRIPT_PATH%" %~1
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
    
    %dk_call% dk_validateDK
%endfunction%

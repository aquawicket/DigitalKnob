@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%../../../DKBatch/functions/")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)


::####################################################################
::# DKINSTALL
::#
::#
:DKINSTALL
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_todo "implement dk_import.cmd"
	::%dk_call% dk_import "https://github.com/ovsky/ghost-open-toolbox/archive/b43ed1d2b3661eb1f76083330ba40e18bc9e36e8.zip"
	
	%dk_call% dk_cmakeEval "include('%DKIMPORTS_DIR%/msys2/DKINSTALL.cmake')"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%

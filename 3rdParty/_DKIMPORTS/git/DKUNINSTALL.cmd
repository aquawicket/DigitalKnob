@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"

:: https://stackoverflow.com/a/67714373
::%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
::if NOT defined GIT_CONFIG_SYSTEM (set "GIT_CONFIG_SYSTEM=!DKCACHE_DIR!\.gitSystem")
::if NOT defined GIT_CONFIG_GLOBAL (set "GIT_CONFIG_GLOBAL=!DKCACHE_DIR!\.gitGlobal")

::####################################################################
::# DKUNINSTALL
::#
::#
:DKUNINSTALL
%setlocal%
    %dk_call% dk_debugFunc 0

	%dk_call% dk_unimport APP

	%dk_call% dk_uninstall git/contextMenu

%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
    %dk_call% DKUNINSTALL
%endfunction%

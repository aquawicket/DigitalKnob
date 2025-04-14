@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%../../../DKBatch/functions/")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# DKINSTALL
::#
:DKINSTALL
::setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
    %dk_call% dk_cmakeEval "dk_load(%DKIMPORTS_DIR%/msys2_toolchain/DKINSTALL.cmake)" "MSYS2_TOOLCHAIN"
	%dk_call% dk_assertVar MSYS2_TOOLCHAIN
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%

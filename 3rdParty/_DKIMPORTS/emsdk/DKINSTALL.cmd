@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR    "%dk_call% dk_DKIMPORTS_DIR"
    %dk_call% dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/emsdk/DKINSTALL.cmake')" "EMSDK;EMSDK_ENV;EMSDK_GENERATOR;EMSDK_TOOLCHAIN_FILE;EMSDK_C_COMPILER;EMSDK_CXX_COMPILER"
    %dk_call% dk_assertVar EMSDK
    %dk_call% dk_assertVar EMSDK_ENV
    %dk_call% dk_assertVar EMSDK_GENERATOR
    %dk_call% dk_assertVar EMSDK_TOOLCHAIN_FILE
    %dk_call% dk_assertVar EMSDK_C_COMPILER
    %dk_call% dk_assertVar EMSDK_CXX_COMPILER
	
	endlocal & (
		set "EMSDK=%EMSDK%"
		set "EMSDK_ENV=%EMSDK_ENV%"
		set "EMSDK_GENERATOR=%EMSDK_GENERATOR%"
		set "EMSDK_TOOLCHAIN_FILE=%EMSDK_TOOLCHAIN_FILE%"
		set "EMSDK_C_COMPILER=%EMSDK_C_COMPILER%"
		set "EMSDK_CXX_COMPILER=%EMSDK_CXX_COMPILER%"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% DKINSTALL
%endfunction%

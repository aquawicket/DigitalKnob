@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR    "%dk_call% dk_DKIMPORTS_DIR"
    %dk_call% dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/emsdk/DKINSTALL.cmake')" "emsdk;emsdk_ENV;emsdk_GENERATOR;emsdk_TOOLCHAIN_FILE;emsdk_C_COMPILER;emsdk_CXX_COMPILER"
    %dk_call% dk_assertVar emsdk
    %dk_call% dk_assertVar emsdk_ENV
    %dk_call% dk_assertVar emsdk_GENERATOR
    %dk_call% dk_assertVar emsdk_TOOLCHAIN_FILE
    %dk_call% dk_assertVar emsdk_C_COMPILER
    %dk_call% dk_assertVar emsdk_CXX_COMPILER
	
	endlocal & (
		set "emsdk=%emsdk%"
		set "emsdk_ENV=%emsdk_ENV%"
		set "emsdk_GENERATOR=%emsdk_GENERATOR%"
		set "emsdk_TOOLCHAIN_FILE=%emsdk_TOOLCHAIN_FILE%"
		set "emsdk_C_COMPILER=%emsdk_C_COMPILER%"
		set "emsdk_CXX_COMPILER=%emsdk_CXX_COMPILER%"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% DKINSTALL
%endfunction%

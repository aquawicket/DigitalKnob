@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############ clang ############
::# https://packages.msys2.org/package/mingw-w64-x86_64-clang?repo=mingw64
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_cmakeEval "dk_load(%DKIMPORTS_DIR%/clang/DKINSTALL.cmake)" "CLANG_C_COMPILER;CLANG_CXX_COMPILER"
	%dk_call% dk_assertVar CLANG_C_COMPILER
	%dk_call% dk_assertVar CLANG_CXX_COMPILER
::	endlocal & (
::		set "CLANG_C_COMPILER=%CLANG_C_COMPILER%"
::		set "CLANG_CXX_COMPILER=%CLANG_CXX_COMPILER%"
::	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% DKINSTALL
%endfunction%

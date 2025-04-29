@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::######################## dk_evalDKCpp settings ######################
if not defined dk_evalDKCpp_DEFAULT_TARGET_OS	(set "dk_evalDKCpp_DEFAULT_TARGET_OS=cosmocc")
if not defined dk_evalDKCpp_DEFAULT_TARGET_ARCH	(set "dk_evalDKCpp_DEFAULT_TARGET_ARCH=cosmocc")
if not defined dk_evalDKCpp_DEFAULT_TARGET_ENV	(set "dk_evalDKCpp_DEFAULT_TARGET_ENV=cosmocc")	&:: clang, cosmocc, gcc, msvc 
::#####################################################################
::# dk_evalDKCpp(<code>)
::#
::#
:dk_evalDKCpp
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 1 99
 
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	::echo %~1 > "%DKCACHE_DIR%/dk_evalDKCpp_TEMP.cpp"
	
	::###### DKCPP_BUILD_DIR ######
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	set "DKCPP_BUILD_DIR=%DKCACHE_DIR%/DKCPP_BUILD_DIR"
	if not exist "%DKCPP_BUILD_DIR%" (%dk_call% dk_mkdir "%DKCPP_BUILD_DIR%")
	
	::###### _exe_ ######
	set "_exe_=%DKCPP_BUILD_DIR%/dk_evalDKCpp_TEMP.exe"
	
	::###### _code_ ######
	set "_code_=%~1"

	::### All but first Args ###
	%dk_call% dk_allButFirstArgs %*

::	::###### DKCPP_FUNCTIONS_DIR ######
::	%dk_call% dk_validate DKCPP_FUNCTIONS_DIR  "%dk_call% dk_DKBRANCH_DIR"
::	%dk_call% dk_assertPath DKCPP_FUNCTIONS_DIR
::
::	::###### DKHTTP_DKCPP_FUNCTIONS_DIR ######
::	%dk_call% dk_assertVar DKHTTP_DKBRANCH_DIR
::	if not defined DKHTTP_DKCPP_DIR		 		(set "DKHTTP_DKCPP_DIR=%DKHTTP_DKBRANCH_DIR%/DKC")
::	if not defined DKHTTP_DKCPP_FUNCTIONS_DIR		(set "DKHTTP_DKCPP_FUNCTIONS_DIR=%DKHTTP_DKCPP_DIR%/functions")
::
::	::###### Download files if missing ######
::	if not exist %DKCPP_FUNCTIONS_DIR%/DK.h	(%dk_call% dk_download "%DKHTTP_DKCPP_FUNCTIONS_DIR%/DK.h" "%DKCPP_FUNCTIONS_DIR%/DK.h")
::	::if not exist %DKCPP_FUNCTIONS_DIR%/%~1.cpp	(%dk_call% dk_download "%DKHTTP_DKCPP_FUNCTIONS_DIR%/%~1.cpp" "%DKCPP_FUNCTIONS_DIR%/%~1.cpp")

	::###### target_os ######
	if not defined target_os (set "target_os=%dk_evalDKCpp_DEFAULT_TARGET_OS%")
	%dk_call% dk_debug "target_os = %target_os%"

	::###### target_arch ######
	if not defined target_arch (set "target_arch=%dk_evalDKCpp_DEFAULT_TARGET_ARCH%")
	%dk_call% dk_debug "target_arch = %target_arch%"

	::###### target_env ######
	if not defined target_env (set "target_env=%dk_evalDKCpp_DEFAULT_TARGET_ENV%")
	%dk_call% dk_debug "target_env = %target_env%"

	::###### COMPILER_EXE ######
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	if "%target_env%" equ "cosmocc" (
		%dk_call% dk_validate SH_EXE				"%dk_call% %DKIMPORTS_DIR%/sh/DKINSTALL.cmd"
		%dk_call% dk_validate COSMOCC_CXX_COMPILER	"%dk_call% %DKIMPORTS_DIR%/cosmocc/DKINSTALL.cmd"
		%dk_call% dk_assertPath COSMOCC_CXX_COMPILER
		set "COMPILER_EXE=!SH_EXE! !COSMOCC_CXX_COMPILER!"
	)

	if "%target_env%" equ "clang" (
		%dk_call% dk_validate CLANG_CXX_COMPILER		"%dk_call% %DKIMPORTS_DIR%/clang/DKINSTALL.cmd"
		%dk_call% dk_assertPath CLANG_CXX_COMPILER
		set "COMPILER_EXE=!CLANG_CXX_COMPILER!"
	)
	if "%target_env%" equ "gcc" (
		%dk_call% dk_validate GCC_CXX_COMPILER		"%dk_call% %DKIMPORTS_DIR%/gcc/DKINSTALL.cmd"
		%dk_call% dk_assertPath GCC_CXX_COMPILER
		set "COMPILER_EXE=!GCC_CXX_COMPILER!"
	)
	%dk_call% dk_debug "COMPILER_EXE = %COMPILER_EXE%"

	::###### _cpp_file_ ######
	set "_cpp_file_=%DKCACHE_DIR%/dk_evalDKCpp_TEMP.cpp"
	%dk_call% dk_assertPath _cpp_file_

	::###### COMPILE_COMMAND ######
	%dk_call% dk_echo "compiling ..."
	if exist "%_exe_%" (%dk_call% dk_delete "%_exe_%")

	set "COMPILE_COMMAND=%COMPILER_EXE% -o %_exe_% -static %_cpp_file_%"
	echo %COMPILE_COMMAND%
	%COMPILE_COMMAND%

	if not exist "%_exe_%" (
		echo:
		%dk_call% dk_error "failed to compile %_cpp_file_%"
		%return%
	)

	::############ DKCOMMAND ############
	set DKCOMMAND=%_exe_% &::%dk_allButFirstArgs%
	
	:::echo %dk_call% dk_exec %DKCOMMAND%
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_evalDKCpp=%dk_exec%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_evalDKCpp "printf("test dk_evalDKCpp");"
	
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_evalDKCpp = %dk_evalDKCpp%"
%endfunction%

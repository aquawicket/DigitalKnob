@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::######################## dk_evalDKCpp settings ######################
if not defined dk_evalDKCpp_Default_Target_Os	(set "dk_evalDKCpp_Default_Target_Os=cosmocc")
if not defined dk_evalDKCpp_Default_Target_Arch	(set "dk_evalDKCpp_Default_Target_Arch=cosmocc")
if not defined dk_evalDKCpp_Default_Target_Env	(set "dk_evalDKCpp_Default_Target_Env=cosmocc")	&:: clang, cosmocc, gcc, msvc 
::#####################################################################
::# dk_evalDKCpp(<code>)
::#
::#
:dk_evalDKCpp
%setlocal%
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

	::###### Target_Os ######
	if not defined Target_Os (set "Target_Os=%dk_evalDKCpp_Default_Target_Os%")
	%dk_call% dk_debug "Target_Os = %Target_Os%"

	::###### Target_Arch ######
	if not defined Target_Arch (set "Target_Arch=%dk_evalDKCpp_Default_Target_Arch%")
	%dk_call% dk_debug "Target_Arch = %Target_Arch%"

	::###### Target_Env ######
	if not defined Target_Env (set "Target_Env=%dk_evalDKCpp_Default_Target_Env%")
	%dk_call% dk_debug "Target_Env = %Target_Env%"

	::###### COMPILER_EXE ######
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	if "%Target_Env%" equ "cosmocc" (
		%dk_call% dk_validate SH_EXE				"%dk_call% %DKIMPORTS_DIR%/sh/DKINSTALL.cmd"
		%dk_call% dk_validate COSMOCC_CXX_COMPILER	"%dk_call% %DKIMPORTS_DIR%/cosmocc/DKINSTALL.cmd"
		%dk_call% dk_assertPath COSMOCC_CXX_COMPILER
		set "COMPILER_EXE=!SH_EXE! !COSMOCC_CXX_COMPILER!"
	)

	if "%Target_Env%" equ "clang" (
		%dk_call% dk_validate CLANG_CXX_COMPILER		"%dk_call% %DKIMPORTS_DIR%/clang/DKINSTALL.cmd"
		%dk_call% dk_assertPath CLANG_CXX_COMPILER
		set "COMPILER_EXE=!CLANG_CXX_COMPILER!"
	)
	if "%Target_Env%" equ "gcc" (
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
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_evalDKCpp "printf("test dk_evalDKCpp");"
	
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_evalDKCpp = %dk_evalDKCpp%"
%endfunction%

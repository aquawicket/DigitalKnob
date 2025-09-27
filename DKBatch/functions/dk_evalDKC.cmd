@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::######################## dk_evalDKC settings ########################
if NOT defined dk_evalDKC_Default_Target_Env (set "dk_evalDKC_Default_Target_Env=clang")
::#####################################################################
::# dk_evalDKC(<code>)
::#
::#
:dk_evalDKC
%setlocal%
	%dk_call% dk_debugFunc 1 99

	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	::echo %~1 > "%DKCACHE_DIR%/dk_evalDKC_TEMP.c"
	
	::###### DKC_BUILD_DIR ######
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	set "DKC_BUILD_DIR=%DKCACHE_DIR%/DKC_BUILD_DIR"
	if NOT EXIST "%DKC_BUILD_DIR%" (%dk_call% dk_mkdir "%DKC_BUILD_DIR%")
	
	::###### _exe_ ######
	set "_exe_=%DKC_BUILD_DIR%/dk_evalDKC_TEMP.exe"
	
	::###### _code_ ######
	set "_code_=%~1"

	::### All but first Args ###
	%dk_call% dk_allButFirstArgs %*

::	::###### DKC_FUNCTIONS_DIR ######
::	%dk_call% dk_validate DKC_FUNCTIONS_DIR  "%dk_call% dk_DKBRANCH_DIR"
::	%dk_call% dk_assertPath DKC_FUNCTIONS_DIR
::
::	::###### DKHTTP_DKC_FUNCTIONS_DIR ######
::	%dk_call% dk_assertVar DKHTTP_DKBRANCH_DIR
::	if NOT defined DKHTTP_DKC_DIR		 		(set "DKHTTP_DKC_DIR=%DKHTTP_DKBRANCH_DIR%/DKC")
::	if NOT defined DKHTTP_DKC_FUNCTIONS_DIR		(set "DKHTTP_DKC_FUNCTIONS_DIR=%DKHTTP_DKC_DIR%/functions")
::
::	::###### Download files if missing ######
::	if NOT EXIST "%DKC_FUNCTIONS_DIR%/DK.h"	(%dk_call% dk_download "%DKHTTP_DKC_FUNCTIONS_DIR%/DK.h" "%DKC_FUNCTIONS_DIR%/DK.h")
::	::if NOT EXIST "%DKC_FUNCTIONS_DIR%/%~1.c"	(%dk_call% dk_download "%DKHTTP_DKC_FUNCTIONS_DIR%/%~1.c" "%DKC_FUNCTIONS_DIR%/%~1.c")

	if NOT defined Host_Tuple						(%dk_call% dk_Host_Tuple)
	if NOT defined dk_evalDKC_Default_Target_Os		(set "dk_evalDKC_Default_Target_Os=%Host_Os%")
	if NOT defined dk_evalDKC_Default_Target_Arch	(set "dk_evalDKC_Default_Target_Arch=%Host_Arch%")
	
	::###### Target_Os ######
	if NOT defined Target_Os (set "Target_Os=%dk_evalDKC_DEFAULT_TARGET_OS%")
	%dk_call% dk_debug "Target_Os = %Target_Os%"

	::###### Target_Arch ######
	if NOT defined Target_Arch (set "Target_Arch=%dk_evalDKC_Default_Target_Arch%")
	%dk_call% dk_debug "Target_Arch = %Target_Arch%"

	::###### Target_Env ######
	if NOT defined Target_Env (set "Target_Env=%dk_evalDKC_Default_Target_Env%")
	%dk_call% dk_debug "Target_Env = %Target_Env%"
	
	if "%Target_Env%" equ "cosmocc" (
		set "Target_Os=cosmocc"
		set "Target_Arch=cosmocc"
	)
	
	if NOT defined Target_Tuple (set "Target_Tuple=%Target_Os%_%Target_Arch%_%Target_Env%")

	::###### COMPILER_EXE ######
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	if "%Target_Env%" equ "cosmocc" (
		%dk_call% dk_validate sh_exe				"%dk_call% dk_depend sh_exe"
		%dk_call% dk_validate COSMOCC_C_COMPILER	"%dk_call% dk_depend cosmocc"
		%dk_call% dk_assertPath COSMOCC_C_COMPILER
		set "COMPILER_EXE=!sh_exe! !COSMOCC_C_COMPILER!"
	)

	if "%Target_Env%" equ "clang" (
		%dk_call% dk_validate CLANG_C_COMPILER		"%dk_call% dk_depend clang"
		%dk_call% dk_assertPath CLANG_C_COMPILER
		set "COMPILER_EXE=!CLANG_C_COMPILER!"
	)
	if "%Target_Env%" equ "gcc" (
		%dk_call% dk_validate GCC_C_COMPILER		"%dk_call% dk_depend gcc"
		%dk_call% dk_assertPath GCC_C_COMPILER
		set "COMPILER_EXE=!GCC_C_COMPILER!"
	)
	%dk_call% dk_debug "COMPILER_EXE = %COMPILER_EXE%"

	::###### _c_file_ ######
	set "_c_file_=%DKCACHE_DIR%/dk_evalDKC_TEMP.c"
	%dk_call% dk_assertPath _c_file_

	::###### COMPILE_COMMAND ######
	%dk_call% dk_echo "compiling ..."
	if EXIST "%_exe_%" (%dk_call% dk_delete "%_exe_%")

	set "COMPILE_COMMAND=%COMPILER_EXE% -o %_exe_% -static %_c_file_%"
	echo %COMPILE_COMMAND%
	%COMPILE_COMMAND%

	if NOT EXIST "%_exe_%" (
		echo(
		%dk_call% dk_error "failed to compile %_c_file_%"
		%return%
	)

	::############ DKCOMMAND ############
	set DKCOMMAND=%_exe_% &::%dk_allButFirstArgs%
	
	:::echo %dk_call% dk_exec %DKCOMMAND%
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_evalDKC=%dk_exec%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_evalDKC "printf("test dk_evalDKC");"
	
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_evalDKC = %dk_evalDKC%"
%endfunction%

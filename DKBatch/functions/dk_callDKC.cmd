@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################## dk_callDKC settings #############################
::if not defined dk_callDKC_Target_Os 	(set "dk_callDKC_Target_Os=%Host_Os%")		&::  android, cosmocc, emscripten, ios, iossim, linux, mac, win
::if not defined dk_callDKC_Target_Arch (set "dk_callDKC_Target_Arch=%Host_Arch%")	&::  arm32, arm64, cosmocc, x86, x86_64
::if not defined dk_callDKC_Target_Env 	(set "dk_callDKC_Target_Env=Clang")			&::  clang, cosmocc, gcc, msvc
::####################################################################
::# dk_callDKC(function, arguments...)
::# dk_callDKC(function, arguments..., rtn_var)
::#
::#
:dk_callDKC
%setlocal%
	%dk_call% dk_debugFunc 1 99
 
	::###### _func_ ######
	set "_func_=%~1"

	::### All but first Args ###
	%dk_call% dk_allButFirstArgs %*

	::###### DKC_FUNCTIONS_DIR ######
	%dk_call% dk_validate DKC_FUNCTIONS_DIR  "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_assertPath DKC_FUNCTIONS_DIR

	::###### DKHTTP_DKC_FUNCTIONS_DIR ######
	%dk_call% dk_assertVar DKHTTP_DKBRANCH_DIR
	if not defined DKHTTP_DKC_DIR		 		(set "DKHTTP_DKC_DIR=%DKHTTP_DKBRANCH_DIR%/DKC")
	if not defined DKHTTP_DKC_FUNCTIONS_DIR		(set "DKHTTP_DKC_FUNCTIONS_DIR=%DKHTTP_DKC_DIR%/functions")

	::###### Download files if missing ######
	if not exist %DKC_FUNCTIONS_DIR%/DK.h	(%dk_call% dk_download "%DKHTTP_DKC_FUNCTIONS_DIR%/DK.h" "%DKC_FUNCTIONS_DIR%/DK.h")
	if not exist %DKC_FUNCTIONS_DIR%/%~1.c	(%dk_call% dk_download "%DKHTTP_DKC_FUNCTIONS_DIR%/%~1.c" "%DKC_FUNCTIONS_DIR%/%~1.c")

	::###### Target_Os ######
	if not defined Target_Os (
		if not defined dk_callDKC_Target_Os (
			%dk_call% dk_validate Host_Os "%dk_call% dk_Host_Os"
			set "dk_callDKC_Target_Os=!Host_Os!"
		)
		set "Target_Os=!dk_callDKC_Target_Os!"
	)
	%dk_call% dk_debug "Target_Os = %Target_Os%"

	::###### Target_Arch ######
	if not defined Target_Arch (
		if not defined dk_callDKC_Target_Arch (
			%dk_call% dk_validate Host_Arch "%dk_call% dk_Host_Arch"
			set "dk_callDKC_Target_Arch=!Host_Arch!"
		)
		set "Target_Arch=!dk_callDKC_Target_Arch!"
	)
	%dk_call% dk_debug "Target_Arch = %Target_Arch%"

	::###### Target_Env ######
	if not defined Target_Env (
		if not defined dk_callDKC_Target_Env (
			set "dk_callDKC_Target_Env=Clang"
		)
		set "Target_Env=!dk_callDKC_Target_Env!"
	)
	%dk_call% dk_debug "Target_Env = %Target_Env%"

	::###### Target_Tuple ######
	if not defined Target_Tuple (
		set "Target_Tuple=%Target_Os%_%Target_Arch%_%Target_Env%"
	)
	%dk_call% dk_debug "Target_Tuple = %Target_Tuple%"
	
	::###### COMPILER_EXE ######
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	if /i "%Target_Env%" equ "cosmocc" (
		%dk_call% dk_validate SH_EXE				"%dk_call% %DKIMPORTS_DIR%/sh/DKINSTALL.cmd"
		%dk_call% dk_validate COSMOCC_C_COMPILER	"%dk_call% %DKIMPORTS_DIR%/cosmocc/DKINSTALL.cmd"
		%dk_call% dk_assertPath COSMOCC_C_COMPILER
		set "COMPILER_EXE=!SH_EXE! !COSMOCC_C_COMPILER!"
	)

	if /i "%Target_Env%" equ "clang" (
		%dk_call% dk_validate CLANG_C_COMPILER		"%dk_call% %DKIMPORTS_DIR%/clang/DKINSTALL.cmd"
		%dk_call% dk_assertPath CLANG_C_COMPILER
		set "COMPILER_EXE=!CLANG_C_COMPILER!"
	)
	if /i "%Target_Env%" equ "gcc" (
		%dk_call% dk_validate GCC_C_COMPILER		"%dk_call% %DKIMPORTS_DIR%/gcc/DKINSTALL.cmd"
		%dk_call% dk_assertPath GCC_C_COMPILER
		set "COMPILER_EXE=!GCC_C_COMPILER!"
	)

	::###### _c_file_ ######
	set "_c_file_=%DKC_FUNCTIONS_DIR%/%_func_%.c"
	%dk_call% dk_assertPath _c_file_

	::###### DKC_BUILD_DIR ######
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	set "DKC_BUILD_DIR=%DKCACHE_DIR%/DKC_BUILD_DIR"
	if not exist "%DKC_BUILD_DIR%" (%dk_call% dk_mkdir "%DKC_BUILD_DIR%")

	::###### _app_exe_ ######
	set "_app_exe_=%DKC_BUILD_DIR%/%_func_%.exe"

	::###### Compile Code ######
	%dk_call% dk_echo "compiling ..."
	if exist "%_app_exe_%" (%dk_call% dk_delete "%_app_exe_%")

	%dk_call% dk_debug "COMPILER_EXE = %COMPILER_EXE%"
	set "COMPILE_COMMAND=%COMPILER_EXE% -o %_app_exe_% -static %_c_file_%"
	echo %COMPILE_COMMAND%
	%COMPILE_COMMAND%

	if not exist "%_app_exe_%" (
		%dk_call% dk_echo
		%dk_call% dk_error "failed to compile %_c_file_%"
		%return%
	)

	::############ DKC function call ############
	set DKCOMMAND=%_app_exe_% %dk_allButFirstArgs%
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_callDKC=%dk_exec%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKC dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKC = %dk_callDKC%"
%endfunction%

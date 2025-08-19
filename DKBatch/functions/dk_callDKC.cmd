@echo off&::###### DK.cmd #########################################################################################################################
if NOT exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################## dk_callDKC settings #############################
::if NOT defined dk_callDKC_Target_Os 	(set "dk_callDKC_Target_Os=%Host_Os%")		&::  Android, Cosmo, Emscripten, Ios, Iossim, Linux, Mac, Win
::if NOT defined dk_callDKC_Target_Arch (set "dk_callDKC_Target_Arch=%Host_Arch%")	&::  Arm32, Arm64, Cosmo, X86, X86_64
::if NOT defined dk_callDKC_Target_Env 	(set "dk_callDKC_Target_Env=Clang")			&::  Clang, Cosmo, Gcc, Msvc
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
	if NOT defined DKHTTP_DKC_DIR		 		(set "DKHTTP_DKC_DIR=%DKHTTP_DKBRANCH_DIR%/DKC")
	if NOT defined DKHTTP_DKC_FUNCTIONS_DIR		(set "DKHTTP_DKC_FUNCTIONS_DIR=%DKHTTP_DKC_DIR%/functions")

	::###### Download files if missing ######
	if NOT exist %DKC_FUNCTIONS_DIR%/DK.h	(%dk_call% dk_download "%DKHTTP_DKC_FUNCTIONS_DIR%/DK.h" "%DKC_FUNCTIONS_DIR%/DK.h")
	if NOT exist %DKC_FUNCTIONS_DIR%/%~1.c	(%dk_call% dk_download "%DKHTTP_DKC_FUNCTIONS_DIR%/%~1.c" "%DKC_FUNCTIONS_DIR%/%~1.c")

	::###### Target_Os ######
	if NOT defined Target_Os (
		if NOT defined dk_callDKC_Target_Os (
			%dk_call% dk_validate Host_Os "%dk_call% dk_Host_Os"
			set "dk_callDKC_Target_Os=!Host_Os!"
		)
		set "Target_Os=!dk_callDKC_Target_Os!"
	)
	%dk_call% dk_debug "Target_Os = %Target_Os%"

	::###### Target_Arch ######
	if NOT defined Target_Arch (
		if NOT defined dk_callDKC_Target_Arch (
			%dk_call% dk_validate Host_Arch "%dk_call% dk_Host_Arch"
			set "dk_callDKC_Target_Arch=!Host_Arch!"
		)
		set "Target_Arch=!dk_callDKC_Target_Arch!"
	)
	%dk_call% dk_debug "Target_Arch = %Target_Arch%"

	::###### Target_Env ######
	if NOT defined Target_Env (
		if NOT defined dk_callDKC_Target_Env (
			set "dk_callDKC_Target_Env=Clang"
		)
		set "Target_Env=!dk_callDKC_Target_Env!"
	)
	%dk_call% dk_debug "Target_Env = %Target_Env%"

	::###### Target_Tuple ######
	if NOT defined Target_Tuple (
		set "Target_Tuple=%Target_Os%_%Target_Arch%_%Target_Env%"
	)
	%dk_call% dk_debug "Target_Tuple = %Target_Tuple%"
	
	::###### COMPILER_EXE ######
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	if /i "%Target_Env%" equ "Cosmo" (
		%dk_call% dk_validate SH_EXE				"%dk_call% dk_depend sh"
		%dk_call% dk_validate COSMOCC_C_COMPILER	"%dk_call% dk_depend Cosmo"
		%dk_call% dk_assertPath COSMOCC_C_COMPILER
		set "COMPILER_EXE=!SH_EXE! !COSMOCC_C_COMPILER!"
	)

	if /i "%Target_Env%" equ "Clang" (
		%dk_call% dk_validate CLANG_C_COMPILER		"%dk_call% dk_depend Clang"
		%dk_call% dk_assertPath CLANG_C_COMPILER
		set "COMPILER_EXE=!CLANG_C_COMPILER!"
	)
	if /i "%Target_Env%" equ "Gcc" (
		%dk_call% dk_validate GCC_C_COMPILER		"%dk_call% dk_depend Gcc"
		%dk_call% dk_assertPath GCC_C_COMPILER
		set "COMPILER_EXE=!GCC_C_COMPILER!"
	)

	::###### _c_file_ ######
	set "_c_file_=%DKC_FUNCTIONS_DIR%/%_func_%.c"
	%dk_call% dk_assertPath _c_file_

	::###### DKC_BUILD_DIR ######
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	set "DKC_BUILD_DIR=%DKCACHE_DIR%/DKC_BUILD_DIR"
	if NOT exist "%DKC_BUILD_DIR%" (%dk_call% dk_mkdir "%DKC_BUILD_DIR%")

	::###### _app_exe_ ######
	set "_app_exe_=%DKC_BUILD_DIR%/%_func_%.exe"

	::###### Compile Code ######
	%dk_call% dk_echo "compiling ..."
	if exist "%_app_exe_%" (%dk_call% dk_delete "%_app_exe_%")

	%dk_call% dk_debug "COMPILER_EXE = %COMPILER_EXE%"
	set "COMPILE_COMMAND=%COMPILER_EXE% -o %_app_exe_% -static %_c_file_%"
	echo %COMPILE_COMMAND%
	%COMPILE_COMMAND%

	if NOT exist "%_app_exe_%" (
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

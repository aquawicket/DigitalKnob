@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_callDKC(function, arguments...)
::# dk_callDKC(function, arguments..., rtn_var)
::#
::#
:dk_callDKC
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 1 99
 
	::###### DEFAULT ENVIRONMENT ######
	:: clang, cosmocc, gcc, msvc 
	set "default_target_os=cosmocc"
	set "default_target_arch=cosmocc"
	set "default_target_env=cosmocc"

	::###### _func_ ######
	set "_func_=%~1"

	::###### _args_ ######
	set _args_=%*
	if defined _args_ (set _args_=!_args_:%~1 =!)

	::###### _last_arg_ ######
	for %%a in (%*) do set _last_arg_=%%a

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

	::###### target_os ######
	if not defined target_os (set "target_os=%default_target_os%")
	%dk_call% dk_debug "target_os = %target_os%"

	::###### target_arch ######
	if not defined target_arch (set "target_arch=%default_target_arch%")
	%dk_call% dk_debug "target_arch = %target_arch%"

	::###### target_env ######
	if not defined target_env (set "target_env=%default_target_env%")
	%dk_call% dk_debug "target_env = %target_env%"

	::###### COMPILER_EXE ######
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	if "%target_env%" equ "cosmocc" (
		%dk_call% dk_validate SH_EXE				"%dk_call% %DKIMPORTS_DIR%/sh/DKINSTALL.cmd"
		%dk_call% dk_validate COSMOCC_C_COMPILER	"%dk_call% %DKIMPORTS_DIR%/cosmocc/DKINSTALL.cmd"
		%dk_call% dk_assertPath COSMOCC_C_COMPILER
		set "COMPILER_EXE=!SH_EXE! !COSMOCC_C_COMPILER!"
	)

	if "%target_env%" equ "clang" (
		%dk_call% dk_validate CLANG_C_COMPILER		"%dk_call% %DKIMPORTS_DIR%/clang/DKINSTALL.cmd"
		%dk_call% dk_assertPath CLANG_C_COMPILER
		set "COMPILER_EXE=!CLANG_C_COMPILER!"
	)
	if "%target_env%" equ "gcc" (
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

	::###### run executable ######
	%dk_call% dk_exec %_app_exe_% %_args_%
	endlocal & (
		set "dk_callDKC=%dk_exec%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKC dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKC = %dk_callDKC%"
%endfunction%

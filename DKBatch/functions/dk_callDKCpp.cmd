@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_callDKCpp(function, arguments...)
::# dk_callDKCpp(function, arguments..., rtn_var)
::#
::#
:dk_callDKCpp
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 1 99

	::###### DEFAULT ENVIRONMENT ######
	:: clang, cosmocc, gcc, msvc 
	set "default_target_os=%host_os%"
	set "default_target_arch=%host_arch%"
	set "default_target_env=clang"

	::###### _func_ ######
	set "_func_=%~1"

	::###### _args_ ######
	set _args_=%*
	if defined _args_ (set _args_=!_args_:%~1 =!)

	::###### _last_arg_ ######
	for %%a in (%*) do set _last_arg_=%%a

	::###### DKC_FUNCTIONS_DIR ######
	%dk_call% dk_validate DKCPP_FUNCTIONS_DIR  "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_assertPath DKCPP_FUNCTIONS_DIR

	::###### DKHTTP_DKC_FUNCTIONS_DIR ######
	%dk_call% dk_assertVar DKHTTP_DKBRANCH_DIR
	if not defined DKHTTP_DKCPP_DIR		 	 (set "DKHTTP_DKCPP_DIR=%DKHTTP_DKBRANCH_DIR%/DKC")
	if not defined DKHTTP_DKCPP_FUNCTIONS_DIR  (set "DKHTTP_DKCPP_FUNCTIONS_DIR=%DKHTTP_DKCPP_DIR%/functions")

	::###### Download files if missing ######
	if not exist %DKCPP_FUNCTIONS_DIR%/DK.hpp	(%dk_call% dk_download "%DKHTTP_DKCPP_FUNCTIONS_DIR%/DK.hpp" "%DKCPP_FUNCTIONS_DIR%/DK.hpp")
	if not exist %DKCPP_FUNCTIONS_DIR%/%~1.cpp   (%dk_call% dk_download "%DKHTTP_DKCPP_FUNCTIONS_DIR%/%~1.cpp" "%DKCPP_FUNCTIONS_DIR%/%~1.cpp")

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

	::###### _c_file_ ######
	set "_cpp_file_=%DKCPP_FUNCTIONS_DIR%/%_func_%.cpp"
	%dk_call% dk_assertPath _cpp_file_

	::###### DKC_BUILD_DIR ######
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	set "DKCPP_BUILD_DIR=%DKCACHE_DIR%/DKCPP_BUILD_DIR"
	if not exist "%DKCPP_BUILD_DIR%" (%dk_call% dk_makeDirectory "%DKCPP_BUILD_DIR%")

	::###### _app_exe_ ######
	set "_app_exe_=%DKCPP_BUILD_DIR%/%_func_%.exe"

	::###### Compile Code ######
	%dk_call% dk_echo "compiling ..."
	if exist "%_app_exe_%" (%dk_call% dk_delete "%_app_exe_%")

	%dk_call% dk_debug "COMPILER_EXE = %COMPILER_EXE%"
	set "COMPILE_COMMAND=%COMPILER_EXE% -o %_app_exe_% -static %_cpp_file_%"
	echo %COMPILE_COMMAND%
	%COMPILE_COMMAND%

	if not exist "%_app_exe_%" (
		%dk_call% dk_echo
		%dk_call% dk_error "failed to compile %_cpp_file_%"
		%return%
	)

	::###### run executable ######
	%dk_call% dk_commandToVariable %_app_exe_% %_args_%
	endlocal & (
		set "dk_callDKCpp=%dk_commandToVariable%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKCpp dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKCpp = %dk_callDKCpp%"
%endfunction%

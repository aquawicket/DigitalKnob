@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_callDKCpp(function, arguments...)
::# dk_callDKCpp(function, arguments..., rtn_var)
::#
::#
dk_callDKCSharp
%setlocal%
	%dk_call% dk_debugFunc 1 99
 
	::###### TODO ######
	dk_todo("dk_callDKCSharp")
 
 
	::###### DEFAULT ENVIRONMENT ######
	:: clang, cosmocc, gcc, msvc 
	set "default_Target_Os=%Host_Os%"
	set "default_Target_Arch=%Host_Arch%"
	set "default_Target_Env=csc"

	::###### _func_ ######
	set "_func_=%~1"

	::### All but first Args ###
	%dk_call% dk_allButFirstArgs %*

	::###### DKC_FUNCTIONS_DIR ######
	%dk_call% dk_validate DKCSHARP_FUNCTIONS_DIR  "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_assertPath DKCSHARP_FUNCTIONS_DIR

	::###### DKHTTP_DKC_FUNCTIONS_DIR ######
	%dk_call% dk_assertVar DKHTTP_DKBRANCH_DIR
	if not defined DKHTTP_DKCSHARP_DIR		 	 (set "DKHTTP_DKCSHARP_DIR=%DKHTTP_DKBRANCH_DIR%/DKC")
	if not defined DKHTTP_DKCSHARP_FUNCTIONS_DIR  (set "DKHTTP_DKCSHARP_FUNCTIONS_DIR=%DKHTTP_DKCSHARP_DIR%/functions")

	::###### Download files if missing ######
	if not exist %DKCSHARP_FUNCTIONS_DIR%/DK.cs	(%dk_call% dk_download "%DKHTTP_DKCSHARP_FUNCTIONS_DIR%/DK.cs" "%DKCSHARP_FUNCTIONS_DIR%/DK.cs")
	if not exist %DKCSHARP_FUNCTIONS_DIR%/%~1.cs   (%dk_call% dk_download "%DKHTTP_DKCSHARP_FUNCTIONS_DIR%/%~1.cs" "%DKCSHARP_FUNCTIONS_DIR%/%~1.cs")

	::###### Target_Os ######
	if not defined Target_Os (set "Target_Os=%default_Target_Os%")
	%dk_call% dk_debug "Target_Os = %Target_Os%"

	::###### Target_Arch ######
	if not defined Target_Arch (set "Target_Arch=%default_Target_Arch%")
	%dk_call% dk_debug "Target_Arch = %Target_Arch%"

	::###### Target_Env ######
	if not defined Target_Env (set "Target_Env=%default_Target_Env%")
	%dk_call% dk_debug "Target_Env = %Target_Env%"

	::###### CSC_EXE ######
	:: TODO:  note, reference DKINSTALL.cmd for how to call DKCSharp methods from batch script

	::###### _c_file_ ######
	set "_csharp_file_=%DKCSHARP_FUNCTIONS_DIR%/%_func_%.cs"
	%dk_call% dk_assertPath _csharp_file_

	::###### DKC_BUILD_DIR ######
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	set "DKCSHARP_BUILD_DIR=%DKCACHE_DIR%/DKCSHARP_BUILD_DIR"
	if not exist "%DKCSHARP_BUILD_DIR%" (%dk_call% dk_mkdir "%DKCSHARP_BUILD_DIR%")

	::###### _app_exe_ ######
	set "_app_exe_=%DKCSHARP_BUILD_DIR%/%_func_%.exe"

	::###### Compile Code ######
	%dk_call% dk_echo "compiling ..."
	if exist "%_app_exe_%" (%dk_call% dk_delete "%_app_exe_%")

	%dk_call% dk_debug "COMPILER_EXE = %COMPILER_EXE%"
	set "COMPILE_COMMAND=%COMPILER_EXE% -o %_app_exe_% -static %_csharp_file_%"
	echo %COMPILE_COMMAND%
	%COMPILE_COMMAND%

	if not exist "%_app_exe_%" (
		%dk_call% dk_echo
		%dk_call% dk_error "failed to compile %_csharp_file_%"
		%return%
	)

	::###### run executable ######
	set DKCOMMAND=%_app_exe_% %dk_allButFirstArgs%
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_callDKCpp=%dk_exec%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKCpp dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKCpp = %dk_callDKCpp%"
%endfunction%

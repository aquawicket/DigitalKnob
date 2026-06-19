@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ####################################################################
rem # dk_callDKCpp(function, arguments...)
rem # dk_callDKCpp(function, arguments..., rtn_var)
rem #
rem #
dk_callDKCSharp
%setlocal%


	rem ###### DEFAULT ENVIRONMENT ######
	rem clang, cosmocc, gcc, msvc
	set "default_Target_Os=%Host_Os%"
	set "default_Target_Arch=%Host_Arch%"
	set "default_Target_Env=csc"

	rem ###### _func_ ######
	set "_func_=%~1"

	rem ### All but first Args ###
	%dk_call% dk_allButFirstArgs %*

	rem ###### DKC_FUNCTIONS_DIR ######
	%dk_call% dk_validate DKCSHARP_FUNCTIONS_DIR  %dk_call% dk_DKBRANCH_DIR
	%dk_call% dk_assertPath DKCSHARP_FUNCTIONS_DIR

	rem ###### DKHTTP_DKC_FUNCTIONS_DIR ######
	%dk_call% dk_assertVar DKHTTP_DKBRANCH_DIR
	if NOT defined DKHTTP_DKCSHARP_DIR		 	 (set "DKHTTP_DKCSHARP_DIR=%DKHTTP_DKBRANCH_DIR%/DKC")
	if NOT defined DKHTTP_DKCSHARP_FUNCTIONS_DIR  (set "DKHTTP_DKCSHARP_FUNCTIONS_DIR=%DKHTTP_DKCSHARP_DIR%/functions")

	rem ###### Download files if missing ######
	if NOT EXIST "%DKCSHARP_FUNCTIONS_DIR%/DK.cs"	(%dk_call% dk_download "%DKHTTP_DKCSHARP_FUNCTIONS_DIR%/DK.cs" "%DKCSHARP_FUNCTIONS_DIR%/DK.cs")
	if NOT EXIST "%DKCSHARP_FUNCTIONS_DIR%/%~1.cs"	(%dk_call% dk_download "%DKHTTP_DKCSHARP_FUNCTIONS_DIR%/%~1.cs" "%DKCSHARP_FUNCTIONS_DIR%/%~1.cs")

	rem ###### Target_Os ######
	if NOT defined Target_Os (set "Target_Os=%default_Target_Os%")
	%dk_call% dk_debug "Target_Os = %Target_Os%"

	rem ###### Target_Arch ######
	if NOT defined Target_Arch (set "Target_Arch=%default_Target_Arch%")
	%dk_call% dk_debug "Target_Arch = %Target_Arch%"

	rem ###### Target_Env ######
	if NOT defined Target_Env (set "Target_Env=%default_Target_Env%")
	%dk_call% dk_debug "Target_Env = %Target_Env%"

	rem ###### csc_exe ######
	rem TODO:  note, reference DKINSTALL.cmd for how to call DKCSharp methods from batch script

	rem ###### _c_file_ ######
	set "_csharp_file_=%DKCSHARP_FUNCTIONS_DIR%/%_func_%.cs"
	%dk_call% dk_assertPath _csharp_file_

	rem ###### DKC_BUILD_DIR ######
	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
	set "DKCSHARP_BUILD_DIR=%DKCACHE_DIR%/DKCSHARP_BUILD_DIR"
	%dk_call% dk_mkdir "%DKCSHARP_BUILD_DIR%"

	rem ###### _app_exe_ ######
	set "_app_exe_=%DKCSHARP_BUILD_DIR%/%_func_%.exe"

	rem ###### Compile Code ######
	%dk_call% dk_echo "compiling ..."
	if EXIST "%_app_exe_%" (%dk_call% dk_delete "%_app_exe_%")

	%dk_call% dk_debug "COMPILER_EXE = %COMPILER_EXE%"
	set "COMPILE_COMMAND=%COMPILER_EXE% -o %_app_exe_% -static %_csharp_file_%"
	echo %COMPILE_COMMAND%
	%COMPILE_COMMAND%

	if NOT EXIST "%_app_exe_%" (
		%dk_call% dk_echo
		%dk_call% dk_error "failed to compile %_csharp_file_%"
		%return%
	)

	rem ###### run executable ######
	set DKCOMMAND=%_app_exe_% %dk_allButFirstArgs%
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_callDKCpp=%dk_exec%"
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_callDKCpp dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKCpp = %dk_callDKCpp%"
%endfunction%

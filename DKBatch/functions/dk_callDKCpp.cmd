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


rem ################## dk_callDKCpp settings ###########################
rem if NOT defined dk_callDKCpp_Target_Os 	(set "dk_callDKC_Target_Os=Cosmocc")	&rem  Android, Cosmocc, Emscripten, Ios, Iossim, Linux, Mac, Windows
rem if NOT defined dk_callDKCpp_Target_Arch 	(set "dk_callDKC_Target_Arch=Cosmocc")	&rem  Arm32, Arm64, Cosmocc, X86, X86_64
rem if NOT defined dk_callDKCpp_TARGET_ENV 	(set "dk_callDKC_TARGET_ENV=Cosmocc")	&rem  Clang, Cosmocc, Gcc, Msvc
rem ####################################################################
rem # dk_callDKCpp(function, arguments...)
rem # dk_callDKCpp(function, arguments..., rtn_var)
rem #
rem #
:dk_callDKCpp
%setlocal%

	rem ###### _func_ ######
	set "_func_=%~1"

	rem ### All but first Args ###
	%dk_call% dk_allButFirstArgs %*

	rem ###### DKC_FUNCTIONS_DIR ######
	%dk_call% dk_validate DKCPP_FUNCTIONS_DIR	%dk_call% dk_DKBRANCH_DIR
	%dk_call% dk_assertPath DKCPP_FUNCTIONS_DIR

	rem ###### DKHTTP_DKC_FUNCTIONS_DIR ######
	%dk_call% dk_assertVar DKHTTP_DKBRANCH_DIR
	if NOT defined DKHTTP_DKCPP_DIR				(set "DKHTTP_DKCPP_DIR=%DKHTTP_DKBRANCH_DIR%/DKC")
	if NOT defined DKHTTP_DKCPP_FUNCTIONS_DIR	(set "DKHTTP_DKCPP_FUNCTIONS_DIR=%DKHTTP_DKCPP_DIR%/functions")

	rem ###### Download files if missing ######
	if NOT EXIST "%DKCPP_FUNCTIONS_DIR%/DK.hpp"	(%dk_call% dk_download "%DKHTTP_DKCPP_FUNCTIONS_DIR%/DK.hpp" "%DKCPP_FUNCTIONS_DIR%/DK.hpp")
	if NOT EXIST "%DKCPP_FUNCTIONS_DIR%/%~1.cpp"	(%dk_call% dk_download "%DKHTTP_DKCPP_FUNCTIONS_DIR%/%~1.cpp" "%DKCPP_FUNCTIONS_DIR%/%~1.cpp")

	rem ###### Target_Os ######
	if NOT defined Target_Os 					(set "Target_Os=%dk_callDKCpp_Target_Os%")
	%dk_call% dk_debug "Target_Os = %Target_Os%"

	rem ###### Target_Arch ######
	if NOT defined Target_Arch 					(set "Target_Arch=%dk_callDKCpp_Target_Arch%")
	%dk_call% dk_debug "Target_Arch = %Target_Arch%"

	rem ###### Target_Env ######
	if NOT defined Target_Env 					(set "Target_Env=%dk_callDKCpp_TARGET_ENV%")
	%dk_call% dk_debug "Target_Env = %Target_Env%"

	rem ###### COMPILER_EXE ######
	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	if /i "%Target_Env%" equ "cosmocc" (
		%dk_call% dk_validate sh_exe		%dk_call% dk_depend sh_exe
		%dk_call% dk_validate cosmoc++_exe	%dk_call% dk_depend cosmocc
		%dk_call% dk_assertPath cosmoc++_exe
		set "COMPILER_EXE=!sh_exe! !cosmoc++_exe!"
	)

	if /i "%Target_Env%" equ "clang" (
		%dk_call% dk_validate clang++_exe		%dk_call% dk_depend clang
		%dk_call% dk_assertPath clang++_exe
		set "COMPILER_EXE=!clang++_exe!"
	)
	if /i "%Target_Env%" equ "gcc" (
		%dk_call% dk_validate gcc_exe			%dk_call% dk_depend gcc
		%dk_call% dk_assertPath gcc_exe
		set "COMPILER_EXE=!gcc_exe!"
	)

	rem ###### _c_file_ ######
	set "_cpp_file_=%DKCPP_FUNCTIONS_DIR%/%_func_%.cpp"
	%dk_call% dk_assertPath _cpp_file_

	rem ###### DKC_BUILD_DIR ######
	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
	set "DKCPP_BUILD_DIR=%DKCACHE_DIR%/DKCPP_BUILD_DIR"
	%dk_call% dk_mkdir "%DKCPP_BUILD_DIR%"

	rem ###### _app_exe_ ######
	set "_app_exe_=%DKCPP_BUILD_DIR%/%_func_%.exe"

	rem ###### Compile Code ######
	%dk_call% dk_echo "compiling ..."
	if EXIST "%_app_exe_%" (%dk_call% dk_delete "%_app_exe_%")

	%dk_call% dk_debug "COMPILER_EXE = %COMPILER_EXE%"
	set "COMPILE_COMMAND=%COMPILER_EXE% -o %_app_exe_% -static %_cpp_file_%"
	echo %COMPILE_COMMAND%
	%COMPILE_COMMAND%

	if NOT EXIST "%_app_exe_%" (
		%dk_call% dk_echo
		%dk_call% dk_error "failed to compile %_cpp_file_%"
		%return%
	)

	rem ############ DKCpp function call ############
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

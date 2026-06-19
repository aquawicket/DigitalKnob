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


rem ################## dk_callDKC settings #############################
rem if NOT defined dk_callDKC_Target_Os 	(set "dk_callDKC_Target_Os=%Host_Os%")		&rem  Android, Cosmo, Emscripten, Ios, Iossim, Linux, Mac, Win
rem if NOT defined dk_callDKC_Target_Arch (set "dk_callDKC_Target_Arch=%Host_Arch%")	&rem  Arm32, Arm64, Cosmo, X86, X86_64
rem if NOT defined dk_callDKC_Target_Env 	(set "dk_callDKC_Target_Env=Clang")			&rem  Clang, Cosmo, Gcc, Msvc
rem ####################################################################
rem # dk_callDKC(function, arguments...)
rem # dk_callDKC(function, arguments..., rtn_var)
rem #
rem #
:dk_callDKC
%setlocal%

	rem ###### _func_ ######
	set "_func_=%~1"
	set "_path_=%DKC_FUNCTIONS_DIR:\=/%/%_func_%.c"

	rem ### All but first Args ###
	%dk_call% dk_allButFirstArgs %*

	rem ###### DKC_FUNCTIONS_DIR ######
	%dk_call% dk_validate DKC_FUNCTIONS_DIR  %dk_call% dk_DKBRANCH_DIR
	%dk_call% dk_assertPath DKC_FUNCTIONS_DIR

	rem ###### DKHTTP_DKC_FUNCTIONS_DIR ######
	%dk_call% dk_assertVar DKHTTP_DKBRANCH_DIR
	if NOT defined DKHTTP_DKC_DIR		 		(set "DKHTTP_DKC_DIR=%DKHTTP_DKBRANCH_DIR%/DKC")
	if NOT defined DKHTTP_DKC_FUNCTIONS_DIR		(set "DKHTTP_DKC_FUNCTIONS_DIR=%DKHTTP_DKC_DIR%/functions")

	rem ###### Download files if missing ######
	if NOT EXIST "%DKC_FUNCTIONS_DIR%/DK.h"	(%dk_call% dk_download "%DKHTTP_DKC_FUNCTIONS_DIR%/DK.h" "%DKC_FUNCTIONS_DIR%/DK.h")
	if NOT EXIST "%DKC_FUNCTIONS_DIR%/%~1.c"	(%dk_call% dk_download "%DKHTTP_DKC_FUNCTIONS_DIR%/%~1.c" "%DKC_FUNCTIONS_DIR%/%~1.c")

	rem ###### Target_Os ######
	if NOT defined Target_Os (
		if NOT defined dk_callDKC_Target_Os (
			%dk_call% dk_validate Host_Os %dk_call% dk_Host_Os
			set "dk_callDKC_Target_Os=!Host_Os!"
		)
		set "Target_Os=!dk_callDKC_Target_Os!"
	)
	%dk_call% dk_debug "Target_Os = %Target_Os%"

	rem ###### Target_Arch ######
	if NOT defined Target_Arch (
		if NOT defined dk_callDKC_Target_Arch (
			%dk_call% dk_validate Host_Arch %dk_call% dk_Host_Arch
			set "dk_callDKC_Target_Arch=!Host_Arch!"
		)
		set "Target_Arch=!dk_callDKC_Target_Arch!"
	)
	%dk_call% dk_debug "Target_Arch = %Target_Arch%"

	rem ###### Target_Env ######
	if NOT defined Target_Env (
		if NOT defined dk_callDKC_Target_Env (
			set "dk_callDKC_Target_Env=Clang"
		)
		set "Target_Env=!dk_callDKC_Target_Env!"
	)
	%dk_call% dk_debug "Target_Env = %Target_Env%"

	rem ###### Target_Tuple ######
	if NOT defined Target_Tuple (
		set "Target_Tuple=%Target_Os%_%Target_Arch%_%Target_Env%"
	)
	%dk_call% dk_debug "Target_Tuple = %Target_Tuple%"
	
	rem ###### COMPILER_EXE ######
	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	if /i "%Target_Env%" equ "Cosmo" (
		%dk_call% dk_validate sh_exe		%dk_call% dk_depend sh_exe
		%dk_call% dk_validate cosmocc_exe	%dk_call% dk_depend Cosmo
		%dk_call% dk_assertPath cosmocc_exe
		set "COMPILER_EXE=!sh_exe! !cosmocc_exe!"
	)

	if /i "%Target_Env%" equ "Clang" (
		%dk_call% dk_validate clang_exe		%dk_call% dk_depend clang
		%dk_call% dk_assertPath clang_exe
		set "COMPILER_EXE=!clang_exe!"
	)
	if /i "%Target_Env%" equ "Gcc" (
		%dk_call% dk_validate gcc_exe		%dk_call% dk_depend Gcc
		%dk_call% dk_assertPath gcc_exe
		set "COMPILER_EXE=!gcc_exe!"
	)

rem	###### _path_ ######
rem	set "_path_=%DKC_FUNCTIONS_DIR%/%_func_%.c"
rem	%dk_call% dk_assertPath _path_

	rem ###### DKC_BUILD_DIR ######
	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
	set "DKC_BUILD_DIR=%DKCACHE_DIR%/DKC_BUILD_DIR"
	%dk_call% dk_mkdir "%DKC_BUILD_DIR%"

	rem ###### _app_exe_ ######
	set "_app_exe_=%DKC_BUILD_DIR%/%_func_%.exe"

	rem ###### Compile Code ######
	%dk_call% dk_echo "compiling ..."
	if EXIST "%_app_exe_%" (%dk_call% dk_delete "%_app_exe_%")

	%dk_call% dk_debug "COMPILER_EXE = %COMPILER_EXE%"
	set "COMPILE_COMMAND=%COMPILER_EXE% -o %_app_exe_% -static %_path_%"
	echo %COMPILE_COMMAND%
	%COMPILE_COMMAND%

	if NOT EXIST "%_app_exe_%" (
		%dk_call% dk_echo
		%dk_call% dk_error "failed to compile %_path_%"
		%return%
	)

	rem ############ DKC function call ############
	set DKCOMMAND=%_app_exe_% %dk_allButFirstArgs%
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_callDKC=%dk_exec%"
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_callDKC dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKC = %dk_callDKC%"
%endfunction%

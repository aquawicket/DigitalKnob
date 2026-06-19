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


rem ######################## dk_evalDKC settings ########################
if NOT defined dk_evalDKC_Default_Target_Env (set "dk_evalDKC_Default_Target_Env=clang")
rem #####################################################################
rem # dk_evalDKC(<code>)
rem #
rem #
:dk_evalDKC
%setlocal%

	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
	rem echo %~1 > "%DKCACHE_DIR%/dk_evalDKC_TEMP.c"
	
	rem ###### DKC_BUILD_DIR ######
	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
	set "DKC_BUILD_DIR=%DKCACHE_DIR%/DKC_BUILD_DIR"
	%dk_call% dk_mkdir "%DKC_BUILD_DIR%"
	
	rem ###### _exe_ ######
	set "_exe_=%DKC_BUILD_DIR%/dk_evalDKC_TEMP.exe"
	
	rem ###### _code_ ######
	set "_code_=%~1"

	rem ### All but first Args ###
	%dk_call% dk_allButFirstArgs %*

rem	rem ###### DKC_FUNCTIONS_DIR ######
rem	%dk_call% dk_validate DKC_FUNCTIONS_DIR  %dk_call% dk_DKBRANCH_DIR
rem	%dk_call% dk_assertPath DKC_FUNCTIONS_DIR
rem 
rem	rem ###### DKHTTP_DKC_FUNCTIONS_DIR ######
rem	%dk_call% dk_assertVar DKHTTP_DKBRANCH_DIR
rem	if NOT defined DKHTTP_DKC_DIR		 		(set "DKHTTP_DKC_DIR=%DKHTTP_DKBRANCH_DIR%/DKC")
rem	if NOT defined DKHTTP_DKC_FUNCTIONS_DIR		(set "DKHTTP_DKC_FUNCTIONS_DIR=%DKHTTP_DKC_DIR%/functions")
rem 
rem	rem ###### Download files if missing ######
rem	if NOT EXIST "%DKC_FUNCTIONS_DIR%/DK.h"	(%dk_call% dk_download "%DKHTTP_DKC_FUNCTIONS_DIR%/DK.h" "%DKC_FUNCTIONS_DIR%/DK.h")
rem	::if NOT EXIST "%DKC_FUNCTIONS_DIR%/%~1.c"	(%dk_call% dk_download "%DKHTTP_DKC_FUNCTIONS_DIR%/%~1.c" "%DKC_FUNCTIONS_DIR%/%~1.c")

	if NOT defined Host_Tuple						(%dk_call% dk_Host_Tuple)
	if NOT defined dk_evalDKC_Default_Target_Os		(set "dk_evalDKC_Default_Target_Os=%Host_Os%")
	if NOT defined dk_evalDKC_Default_Target_Arch	(set "dk_evalDKC_Default_Target_Arch=%Host_Arch%")
	
	rem ###### Target_Os ######
	if NOT defined Target_Os (set "Target_Os=%dk_evalDKC_DEFAULT_TARGET_OS%")
	%dk_call% dk_debug "Target_Os = %Target_Os%"

	rem ###### Target_Arch ######
	if NOT defined Target_Arch (set "Target_Arch=%dk_evalDKC_Default_Target_Arch%")
	%dk_call% dk_debug "Target_Arch = %Target_Arch%"

	rem ###### Target_Env ######
	if NOT defined Target_Env (set "Target_Env=%dk_evalDKC_Default_Target_Env%")
	%dk_call% dk_debug "Target_Env = %Target_Env%"
	
	if /i "%Target_Env%" equ "cosmocc" (
		set "Target_Os=cosmocc"
		set "Target_Arch=cosmocc"
	)
	
	if NOT defined Target_Tuple (set "Target_Tuple=%Target_Os%_%Target_Arch%_%Target_Env%")

	rem ###### COMPILER_EXE ######
	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	if /i "%Target_Env%" equ "cosmocc" (
		%dk_call% dk_validate sh_exe		%dk_call% dk_depend sh_exe
		%dk_call% dk_validate cosmocc_exe	%dk_call% dk_depend cosmocc
		%dk_call% dk_assertPath cosmocc_exe
		set "COMPILER_EXE=!sh_exe! !cosmocc_exe!"
	)

	if /i "%Target_Env%" equ "clang" (
		%dk_call% dk_validate clang_exe		%dk_call% dk_depend clang
		%dk_call% dk_assertPath clang_exe
		set "COMPILER_EXE=!clang_exe!"
	)
	if /i "%Target_Env%" equ "gcc" (
		%dk_call% dk_validate gcc_exe		%dk_call% dk_depend gcc
		%dk_call% dk_assertPath gcc_exe
		set "COMPILER_EXE=!gcc_exe!"
	)
	%dk_call% dk_debug "COMPILER_EXE = %COMPILER_EXE%"

	rem ###### _c_file_ ######
	set "_c_file_=%DKCACHE_DIR%/dk_evalDKC_TEMP.c"
	%dk_call% dk_assertPath _c_file_

	rem ###### COMPILE_COMMAND ######
	%dk_call% dk_echo "compiling ..."
	if EXIST "%_exe_%" (%dk_call% dk_delete "%_exe_%")

	set "COMPILE_COMMAND=%COMPILER_EXE% -o %_exe_% -static %_c_file_%"
	echo %COMPILE_COMMAND%
	%COMPILE_COMMAND%

	if NOT EXIST "%_exe_%" (
		echo.
		%dk_call% dk_error "failed to compile %_c_file_%"
		%return%
	)

	rem ############ DKCOMMAND ############
	set DKCOMMAND=%_exe_% &rem %dk_allButFirstArgs%
	
	rem echo %dk_call% dk_exec %DKCOMMAND%
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_evalDKC=%dk_exec%"
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_evalDKC "printf("test dk_evalDKC");"
	
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_evalDKC = %dk_evalDKC%"
%endfunction%

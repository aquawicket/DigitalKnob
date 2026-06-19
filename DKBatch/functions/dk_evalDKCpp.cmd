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


rem ######################## dk_evalDKCpp settings ######################
if NOT defined dk_evalDKCpp_Default_Target_Os	(set "dk_evalDKCpp_Default_Target_Os=cosmocc")
if NOT defined dk_evalDKCpp_Default_Target_Arch	(set "dk_evalDKCpp_Default_Target_Arch=cosmocc")
if NOT defined dk_evalDKCpp_Default_Target_Env	(set "dk_evalDKCpp_Default_Target_Env=cosmocc")	&rem clang, cosmocc, gcc, msvc
rem #####################################################################
rem # dk_evalDKCpp(<code>)
rem #
rem #
:dk_evalDKCpp
%setlocal%

	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
	rem echo %~1 > "%DKCACHE_DIR%/dk_evalDKCpp_TEMP.cpp"
	
	rem ###### DKCPP_BUILD_DIR ######
	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
	set "DKCPP_BUILD_DIR=%DKCACHE_DIR%/DKCPP_BUILD_DIR"
	%dk_call% dk_mkdir "%DKCPP_BUILD_DIR%"
	
	rem ###### _exe_ ######
	set "_exe_=%DKCPP_BUILD_DIR%/dk_evalDKCpp_TEMP.exe"
	
	rem ###### _code_ ######
	set "_code_=%~1"

	rem ### All but first Args ###
	%dk_call% dk_allButFirstArgs %*

rem	rem ###### DKCPP_FUNCTIONS_DIR ######
rem	%dk_call% dk_validate DKCPP_FUNCTIONS_DIR  %dk_call% dk_DKBRANCH_DIR
rem	%dk_call% dk_assertPath DKCPP_FUNCTIONS_DIR
rem 
rem	rem ###### DKHTTP_DKCPP_FUNCTIONS_DIR ######
rem	%dk_call% dk_assertVar DKHTTP_DKBRANCH_DIR
rem	if NOT defined DKHTTP_DKCPP_DIR		 		(set "DKHTTP_DKCPP_DIR=%DKHTTP_DKBRANCH_DIR%/DKC")
rem	if NOT defined DKHTTP_DKCPP_FUNCTIONS_DIR		(set "DKHTTP_DKCPP_FUNCTIONS_DIR=%DKHTTP_DKCPP_DIR%/functions")
rem 
rem	rem ###### Download files if missing ######
rem	if NOT EXIST "%DKCPP_FUNCTIONS_DIR%/DK.h"		(%dk_call% dk_download "%DKHTTP_DKCPP_FUNCTIONS_DIR%/DK.h" "%DKCPP_FUNCTIONS_DIR%/DK.h")
rem	::if NOT EXIST "%DKCPP_FUNCTIONS_DIR%/%~1.cpp"	(%dk_call% dk_download "%DKHTTP_DKCPP_FUNCTIONS_DIR%/%~1.cpp" "%DKCPP_FUNCTIONS_DIR%/%~1.cpp")

	rem ###### Target_Os ######
	if NOT defined Target_Os (set "Target_Os=%dk_evalDKCpp_Default_Target_Os%")
	%dk_call% dk_debug "Target_Os = %Target_Os%"

	rem ###### Target_Arch ######
	if NOT defined Target_Arch (set "Target_Arch=%dk_evalDKCpp_Default_Target_Arch%")
	%dk_call% dk_debug "Target_Arch = %Target_Arch%"

	rem ###### Target_Env ######
	if NOT defined Target_Env (set "Target_Env=%dk_evalDKCpp_Default_Target_Env%")
	%dk_call% dk_debug "Target_Env = %Target_Env%"

	rem ###### COMPILER_EXE ######
	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	if /i "%Target_Env%" equ "cosmocc" (
		%dk_call% dk_validate sh_exe				%dk_call% dk_depend sh_exe
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
		%dk_call% dk_validate gcc_exe		%dk_call% dk_depend gcc
		%dk_call% dk_assertPath gcc_exe
		set "COMPILER_EXE=!gcc_exe!"
	)
	%dk_call% dk_debug "COMPILER_EXE = %COMPILER_EXE%"

	rem ###### _cpp_file_ ######
	set "_cpp_file_=%DKCACHE_DIR%/dk_evalDKCpp_TEMP.cpp"
	%dk_call% dk_assertPath _cpp_file_

	rem ###### COMPILE_COMMAND ######
	%dk_call% dk_echo "compiling ..."
	if EXIST "%_exe_%" (%dk_call% dk_delete "%_exe_%")

	set "COMPILE_COMMAND=%COMPILER_EXE% -o %_exe_% -static %_cpp_file_%"
	echo %COMPILE_COMMAND%
	%COMPILE_COMMAND%

	if NOT EXIST "%_exe_%" (
		echo.
		%dk_call% dk_error "failed to compile %_cpp_file_%"
		%return%
	)

	rem ############ DKCOMMAND ############
	set DKCOMMAND=%_exe_% &rem %dk_allButFirstArgs%
	
	rem :echo %dk_call% dk_exec %DKCOMMAND%
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_evalDKCpp=%dk_exec%"
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_evalDKCpp "printf("test dk_evalDKCpp");"
	
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_evalDKCpp = %dk_evalDKCpp%"
%endfunction%

@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_callDKC(function, arguments..., rtn_var)
::#
::#
:dk_callDKC
setlocal
    %dk_call% dk_debugFunc 1 99
 
	::### Get DKC_FUNCTIONS_DIR
	%dk_call% dk_validate DKC_FUNCTIONS_DIR  "%dk_call% dk_DKBRANCH_DIR"
	if not exist "%DKC_FUNCTIONS_DIR%"       (set "DKC_FUNCTIONS_DIR=%CD%/DKC/functions")
	if not exist "%DKC_FUNCTIONS_DIR%"       (mkdir "%DKC_FUNCTIONS_DIR%")
	%dk_call% dk_assertPath DKC_FUNCTIONS_DIR
	
	::### Get DKHTTP_DKC_FUNCTIONS_DIR
	if not defined DKHTTP_DKC_DIR         	 (set "DKHTTP_DKC_DIR=%DKHTTP_DKBRANCH_DIR%/DKC")
	if not defined DKHTTP_DKC_FUNCTIONS_DIR  (set "DKHTTP_DKC_FUNCTIONS_DIR=%DKHTTP_DKC_DIR%/functions")
	
	::### Download files if missing
	if not exist %DKC_FUNCTIONS_DIR%/DK.h    (%dk_call% dk_download "%DKHTTP_DKC_FUNCTIONS_DIR%/DK.h" "%DKC_FUNCTIONS_DIR%/DK.h")
	if not exist %DKC_FUNCTIONS_DIR%/%~1.c   (%dk_call% dk_download "%DKHTTP_DKC_FUNCTIONS_DIR%/%~1.c" "%DKC_FUNCTIONS_DIR%/%~1.c")

::	set ALL_BUT_FIRST=%*
::	if defined ALL_BUT_FIRST (set ALL_BUT_FIRST=!ALL_BUT_FIRST:*%1=!)
	
    :: get LAST_ARG
::	for %%a in (%*) do set LAST_ARG=%%a
    
::	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"
::    set "DKSCRIPT_PATH=%DKSCRIPT_PATH:C:=/c%"
	
::	set "DKC_FUNCTIONS_DIR=%DKC_FUNCTIONS_DIR:\=/%"
::    set "DKC_FUNCTIONS_DIR=%DKC_FUNCTIONS_DIR:C:=/c%"

::    set "DKC_FUNCTIONS_DIR_=%DKC_FUNCTIONS_DIR_:\=/%"
::    set "DKC_FUNCTIONS_DIR_=%DKC_FUNCTIONS_DIR_:C:=/c%"
	

	::###### DEFAULT ENVIRONMENT ######
	:: clang, cosmocc, gcc, msvc 
	set "default_target_os=cosmocc"
	set "default_target_arch=cosmocc"
	set "default_target_env=cosmocc"
	
	::###### Install DKC ######
::	%dk_call% dk_echo "Installing DKC . . ."
	
	::###### target_os ######
	::%dk_call% dk_validate host_os "%dk_call% dk_host_triple"
	::if not defined target_os set "target_os=%host_os%"
	set "target_os=%default_target_os%"
	%dk_call% dk_printVar target_os
	
	::###### target_arch ######
	::%dk_call% dk_validate host_arch "%dk_call% dk_host_triple"
	::if not defined target_arch (set "target_arch=%host_arch%")
	set "target_arch=%default_target_arch%"
	%dk_call% dk_printVar target_arch
	
	::###### target_env ######
	::%dk_call% dk_validate host_env "%dk_call% dk_host_triple"
	::if not defined target_env (set "target_env=%host_env%")
	if not defined target_env (set "target_env=%default_target_env%")
	%dk_call% dk_printVar target_env
	
	
    ::###### COMPILER_EXE ######
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"

	if "%target_env%"=="cosmocc"		(%dk_call% dk_validate SH_EXE               "%dk_call% %DKIMPORTS_DIR%/sh/dk_install.cmd")
	if "%target_env%"=="cosmocc"		(%dk_call% dk_validate COSMOCC_C_COMPILER   "%dk_call% %DKIMPORTS_DIR%/cosmocc/dk_install.cmd")
	if "%target_env%"=="clang"			(%dk_call% dk_validate CLANG_C_COMPILER     "%dk_call% %DKIMPORTS_DIR%/clang/dk_install.cmd")
	if "%target_env%"=="gcc"			(%dk_call% dk_validate GCC_C_COMPILER       "%dk_call% %DKIMPORTS_DIR%/gcc/dk_install.cmd")

	if "%target_env%"=="cosmocc"		(set "COMPILER_EXE=%SH_EXE% %COSMOCC_C_COMPILER%")
	if "%target_env%"=="clang"			(set "COMPILER_EXE=%CLANG_C_COMPILER%")
	if "%target_env%"=="gcc"			(set "COMPILER_EXE=%GCC_C_COMPILER%")
	%dk_call% dk_assertVar COMPILER_EXE
	%dk_call% dk_printVar COMPILER_EXE

	

	
	::###### COMPILER_EXE ######
	::set "COMPILER_EXE=%~1"
	if not defined COMPILER_EXE    (echo ERROR: COMPILER_EXE is invalid)
	
	::###### DKC_FILE ######
	set "DKC_FILE=%~1"
	if not defined DKC_FILE    (echo ERROR: DKC_FILE is invalid)
	
	::###### APP_NAME ######
	for %%Z in ("%DKC_FILE%") do (set "APP_NAME=%%~nZ")
	set "DKC_FILE=%DKC_FUNCTIONS_DIR%/%DKC_FILE%.c"
	
	::###### Setup build directory
	if not exist "%CD%\build" (mkdir "%CD%\build")
	
	::###### APP_FILE ######
	set "APP_FILE=%CD%\build\%APP_NAME%.exe"
	
	::###### Compile Code ######
	echo compiling ...
	if exist %APP_FILE%  (del %APP_FILE%)

	set "COMPILE_COMMAND=%COMPILER_EXE% -o %APP_FILE% -static %DKC_FILE%"
	echo %COMPILE_COMMAND%
	%COMPILE_COMMAND%
	
	if not exist "%APP_FILE%" (
		echo:	
		echo %red%ERROR: compilation of %DKC_FILE% failed.%clr%
		pause
		exit /b 13
	)
	
	::###### run executable ######
	%dk_call% dk_commandToVariable "%APP_FILE%"
	endlocal & (set dk_callDKC=%dk_commandToVariable%)
	
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKC dk_test "FROM DKBatch" "dk_callDKC.cmd"
    %dk_call% dk_echo
	echo dk_callDKC = %dk_callDKC%
%endfunction%

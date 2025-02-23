@echo off
if "%~1" == "" (goto :dk_install)

:runDKC
	if not defined ESC (set "ESC=")
	if not defined clr (set "clr=%ESC%[0m")
	if not defined red (set "red=%ESC%[31m")
	if not defined bg_magenta (set "bg_magenta=%ESC%[45m")
	if not defined white (set "white=%ESC%[37m")
	
	::###### DK_C_COMPILER ######
	if not defined DK_C_COMPILER (set "DK_C_COMPILER=%~1")
	if not defined DK_C_COMPILER (echo %red%ERROR: DK_C_COMPILER is invalid%clr%)
	
	::###### DKC_FILE ######
	if not defined DKC_FILE (set "DKC_FILE=%~2")
	if not defined DKC_FILE	(echo %red%ERROR: DKC_FILE is invalid%clr%)
	
	::###### APP_NAME ######
	for %%Z in ("%DKC_FILE%") do (set "APP_NAME=%%~nZ")
	
	::###### Setup build directory
	if not exist "%CD%/build" (mkdir "%CD%\build")
	
	::###### APP_FILE ######
	set "APP_FILE=%CD%/build/%APP_NAME%.exe"
	
	::###### Compile Code ######
	echo compiling ...
	if exist "%APP_FILE%" (del "%APP_FILE:/=\%")

	::set "COMPILE_COMMAND=%DK_CXX_COMPILER% -mclang -mcosmo -DDKTEST=1 -o %APP_FILE% -static %DKCPP_FILE%"
	set COMPILE_COMMAND=%DK_C_COMPILER% -o %APP_FILE% -static %DKC_FILE%
	echo %COMPILE_COMMAND%
	%COMPILE_COMMAND%
	
	if not exist "%APP_FILE%" (
		echo:
		echo %red%ERROR: compilation of %DKC_FILE% failed.%clr%
		pause
		exit /b 13
	)
	
	::###### run executable ######
	::cls
	title %DKC_FILE%
	echo:
	echo %bg_magenta%%white%###### DKTEST MODE ###### %APP_NAME%.c ###### DKTEST MODE ######%clr%
	echo:
    %COMSPEC% /v:on /c "%APP_FILE%"
	echo:
	echo %bg_magenta%%white%######## END TEST ####### %APP_NAME%.c ######## END TEST #######%clr%
	echo:
	
	set "return_code=%ERRORLEVEL%"
	echo return_code = %return_code%
	pause

%endfunction%












:dk_install
	if not "%~1"=="" (goto:eof)
	
	::###### DEFAULT ENVIRONMENT ######
	:: clang, cosmocc, gcc, msvc 
	::if not defined target_os	(set "target_os=cosmocc")
	::if not defined target_arch	(set "target_arch=cosmocc")
	::if not defined target_env	(set "target_env=cosmocc")
	
	::###### DK_CMD ######
	if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../DKBatch/functions/")
	if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)
	
	::###### Install DKC ######
	%dk_call% dk_echo "Installing DKC . . ."
	
	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
	
	::###### target_os ######
	if not defined target_os (set "target_os=win")
	%dk_call% dk_printVar target_os
	
	::###### target_arch ######
	if not defined target_arch (set "target_arch=x86_64")
	%dk_call% dk_printVar target_arch
	
	::###### target_env ######
	if not defined target_env (set "target_env=clang")
	%dk_call% dk_printVar target_env
	
	::###### target_triple ######
	if not defined target_triple (set "target_triple=%target_os%_%target_arch%_%target_env%")
	%dk_call% dk_printVar target_triple
	
	::###### MSYSTEM ######
	::if not defined MSYSTEM  if "%target_env%"=="clang" if "%target_arch%"=="x86"    set "MSYSTEM=CLANG32"
	::if not defined MSYSTEM  if "%target_env%"=="clang" if "%target_arch%"=="x86_64" set "MSYSTEM=CLANG64"
	::if not defined MSYSTEM  if "%target_env%"=="clang" if "%target_arch%"=="arm64"  set "MSYSTEM=CLANGARM64"
	::if not defined MSYSTEM  if "%target_env%"=="gcc"   if "%target_arch%"=="x86"    set "MSYSTEM=MINGW32"
	::if not defined MSYSTEM  if "%target_env%"=="gcc"   if "%target_arch%"=="x86_64" set "MSYSTEM=MINGW64"
	::%dk_call% dk_printVar MSYSTEM

	::###### DK_C_COMPILER ######
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"

	if "%target_env%"=="cosmocc"	(%dk_call% dk_validate SH_EXE               "%dk_call% %DKIMPORTS_DIR%/sh/dk_install.cmd")
	if "%target_env%"=="cosmocc"	(%dk_call% dk_validate COSMOCC_C_COMPILER   "%dk_call% %DKIMPORTS_DIR%/cosmocc/dk_install.cmd")
	if "%target_env%"=="clang"		(%dk_call% dk_validate CLANG_C_COMPILER     "%dk_call% %DKIMPORTS_DIR%/clang/dk_install.cmd")
	if "%target_env%"=="gcc"		(%dk_call% dk_validate GCC_C_COMPILER       "%dk_call% %DKIMPORTS_DIR%/gcc/dk_install.cmd")

	if "%target_env%"=="cosmocc"	(set "DK_C_COMPILER=%SH_EXE% %COSMOCC_C_COMPILER%")
	if "%target_env%"=="clang"  	(set "DK_C_COMPILER=%CLANG_C_COMPILER%")
	if "%target_env%"=="gcc"	  	(set "DK_C_COMPILER=%GCC_C_COMPILER%")
	%dk_call% dk_assertVar DK_C_COMPILER
	%dk_call% dk_printVar DK_C_COMPILER
	
	%dk_call% dk_registryDeleteKey "HKCR/DKC"
	ftype DKC=%COMSPEC% /v:on /k call "%~f0" "%DK_C_COMPILER%" "%%1" %%*
	
	%dk_call% dk_registryDeleteKey "HKCR/.c"
	%dk_call% dk_registryDeleteKey "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.c"
	assoc .c=DKC
	
	%dk_call% dk_success "DKC install complete"
%endfunction%
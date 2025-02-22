@echo off
if "%~1" == "" (goto :dk_install)

:runDKC
	set "ESC="
	set "clr=%ESC%[0m"
	set "red=%ESC%[31m"
	set "bg_magenta=%ESC%[45m"
	set "white=%ESC%[37m"
	
	::###### COMPILER_EXE ######
	set "COMPILER_EXE=%~1"
	if not defined COMPILER_EXE (echo %red%ERROR: COMPILER_EXE is invalid%clr%)
	
	::###### DKC_FILE ######
	set "DKC_FILE=%~2"
	if not defined DKC_FILE		(echo %red%ERROR: DKC_FILE is invalid%clr%)
	
	::###### APP_NAME ######
	for %%Z in ("%DKC_FILE%") do (set "APP_NAME=%%~nZ")
	
	::###### Setup build directory
	if not exist "%CD%\build"	(mkdir "%CD%\build")
	
	::###### APP_FILE ######
	set "APP_FILE=%CD%\build\%APP_NAME%.exe"
	
	::###### Compile Code ######
	echo compiling ...
	if exist "%APP_FILE%" (del "%APP_FILE%")

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
	
::	::###### reload ######
::	if not exist %~dp0\reload goto:eof
::	del %~dp0\reload
::	cls
::	goto runDKC
%endfunction%
























:dk_install

	if not "%~1"=="" (goto:eof)
	
	::###### DEFAULT ENVIRONMENT ######
	:: clang, cosmocc, gcc, msvc 
	set "default_target_os=cosmocc"
	set "default_target_arch=cosmocc"
	set "default_target_env=cosmocc"
	
	::###### DK_CMD ######
	if not defined DKBATCH_FUNCTIONS_DIR_ 	(set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\")
	if not defined DK_CMD 					(call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)
	
	::###### Install DKC ######
	%dk_call% dk_echo "Installing DKC . . ."
	
	::###### OS ######
	set "target_os=%default_target_os%"
	%dk_call% dk_printVar target_os
	
	::###### arch ######
	set "target_arch=%default_target_arch%"
	%dk_call% dk_printVar target_arch
	
	::###### target_env ######
	set "target_env=%default_target_env%"
	%dk_call% dk_printVar target_env
	
	::###### MSYSTEM ######
	::if not defined MSYSTEM  if "%target_env%"=="clang" if "%target_arch%"=="x86"    set "MSYSTEM=CLANG32"
	::if not defined MSYSTEM  if "%target_env%"=="clang" if "%target_arch%"=="x86_64" set "MSYSTEM=CLANG64"
	::if not defined MSYSTEM  if "%target_env%"=="clang" if "%target_arch%"=="arm64"  set "MSYSTEM=CLANGARM64"
	::if not defined MSYSTEM  if "%target_env%"=="gcc"   if "%target_arch%"=="x86"    set "MSYSTEM=MINGW32"
	::if not defined MSYSTEM  if "%target_env%"=="gcc"   if "%target_arch%"=="x86_64" set "MSYSTEM=MINGW64"
	::%dk_call% dk_printVar MSYSTEM

	::###### COMPILER_EXE ######
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"

	if "%target_env%"=="cosmocc"    (%dk_call% dk_validate SH_EXE               "%dk_call% %DKIMPORTS_DIR%\sh\dk_install.cmd")
	if "%target_env%"=="cosmocc"    (%dk_call% dk_validate COSMOCC_C_COMPILER   "%dk_call% %DKIMPORTS_DIR%\cosmocc\dk_install.cmd")
	if "%target_env%"=="clang"  	(%dk_call% dk_validate CLANG_C_COMPILER     "%dk_call% %DKIMPORTS_DIR%\clang\dk_install.cmd")
	if "%target_env%"=="gcc"    	(%dk_call% dk_validate GCC_C_COMPILER       "%dk_call% %DKIMPORTS_DIR%\gcc\dk_install.cmd")

	if "%target_env%"=="cosmocc"	(set "COMPILER_EXE=%SH_EXE% %COSMOCC_C_COMPILER%")
	if "%target_env%"=="clang"  	(set "COMPILER_EXE=%CLANG_C_COMPILER%")
	if "%target_env%"=="gcc"	  	(set "COMPILER_EXE=%GCC_C_COMPILER%")
	%dk_call% dk_assertVar COMPILER_EXE

	%dk_call% dk_registryDeleteKey "HKCR\DKC"
	ftype DKC=%COMSPEC% /c call "%~f0" "%COMPILER_EXE%" "%%1" %%*
	
	%dk_call% dk_registryDeleteKey "HKCR\.c"
	%dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.c"
	assoc .c=DKC
	
	%dk_call% dk_success "DKC install complete"
%endfunction%
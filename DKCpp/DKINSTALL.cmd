@echo off
if "%~1" == "" (goto :DKINSTALL)

:runDKCpp
	if not defined ESC (set "ESC=")
	if not defined clr (set "clr=%ESC%[0m")
	if not defined red (set "red=%ESC%[31m")
	if not defined bg_magenta (set "bg_magenta=%ESC%[45m")
	if not defined white (set "white=%ESC%[37m")
	
	::###### DK_CXX_COMPILER ######
	if not defined DK_CXX_COMPILER (set "DK_CXX_COMPILER=%~1")
	if not defined DK_CXX_COMPILER (echo %red%ERROR: DK_CXX_COMPILER is invalid%clr%)
	
	::###### DKCPP_FILE ######
	if not defined DKCPP_FILE (set "DKCPP_FILE=%~2")
	if not defined DKCPP_FILE (echo %red%ERROR: DKCPP_FILE is invalid%clr%)
	
	::###### APP_NAME ######
	for %%Z in ("%DKCPP_FILE%") do (set "APP_NAME=%%~nZ")
	
	::###### Setup build directory
	if not exist "%CD%/build" (mkdir "%CD%\build")
	
	::###### APP_FILE ######
	set "APP_FILE=%CD%/build/%APP_NAME%.exe"
	
	::###### Compile Code ######
	echo compiling ...
	if exist "%APP_FILE%" (del "%APP_FILE:/=\%")

	::set "COMPILE_COMMAND=%DK_CXX_COMPILER% -mclang -mcosmo -DDKTEST=1 -o %APP_FILE% -static %DKCPP_FILE%"
	set COMPILE_COMMAND=%DK_CXX_COMPILER% -v -o %APP_FILE% -static %DKCPP_FILE% -lgdi32
	echo %COMPILE_COMMAND%
	%COMPILE_COMMAND%
	
	if not exist "%APP_FILE%" (
		echo:
		echo %red%ERROR: compilation of %DKCPP_FILE% failed.%clr%
		pause
		exit /b 13
	)
	
	::###### run executable ######
	::cls
	title %DKCPP_FILE%
	echo:
	echo %bg_magenta%%white%###### DKTEST MODE ###### %APP_NAME%.cpp ###### DKTEST MODE ######%clr%
	echo:
    %COMSPEC% /v:on /c "%APP_FILE%"
	echo:
	echo %bg_magenta%%white%######## END TEST ####### %APP_NAME%.cpp ######## END TEST #######%clr%
	echo:
	
	set "exit_status=%ERRORLEVEL%"
	echo exit_status = %exit_status%
	pause

%endfunction%

















:DKINSTALL
	if not "%~1"=="" (goto:eof)
	
	echo Installing DKCpp . . .
	
	::###### DEFAULT ENVIRONMENT ######
	:: clang, cosmocc, gcc, msvc 
	::if not defined target_os		(set "target_os=cosmocc")
	::if not defined target_arch	(set "target_arch=cosmocc")
	::if not defined target_env		(set "target_env=cosmocc")
	
	::###### DK.cmd ######
	if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
	if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
	
	::###### Install DKCpp ######
	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
	
	::###### target_os ######
	if not defined target_os (set "target_os=win")
	
	::###### target_arch ######
	if not defined target_arch (set "target_arch=x86_64")
	
	::###### target_env ######
	if not defined target_env (set "target_env=clang")
	
	::###### target_triple ######
	if not defined target_triple (set "target_triple=%target_os%_%target_arch%_%target_env%")
	set "%target_triple%=1"
	
	::###### MSYSTEM ######
	::if not defined MSYSTEM  if "%target_env%"=="clang" if "%target_arch%"=="x86"    set "MSYSTEM=CLANG32"
	::if not defined MSYSTEM  if "%target_env%"=="clang" if "%target_arch%"=="x86_64" set "MSYSTEM=CLANG64"
	::if not defined MSYSTEM  if "%target_env%"=="clang" if "%target_arch%"=="arm64"  set "MSYSTEM=CLANGARM64"
	::if not defined MSYSTEM  if "%target_env%"=="gcc"   if "%target_arch%"=="x86"    set "MSYSTEM=MINGW32"
	::if not defined MSYSTEM  if "%target_env%"=="gcc"   if "%target_arch%"=="x86_64" set "MSYSTEM=MINGW64"

	::###### DK_CXX_COMPILER ######
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"

	if "%target_env%"=="cosmocc"	(%dk_call% dk_validate SH_EXE				"%dk_call% %DKIMPORTS_DIR%/sh/DKINSTALL.cmd")
	if "%target_env%"=="cosmocc"	(%dk_call% dk_validate COSMOCC_CXX_COMPILER	"%dk_call% %DKIMPORTS_DIR%/cosmocc/DKINSTALL.cmd")
	if "%target_env%"=="clang"		(%dk_call% dk_validate CLANG_CXX_COMPILER	"%dk_call% %DKIMPORTS_DIR%/clang/DKINSTALL.cmd")
	if "%target_env%"=="gcc"		(%dk_call% dk_validate GCC_CXX_COMPILER		"%dk_call% %DKIMPORTS_DIR%/gcc/DKINSTALL.cmd")

	if "%target_env%"=="cosmocc"	(set "DK_CXX_COMPILER=%SH_EXE% %COSMOCC_CXX_COMPILER%")
	if "%target_env%"=="clang"  	(set "DK_CXX_COMPILER=%CLANG_CXX_COMPILER%")
	if "%target_env%"=="gcc"	  	(set "DK_CXX_COMPILER=%GCC_CXX_COMPILER%")
	%dk_call% dk_assertVar DK_CXX_COMPILER

	%dk_call% dk_registryDeleteKey "HKCR/DKCpp"
	ftype DKCpp=%COMSPEC% /v:on /k call "%~f0" "%DK_CXX_COMPILER%" "%%1" %%*
	
	%dk_call% dk_registryDeleteKey "HKCR/.cpp"
	%dk_call% dk_registryDeleteKey "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.cpp"
	assoc .cpp=DKCpp
	
	%dk_call% dk_success "DKCpp install complete"
%endfunction%
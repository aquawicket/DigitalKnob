@echo off
if "%~1" equ "" (goto :DKINSTALL)

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
    %ComSpec% /v:on /c "%APP_FILE%"
	echo:
	echo %bg_magenta%%white%######## END TEST ####### %APP_NAME%.cpp ######## END TEST #######%clr%
	echo:
	
	set "exit_code=%ERRORLEVEL%"
	echo exit_code = %exit_code%
	pause

%endfunction%

















:DKINSTALL
	if "%~1" neq "" (goto:eof)
	
	echo Installing DKCpp . . .
	
	::###### DEFAULT ENVIRONMENT ######
	:: clang, cosmocc, gcc, msvc 
	::if not defined Target_Os		(set "Target_Os=cosmocc")
	::if not defined Target_Arch	(set "Target_Arch=cosmocc")
	::if not defined Target_Env		(set "Target_Env=cosmocc")
	
	::###### DK.cmd ######
	if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/")
	if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
	
	::###### Install DKCpp ######
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	
	::###### Target_Os ######
	if not defined Target_Os (set "Target_Os=win")
	
	::###### Target_Arch ######
	if not defined Target_Arch (set "Target_Arch=x86_64")
	
	::###### Target_Env ######
	if not defined Target_Env (set "Target_Env=clang")
	
	::###### target_tuple ######
	if not defined target_tuple (set "target_tuple=%Target_Os%_%Target_Arch%_%Target_Env%")
	set "%target_tuple%=1"
	
	::###### MSYSTEM ######
	::if not defined MSYSTEM  if "%Target_Env%"=="clang" if "%Target_Arch%"=="x86"    set "MSYSTEM=CLANG32"
	::if not defined MSYSTEM  if "%Target_Env%"=="clang" if "%Target_Arch%"=="x86_64" set "MSYSTEM=CLANG64"
	::if not defined MSYSTEM  if "%Target_Env%"=="clang" if "%Target_Arch%"=="arm64"  set "MSYSTEM=CLANGARM64"
	::if not defined MSYSTEM  if "%Target_Env%"=="gcc"   if "%Target_Arch%"=="x86"    set "MSYSTEM=MINGW32"
	::if not defined MSYSTEM  if "%Target_Env%"=="gcc"   if "%Target_Arch%"=="x86_64" set "MSYSTEM=MINGW64"

	::###### DK_CXX_COMPILER ######
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"

	if "%Target_Env%"=="cosmocc"	(%dk_call% dk_validate SH_EXE				"%dk_call% %DKIMPORTS_DIR%/sh/DKINSTALL.cmd")
	if "%Target_Env%"=="cosmocc"	(%dk_call% dk_validate COSMOCC_CXX_COMPILER	"%dk_call% %DKIMPORTS_DIR%/cosmocc/DKINSTALL.cmd")
	if "%Target_Env%"=="clang"		(%dk_call% dk_validate CLANG_CXX_COMPILER	"%dk_call% %DKIMPORTS_DIR%/clang/DKINSTALL.cmd")
	if "%Target_Env%"=="gcc"		(%dk_call% dk_validate GCC_CXX_COMPILER		"%dk_call% %DKIMPORTS_DIR%/gcc/DKINSTALL.cmd")

	if "%Target_Env%"=="cosmocc"	(set "DK_CXX_COMPILER=%SH_EXE% %COSMOCC_CXX_COMPILER%")
	if "%Target_Env%"=="clang"  	(set "DK_CXX_COMPILER=%CLANG_CXX_COMPILER%")
	if "%Target_Env%"=="gcc"	  	(set "DK_CXX_COMPILER=%GCC_CXX_COMPILER%")
	%dk_call% dk_assertVar DK_CXX_COMPILER

	%dk_call% dk_registryDeleteKey "HKCR/DKCpp"
	ftype DKCpp=%ComSpec% /v:on /k call "%~f0" "%DK_CXX_COMPILER%" "%%1" %%*
	
	%dk_call% dk_registryDeleteKey "HKCR/.cpp"
	%dk_call% dk_registryDeleteKey "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.cpp"
	assoc .cpp=DKCpp
	
	%dk_call% dk_success "DKCpp install complete"
%endfunction%
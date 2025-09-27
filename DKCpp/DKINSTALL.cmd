@echo off
if "%~1" equ "" (goto :DKINSTALL)

:runDKCpp
	if NOT defined ESC (set "ESC=")
	if NOT defined clr (set "clr=%ESC%[0m")
	if NOT defined red (set "red=%ESC%[31m")
	if NOT defined bg_magenta (set "bg_magenta=%ESC%[45m")
	if NOT defined white (set "white=%ESC%[37m")
	
	::###### DK_CXX_COMPILER ######
	if NOT defined DK_CXX_COMPILER (set "DK_CXX_COMPILER=%~1")
	if NOT defined DK_CXX_COMPILER (echo %red%ERROR: DK_CXX_COMPILER is invalid%clr%)
	
	::###### DKCPP_FILE ######
	if NOT defined DKCPP_FILE (set "DKCPP_FILE=%~2")
	if NOT defined DKCPP_FILE (echo %red%ERROR: DKCPP_FILE is invalid%clr%)
	
	::###### APP_NAME ######
	for %%Z in ("%DKCPP_FILE%") do (set "APP_NAME=%%~nZ")
	
	::###### Setup build directory
	if NOT EXIST "%CD%/build" (mkdir "%CD%\build")
	
	::###### APP_FILE ######
	set "APP_FILE=%CD%/build/%APP_NAME%.exe"
	
	::###### Compile Code ######
	echo compiling ...
	if EXIST "%APP_FILE%" (del "%APP_FILE:/=\%")

	::set "COMPILE_COMMAND=%DK_CXX_COMPILER% -mclang -mcosmo -DDKTEST=1 -o %APP_FILE% -static %DKCPP_FILE%"
	set COMPILE_COMMAND=%DK_CXX_COMPILER% -v -o %APP_FILE% -static %DKCPP_FILE% -lgdi32
	echo %COMPILE_COMMAND%
	%COMPILE_COMMAND%
	
	if NOT EXIST "%APP_FILE%" (
		echo(
		echo %red%ERROR: compilation of %DKCPP_FILE% failed.%clr%
		pause
		exit /b 13
	)
	
	::###### run executable ######
	title %DKCPP_FILE%
	echo(
	echo %bg_magenta%%white%###### DKTEST MODE ###### %APP_NAME%.cpp ###### DKTEST MODE ######%clr%
	echo(
    %ComSpec% /v:on /c "%APP_FILE%"
	echo(
	echo %bg_magenta%%white%######## END TEST ####### %APP_NAME%.cpp ######## END TEST #######%clr%
	echo(
	
	set "exit_code=%ERRORLEVEL%"
	echo exit_code = %exit_code%
	pause

%endfunction%

















:DKINSTALL
	if "%~1" neq "" (goto:eof)
	
	echo Installing DKCpp . . .
	
	::###### DEFAULT ENVIRONMENT ######
	:: clang, cosmocc, gcc, msvc
	::if NOT defined Target_Os		(set "Target_Os=cosmocc")
	::if NOT defined Target_Arch	(set "Target_Arch=cosmocc")
	::if NOT defined Target_Env		(set "Target_Env=cosmocc")
	
	::###### DK.cmd ######
	@echo off&::###### DK.cmd #########################################################################################################################
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/") 
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
	::#################################################################################################################################################
	
	::###### Install DKCpp ######
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	
	::###### Target_Os ######
	if NOT defined Target_Os (set "Target_Os=Windows")
	
	::###### Target_Arch ######
	if NOT defined Target_Arch (set "Target_Arch=X86_64")
	
	::###### Target_Env ######
	if NOT defined Target_Env (set "Target_Env=Clang")
	
	::###### Target_Tuple ######
	if NOT defined Target_Tuple (set "Target_Tuple=%Target_Os%_%Target_Arch%_%Target_Env%")
	set "%Target_Tuple%=1"
	
	::###### MSYSTEM ######
	::if NOT defined MSYSTEM  if "%Target_Env%"=="Clang" if "%Target_Arch%"=="X86"    set "MSYSTEM=CLANG32"
	::if NOT defined MSYSTEM  if "%Target_Env%"=="Clang" if "%Target_Arch%"=="X86_64" set "MSYSTEM=CLANG64"
	::if NOT defined MSYSTEM  if "%Target_Env%"=="Clang" if "%Target_Arch%"=="Arm64"  set "MSYSTEM=CLANGARM64"
	::if NOT defined MSYSTEM  if "%Target_Env%"=="Gcc"   if "%Target_Arch%"=="X86"    set "MSYSTEM=MINGW32"
	::if NOT defined MSYSTEM  if "%Target_Env%"=="Gcc"   if "%Target_Arch%"=="X86_64" set "MSYSTEM=MINGW64"

	::###### DK_CXX_COMPILER ######
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"

	if "%Target_Env%"=="CosmoCC"	(%dk_call% dk_validate sh_exe				"%dk_call% dk_depend sh_exe")
	if "%Target_Env%"=="CosmoCC"	(%dk_call% dk_validate COSMOCC_CXX_COMPILER	"%dk_call% dk_depend cosmocc")
	if "%Target_Env%"=="Clang"		(%dk_call% dk_validate CLANG_CXX_COMPILER	"%dk_call% dk_depend clang")
	if "%Target_Env%"=="Gcc"		(%dk_call% dk_validate GCC_CXX_COMPILER		"%dk_call% dk_depend gcc")

	if "%Target_Env%"=="CosmoCC"	(set "DK_CXX_COMPILER=%sh_exe% %COSMOCC_CXX_COMPILER%")
	if "%Target_Env%"=="Clang"  	(set "DK_CXX_COMPILER=%CLANG_CXX_COMPILER%")
	if "%Target_Env%"=="Gcc"	  	(set "DK_CXX_COMPILER=%GCC_CXX_COMPILER%")
	%dk_call% dk_assertVar DK_CXX_COMPILER

	%dk_call% dk_registryDeleteKey "HKCR/DKCpp"
	ftype DKCpp=%ComSpec% /v:on /k call "%~f0" "%DK_CXX_COMPILER%" "%%1" %%*
	
	%dk_call% dk_registryDeleteKey "HKCR/.cpp"
	%dk_call% dk_registryDeleteKey "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.cpp"
	assoc .cpp=DKCpp
	
	%dk_call% dk_success "DKCpp install complete"
%endfunction%
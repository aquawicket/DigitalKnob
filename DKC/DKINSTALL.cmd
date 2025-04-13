@echo off
if "%~1" equ "" (goto:DKINSTALL)

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
	if not exist "%CD:\=/%/build" (mkdir "%CD%\build")

	::###### APP_FILE ######
	set "APP_FILE=%CD:\=/%/build/%APP_NAME%.exe"

	::###### Compile Code ######
	echo compiling ...
	if exist "%APP_FILE%" (del "%APP_FILE:/=\%")

	::set "COMPILE_COMMAND=%DK_CXX_COMPILER% -mclang -mcosmo -DDKTEST=1 -o %APP_FILE% -static %DKCPP_FILE%"

	::###### compile ######
::	g++.exe -DHAVE_lib @CMakeFiles/app.dir/includes_CXX.rsp -frtti -fexceptions -march=x86-64 -DMSYSTEM=MINGW64 -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17 -DDEBUG -D_DEBUG -g -MD -MT CMakeFiles/app.dir/C_/apps/app/main.cpp.obj -MF CMakeFiles\app.dir\C_\app\main.cpp.obj.d -o CMakeFiles\app.dir\C_\app\main.cpp.obj -c C:\app\main.cpp

::	g++.exe -frtti -fexceptions -march=x86-64 -DMSYSTEM=MINGW64 -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17 -DDEBUG -D_DEBUG -g -static -Wl,--whole-archive CMakeFiles\HelloWorld.dir/objects.a -Wl,--no-whole-archive -o HelloWorld.exe -Wl,--out-implib,libHelloWorld.dll.a -Wl,--major-image-version,0,--minor-image-version,0 @CMakeFiles\HelloWorld.dir\linkLibs.rsp

	::set "LDFLAGS=-static -static-libgcc -static-libstdc++ C:\Users\Administrator\digitalknob\Development\3rdParty\msys2-base-x86_64-20241208\mingw64\lib\libwinpthread.a"
	set COMPILE_COMMAND="%DK_C_COMPILER%" -v -o "%APP_FILE%" -static "%DKC_FILE%" -lgdi32
	::set COMPILE_COMMAND=%DK_C_COMPILER% -v -frtti -fexceptions -march=x86-64 -DMSYSTEM=MINGW64 -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17 -DDEBUG -D_DEBUG -g -static -o HelloWorld.exe

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
	"%COMSPEC%" /v:on /c "%APP_FILE%"
	echo:
	echo %bg_magenta%%white%######## END TEST ####### %APP_NAME%.c ######## END TEST #######%clr%
	echo:

	set "exit_status=%ERRORLEVEL%"
	echo exit_status = %exit_status%
	pause

%endfunction%












:DKINSTALL
	if "%~1" neq "" (goto:eof)

	echo Installing DKC . . .
	
	::###### DEFAULT ENVIRONMENT ######
	:: clang, cosmocc, gcc, msvc
	:: NOTE: gcc is now working yet.  Need the appropriate command to line libwinpthread and others statically

	::if not defined target_os		(set "target_os=win")
	::if not defined target_arch	(set "target_arch=x86_64")
	::if not defined target_env		(set "target_env=gcc")

	::###### DK.cmd ######
	if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../DKBatch/functions/")
	if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
	if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

	::###### Install DKC ######
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
	::if not defined MSYSTEM  if "%target_env%" equ "clang" if "%target_arch%" equ "x86"    set "MSYSTEM=CLANG32"
	::if not defined MSYSTEM  if "%target_env%" equ "clang" if "%target_arch%" equ "x86_64" set "MSYSTEM=CLANG64"
	::if not defined MSYSTEM  if "%target_env%" equ "clang" if "%target_arch%" equ "arm64"  set "MSYSTEM=CLANGARM64"
	::if not defined MSYSTEM  if "%target_env%" equ "gcc"   if "%target_arch%" equ "x86"    set "MSYSTEM=MINGW32"
	::if not defined MSYSTEM  if "%target_env%" equ "gcc"   if "%target_arch%" equ "x86_64" set "MSYSTEM=MINGW64"

	::###### DK_C_COMPILER ######
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"

	if "%target_env%" equ "cosmocc"	(%dk_call% dk_validate SH_EXE				"%dk_call% %DKIMPORTS_DIR%/sh/DKINSTALL.cmd")
	if "%target_env%" equ "cosmocc"	(%dk_call% dk_validate COSMOCC_C_COMPILER	"%dk_call% %DKIMPORTS_DIR%/cosmocc/DKINSTALL.cmd")
	if "%target_env%" equ "clang"	(%dk_call% dk_validate CLANG_C_COMPILER		"%dk_call% %DKIMPORTS_DIR%/clang/DKINSTALL.cmd")
	if "%target_env%" equ "gcc"		(%dk_call% dk_validate GCC_C_COMPILER		"%dk_call% %DKIMPORTS_DIR%/gcc/DKINSTALL.cmd")

	if "%target_env%" equ "cosmocc"	(set "DK_C_COMPILER=%SH_EXE% %COSMOCC_C_COMPILER%")
	if "%target_env%" equ "clang"	(set "DK_C_COMPILER=%CLANG_C_COMPILER%")
	if "%target_env%" equ "gcc"		(set "DK_C_COMPILER=%GCC_C_COMPILER%")
	%dk_call% dk_assertPath DK_C_COMPILER

	%dk_call% dk_registryDeleteKey "HKCR/DKC"
	ftype DKC="%COMSPEC%" /v:on /k call "%~f0" "%DK_C_COMPILER%" "%%1" %%*

	%dk_call% dk_registryDeleteKey "HKCR/.c"
	%dk_call% dk_registryDeleteKey "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.c"
	assoc .c=DKC

	%dk_call% dk_success "DKC install complete"
%endfunction%
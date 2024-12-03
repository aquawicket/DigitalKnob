@echo off

::### OS ###
::default = host_os
::set "OS=Android"
::set "OS=Emscripten"
::set "OS=iOS"
::set "OS=iOS_Simulator"
::set "OS=Linux"
::set "OS=Mac"
::set "OS=Raspberry"
::set "OS=Windows"

::### arch ###
::default = host_arch
::set "arch=arm"
::set "arch=arm64"
::set "arch=x86"
::set "arch=x86_64"

::### COMPILER ###
::default = clang
::set "host_env=clang"
::set "host_env=cosmo"
::set "host_env=gcc"
::set "host_env=msvc"

::### MSYSTEM ###
::set "MSYSTEM=CLANG32"
::set "MSYSTEM=CLANG64"
::set "MSYSTEM=CLANGARM64"
::set "MSYSTEM=MINGW32"
::set "MSYSTEM=MINGW64"
::set "MSYSTEM=MSYS"
::set "MSYSTEM=UCRT64"

::Name			Prefix		Toolchain	Arch		C Library	C++ Library
::CLANG32		/clang32	llvm		i686		ucrt		libc++
::CLANG64		/clang64	llvm		x86_64		ucrt		libc++
::CLANGARM64	/clangarm64	llvm		aarch64		ucrt		libc++
::MINGW32		/mingw32	gcc			i686		msvcrt		libstdc++
::MINGW64		/mingw64	gcc			x86_64		msvcrt		libstdc++
::msvc			/?			?			?			?			?
::MSYS			/usr		gcc			x86_64		cygwin		libstdc++
::UCRT64		/ucrt64		gcc			x86_64		ucrt		libstdc++

if "%~1" equ "%~0" goto installDKC
if "%~1" neq ""    goto runDKC
:installDKC
	::###### DEFAULT ENVIRONMENT ######
	:: clang, cosmo, gcc, msvc 
	set "default_host_env=cosmo"
	
	::###### DKINIT ######
	if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
	if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
	
	::###### Install DKC ######
	%dk_call% dk_echo "Installing DKC . . ."
	
	::###### OS ######
	::%dk_call% dk_validate host_os "%dk_call% dk_host_triple"
	::if not defined OS set "OS=%host_os%"
	set "OS=cosmo"
	%dk_call% dk_printVar OS
	
	::###### arch ######
	::%dk_call% dk_validate host_arch "%dk_call% dk_host_triple"
	::if not defined arch set "arch=%host_arch%"
	set "host_arch=cosmo"
	%dk_call% dk_printVar arch
	
	::###### host_env ######
	::if not defined host_env set "host_env=%default_host_env%"
	::if not defined env set "env=%host_env%"
	set "host_env=cosmo"
	%dk_call% dk_printVar host_env
	
	::###### MSYSTEM ######
	::if not defined MSYSTEM  if "%host_env%"=="clang" if "%host_arch%"=="x86"    set "MSYSTEM=CLANG32"
	::if not defined MSYSTEM  if "%host_env%"=="clang" if "%host_arch%"=="x86_64" set "MSYSTEM=CLANG64"
	::if not defined MSYSTEM  if "%host_env%"=="clang" if "%host_arch%"=="arm64"  set "MSYSTEM=CLANGARM64"
	::if not defined MSYSTEM  if "%host_env%"=="gcc"   if "%host_arch%"=="x86"    set "MSYSTEM=MINGW32"
	::if not defined MSYSTEM  if "%host_env%"=="gcc"   if "%host_arch%"=="x86_64" set "MSYSTEM=MINGW64"
	::%dk_call% dk_printVar MSYSTEM

	::###### COMPILER_EXE ######
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"

	if "%host_env%"=="cosmo"  %dk_call% dk_validate SH_EXE "call %DKIMPORTS_DIR%\sh\dk_installSh.cmd"
	if "%host_env%"=="cosmo"  call %DKIMPORTS_DIR%\cosmocc\dk_installCosmoCC.cmd
	if "%host_env%"=="clang"  call %DKIMPORTS_DIR%\clang\dk_installClang.cmd
	if "%host_env%"=="gcc"    call %DKIMPORTS_DIR%\gcc\dk_installGcc.cmd

	if "%host_env%"=="cosmo"  set "COMPILER_EXE=%SH_EXE% %COSMO_C_COMPILER%"
	if "%host_env%"=="clang"  set "COMPILER_EXE=%CLANG_C_COMPILER%"
	if "%host_env%"=="gcc"	  set "COMPILER_EXE=%GCC_C_COMPILER%"
	%dk_call% dk_assertVar COMPILER_EXE
	%dk_call% dk_printVar COMPILER_EXE

	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKC"
	ftype DKC=cmd /c call "%~f0" "%COMPILER_EXE%" "%%1" %%*
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.c"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.c
	assoc .c=DKC
	
	%dk_call% dk_success "DKC install complete"
%endfunction%



:runDKC
	::###### COMPILER_EXE ######
	set "COMPILER_EXE=%~1"
	if not defined COMPILER_EXE    echo ERROR: COMPILER_EXE is invalid
	
	::###### DKC_FILE ######
	set "DKC_FILE=%~2"
	if not defined DKC_FILE    echo ERROR: DKC_FILE is invalid
	
	::###### APP_NAME ######
	for %%Z in ("%DKC_FILE%") do set "APP_NAME=%%~nZ"	
	
	::###### APP_FILE ######
	set "APP_FILE=%APP_NAME%.exe"
	
	::###### Compile Code ######
	echo compiling ...
	if exist %APP_FILE%  del %APP_FILE%

	set "COMPILE_COMMAND=%COMPILER_EXE% -DDKTEST=1 -o %APP_FILE% -static %DKC_FILE%"
	echo %COMPILE_COMMAND%
	%COMPILE_COMMAND%
	
	if not exist "%APP_FILE%" (
		echo: 
		echo ERROR: compilation of %DKC_FILE% failed.
		pause
		goto:eof
	)
	
	::###### run executable ######
	::cls
	title %DKCPP_FILE%
	echo:
	echo ######## start %APP_FILE% ############
	echo:
    cmd /v:on /c "%APP_FILE%"
	echo:
	echo ######### end %APP_FILE% ############
	echo:
	
	set "return_code=%ERRORLEVEL%"
	echo return_code = %return_code%
	pause
	
	::###### reload ######
	if not exist %~dp0\reload goto:eof
	del %~dp0\reload
	cls
	goto runDKC
%endfunction%

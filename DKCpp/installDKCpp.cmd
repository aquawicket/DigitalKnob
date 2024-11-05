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
::MSYS			/usr		gcc			x86_64		cygwin		libstdc++
::UCRT64		/ucrt64		gcc			x86_64		ucrt		libstdc++

if "%~1" equ "%~0" goto installDKCpp
if "%~1" neq ""    goto runDKCpp
:installDKCpp
	::###### DKINIT ######
	if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
	if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
	
	::###### Install DKCpp ######
	%dk_call% dk_echo "Installing DKCpp . . ."
	
	::###### OS ######
	if not defined host_os %dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
	if not defined OS set "OS=%host_os%"
	%dk_call% dk_printVar OS
	
	::###### arch ######
	if not defined host_arch %dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
	if not defined arch set "arch=%host_arch%"
	%dk_call% dk_printVar arch
	
	::###### host_env ######
	if not defined host_env set "host_env=clang"
	if not defined env set "env=%host_env%"
	%dk_call% dk_printVar host_env
	
	::###### MSYSTEM ######
	if not defined MSYSTEM  if "%host_env%"=="clang" if "%host_arch%"=="x86"    set "MSYSTEM=CLANG32"
	if not defined MSYSTEM  if "%host_env%"=="clang" if "%host_arch%"=="x86_64" set "MSYSTEM=CLANG64"
	if not defined MSYSTEM  if "%host_env%"=="clang" if "%host_arch%"=="arm64"  set "MSYSTEM=CLANGARM64"
	if not defined MSYSTEM  if "%host_env%"=="gcc"   if "%host_arch%"=="x86"    set "MSYSTEM=MINGW32"
	if not defined MSYSTEM  if "%host_env%"=="gcc"   if "%host_arch%"=="x86_64" set "MSYSTEM=MINGW64"
	%dk_call% dk_printVar MSYSTEM

	
	::###### COMPILER_EXE ######
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKBRANCH_DIR"

	if "%host_env%"=="clang"  call %DKIMPORTS_DIR%\clang\dk_installClang.cmd
	if "%host_env%"=="gcc"    call %DKIMPORTS_DIR%\gcc\dk_installGcc.cmd

	:: C
	::if not defined COMPILER_EXE  if "%host_env%"=="clang" set "COMPILER_EXE=%CLANG_EXE%"
	::if not defined COMPILER_EXE  if "%host_env%"=="gcc"	  set "COMPILER_EXE=%GCC_EXE%"
	:: C++
	if "%host_env%"=="clang"  set "COMPILER_EXE=%CLANG_CXX_COMPILER%"
	if "%host_env%"=="gcc"	  set "COMPILER_EXE=%GCC_CXX_COMPILER%"
	%dk_call% dk_assertVar COMPILER_EXE
	%dk_call% dk_printVar COMPILER_EXE

	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKCpp"
	ftype DKCpp=cmd /c call "%~f0" "%COMPILER_EXE%" "%%1" %%*
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.cpp"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cpp
	assoc .cpp=DKCpp
	
	%dk_call% dk_success "DKCpp install complete"
%endfunction%



:runDKCpp
	::###### COMPILER_EXE ######
	set "COMPILER_EXE=%~1"
	if not defined COMPILER_EXE   echo ERROR: COMPILER_EXE is invalid
	
	::###### DKCPP_FILE ######
	set "DKCPP_FILE=%~2"
	if not defined DKCPP_FILE     echo ERROR: DKCPP_FILE is invalid

	::###### APP_NAME ######
	for %%Z in ("%DKCPP_FILE%") do set "APP_NAME=%%~nZ"
	
	::###### APP_FILE ######
	set "APP_FILE=%APP_NAME%.exe"
	
	::###### Compile Code ######
	echo compiling ...
	if exist %APP_FILE%  del %APP_FILE%

	set "COMPILE_COMMAND=%COMPILER_EXE% -DDKTEST=1 -static -o %APP_NAME% -static %DKCPP_FILE%"
	echo %COMPILE_COMMAND%
	%COMPILE_COMMAND%
	
	if not exist "%APP_FILE%" (
		echo: 
		echo ERROR: compilation of %DKCPP_FILE% failed.
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
	goto runDKCpp
%endfunction%

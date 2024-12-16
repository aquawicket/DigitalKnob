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
::set "host_env=cosmopolitan"
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
::COSMOPOLITAN	?			?			?			?			?
::MINGW32		/mingw32	gcc			i686		msvcrt		libstdc++
::MINGW64		/mingw64	gcc			x86_64		msvcrt		libstdc++
::msvc			?			?			?			?			?
::MSYS			/usr		gcc			x86_64		cygwin		libstdc++
::UCRT64		/ucrt64		gcc			x86_64		ucrt		libstdc++
set "default_compiler=cosmopoitan"


if "%~1" equ "%~0" goto dk_install
if "%~1" neq ""    goto runDKCpp
:dk_install
	::###### DEFAULT ENVIRONMENT ######
	:: clang, cosmo, gcc, msvc 
	set "default_target_env=cosmopolitan"
	
	::###### DKINIT ######
	if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
	if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
	
	::###### Install DKCpp ######
	%dk_call% dk_echo "Installing DKCpp . . ."
	
	::###### OS ######
	%dk_call% dk_validate target_os "%dk_call% dk_target_triple"
	%dk_call% dk_validate OS      "set OS=%target_os%"
	%dk_call% dk_printVar OS
	
	::###### target_arch ######
	%dk_call% dk_validate target_arch "%dk_call% dk_target_triple"
	%dk_call% dk_validate arch      "set arch=%target_arch%"
	%dk_call% dk_printVar arch
	
	::###### target_env ######
	set "target_env=%default_target_env%"
	%dk_call% dk_validate env      "set env=%target_env%"
	%dk_call% dk_printVar env
	
	::###### MSYSTEM ######
	if not defined MSYSTEM  if "%target_env%"=="clang" if "%target_arch%"=="x86"    set "MSYSTEM=CLANG32"
	if not defined MSYSTEM  if "%target_env%"=="clang" if "%target_arch%"=="x86_64" set "MSYSTEM=CLANG64"
	if not defined MSYSTEM  if "%target_env%"=="clang" if "%target_arch%"=="arm64"  set "MSYSTEM=CLANGARM64"
	if not defined MSYSTEM  if "%target_env%"=="gcc"   if "%target_arch%"=="x86"    set "MSYSTEM=MINGW32"
	if not defined MSYSTEM  if "%target_env%"=="gcc"   if "%target_arch%"=="x86_64" set "MSYSTEM=MINGW64"
	%dk_call% dk_printVar MSYSTEM

	::###### COMPILER_EXE ######
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	
	if "%target_env%"=="cosmopolitan"  	%dk_call% dk_validate SH_EXE "call %DKIMPORTS_DIR%\sh\dk_install.cmd"
	set "SH_EXE=%SH_EXE:/=\%"
	if "%target_env%"=="cosmopolitan"	call %DKIMPORTS_DIR%\cosmocc\dk_install.cmd
	if "%target_env%"=="clang"			call %DKIMPORTS_DIR%\clang\dk_install.cmd
	if "%target_env%"=="gcc"    		call %DKIMPORTS_DIR%\gcc\dk_install.cmd

	if "%target_env%"=="cosmopolitan"  	set "COMPILER_EXE=%SH_EXE% %COSMO_CXX_COMPILER%"
	if "%target_env%"=="clang"  		set "COMPILER_EXE=%CLANG_CXX_COMPILER%"
	if "%target_env%"=="gcc"			set "COMPILER_EXE=%GCC_CXX_COMPILER%"
	%dk_call% dk_assertVar 				COMPILER_EXE
	%dk_call% dk_printVar 				COMPILER_EXE

	%dk_call% dk_registryDeleteKey 		"HKEY_CLASSES_ROOT\DKCpp"
	ftype DKCpp=%COMSPEC% /c call "%~f0" "%COMPILER_EXE%" "%%1" %%*
	
	%dk_call% dk_registryDeleteKey 		"HKEY_CLASSES_ROOT\.cpp"
	%dk_call% dk_registryDeleteKey 		"HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cpp
	assoc .cpp=DKCpp
	
	%dk_call% dk_success "DKCpp install complete"
%endfunction%



:runDKCpp
	::###### COMPILER_EXE ######
	set "COMPILER_EXE=%~1"
	::set "COMPILER_EXE=%COMPILER_EXE:/=\%"
	if not defined COMPILER_EXE   echo ERROR: COMPILER_EXE is invalid
	
	::###### DKCPP_FILE ######
	set "DKCPP_FILE=%~2"
	if not defined DKCPP_FILE     echo ERROR: DKCPP_FILE is invalid

	::###### APP_NAME ######
	for %%Z in ("%DKCPP_FILE%") do set "APP_NAME=%%~nZ"
	
	::###### APP_FILE ######
	set "APP_FILE=%APP_NAME%.exe"
	
	::##### Remove lingering files ######
	echo compiling ...
	if exist %APP_FILE%				del %APP_FILE%
	if exist %APP_FILE%.com.dbg 	del %APP_FILE%.com.dbg
	if exist %APP_FILE%.aarch64.elf	del %APP_FILE%.aarch64.elf
	
	::###### Compile Code ######
	set "COMPILE_COMMAND=%COMPILER_EXE% -DDKTEST=1 -static -o %APP_FILE% -static %DKCPP_FILE%"
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
    %COMSPEC% /v:on /c "%APP_FILE%"
	echo:
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

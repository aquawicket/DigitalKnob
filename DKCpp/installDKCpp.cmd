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

::### ARCH ###
::default = host_arch
::set "ARCH=arm"
::set "ARCH=arm64"
::set "ARCH=x86"
::set "ARCH=x86_64"

::### COMPILER ###
::default = clang
::set "COMPILER=clang"
::set "COMPILER=gcc"
::set "COMPILER=msvc"

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

if "%~1" equ "%~0" goto:installDKCpp
if "%~1" neq ""    goto:runDKCpp
:installDKCpp
	::###### DKINIT ######
	if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
	if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
	
	::###### Install DKCpp ######
	%dk_call% dk_echo "Installing DKCpp . . ."
	
	::###### OS ######
	if not defined OS %dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
	if not defined OS set "OS=%host_os%"
	%dk_call% dk_printVar OS
	
	::###### ARCH ######
	if not defined ARCH %dk_call% dk_validate host_arch "%dk_call% dk_host_triple"
	if not defined ARCH set "ARCH=%host_arch%"
	%dk_call% dk_printVar ARCH
	
	::###### COMPILER ######
	if not defined COMPILER set "COMPILER=clang"
	%dk_call% dk_printVar COMPILER
	
	::###### MSYSTEM ######
	if not defined MSYSTEM  if "%COMPILER%"=="clang" if "%ARCH%"=="x86"    set "MSYSTEM=CLANG32"
	if not defined MSYSTEM  if "%COMPILER%"=="clang" if "%ARCH%"=="x86_64" set "MSYSTEM=CLANG64"
	if not defined MSYSTEM  if "%COMPILER%"=="clang" if "%ARCH%"=="arm64"  set "MSYSTEM=CLANGARM64"
	if not defined MSYSTEM  if "%COMPILER%"=="gcc"   if "%ARCH%"=="x86"    set "MSYSTEM=MINGW32"
	if not defined MSYSTEM  if "%COMPILER%"=="gcc"   if "%ARCH%"=="x86_64" set "MSYSTEM=MINGW64"
	%dk_call% dk_printVar MSYSTEM
	
	::###### COMPILER_EXE ######
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	if "%COMPILER%"=="clang"  call %DKIMPORTS_DIR%\clang\dk_installClang.cmd
	if "%COMPILER%"=="gcc"    call %DKIMPORTS_DIR%\gcc\dk_installGcc.cmd
	:: C
	::if not defined COMPILER_EXE  if "%COMPILER%"=="clang" set "COMPILER_EXE=%CLANG_EXE%"
	::if not defined COMPILER_EXE  if "%COMPILER%"=="gcc"	  set "COMPILER_EXE=%GCC_EXE%"
	:: C++
	if "%COMPILER%"=="clang"  set "COMPILER_EXE=%CLANGXX_EXE%"
	if "%COMPILER%"=="gcc"	  set "COMPILER_EXE=%GXX_EXE%"
	%dk_call% dk_printVar COMPILER_EXE

	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKCpp"
	ftype DKCpp=cmd /c call "%~f0" "%COMPILER_EXE%" "%%1" %%*
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.c"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cpp
	assoc .cpp=DKCpp
	
	%dk_call% dk_success "DKCpp install complete"
%endfunction%



:runDKCpp
	set "COMPILER_EXE=%~1"
	set "DKCPP_FILE=%~2"
	
	if not defined COMPILER_EXE    echo ERROR: COMPILER_EXE is invalid
	
	::###### Compile Code ######
	echo compiling ...
	if exist temp.exe  del temp.exe
	::### Clang/Clang++ ###
	%COMPILER_EXE% -DDKTEST=1 -o temp -static "%DKCPP_FILE%"
	
	::### GCC/G++ ###
	::%COMPILER_EXE% -DDKTEST=1 -static -static-libgcc -static-libstdc++ -o temp "%DKCPP_FILE%"
	::%COMPILER_EXE% "%DKCPP_FILE%" -o temp -static -static-libgcc -static-libstdc++ -DDKTEST=1
	::libisl-23.dll
	::libgcc_s_dw2-1.dll
	::libgmp-10.dll
	::libmpc-3.dll
	::libmpfr-6.dll
	::libwinpthread-1.dll
	::libzstd.dll
	::zlib1.dll
	
	if not exist "temp.exe" (
		echo: 
		echo ERROR: compilation of %DKCPP_FILE% failed.
		pause
		goto:eof
	)
	
	::###### run executable ######
	title %DKCPP_FILE%
    cmd /v:on /k "temp.exe" && (echo returned TRUE) || (echo returned FALSE)
	
	::###### exit_code ######
	if %ERRORLEVEL% neq 0 echo ERROR:%ERRORLEVEL% && pause
	
	::###### reload ######
	if not exist %~dp0\reload goto:eof
	del %~dp0\reload
	cls
	goto:runDKCpp
%endfunction%

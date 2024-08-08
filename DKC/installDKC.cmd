@echo off

::### OS ###
::default = HOST_OS
::set "OS=Android"
::set "OS=Emscripten"
::set "OS=iOS"
::set "OS=iOS_Simulator"
::set "OS=Linux"
::set "OS=Mac"
::set "OS=Raspberry"
::set "OS=Windows"

::### ARCH ###
::default = HOST_ARCH
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

if "%~1" neq "" goto:runDKC
:installDKC
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	::###### Install DKC ######
	call dk_echo "Installing DKC . . ."
	
	::###### OS ######
	if not defined OS call dk_validate HOST_OS "call dk_getHostTriple"
	if not defined OS set "OS=%HOST_OS%"
	call dk_printVar OS
	
	::###### ARCH ######
	if not defined ARCH call dk_validate HOST_ARCH "call dk_getHostTriple"
	if not defined ARCH set "ARCH=%HOST_ARCH%"
	call dk_printVar ARCH
	
	::###### COMPILER ######
	if not defined COMPILER set "COMPILER=clang"
	call dk_printVar COMPILER
	
	::###### MSYSTEM ######
	if not defined MSYSTEM  if "%COMPILER%"=="clang" if "%ARCH%"=="x86"    set "MSYSTEM=CLANG32"
	if not defined MSYSTEM  if "%COMPILER%"=="clang" if "%ARCH%"=="x86_64" set "MSYSTEM=CLANG64"
	if not defined MSYSTEM  if "%COMPILER%"=="clang" if "%ARCH%"=="arm64"  set "MSYSTEM=CLANGARM64"
	if not defined MSYSTEM  if "%COMPILER%"=="gcc"   if "%ARCH%"=="x86"    set "MSYSTEM=MINGW32"
	if not defined MSYSTEM  if "%COMPILER%"=="gcc"   if "%ARCH%"=="x86_64" set "MSYSTEM=MINGW64"
	call dk_printVar MSYSTEM
	
	::###### COMPILER_EXE ######
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	if "%COMPILER%"=="clang"  call %DKIMPORTS_DIR%\clang\dk_installClang.cmd
	if "%COMPILER%"=="gcc"    call %DKIMPORTS_DIR%\gcc\dk_installGcc.cmd
	:: C
	if not defined COMPILER_EXE  if "%COMPILER%"=="clang" set "COMPILER_EXE=%CLANG_EXE%"
	if not defined COMPILER_EXE  if "%COMPILER%"=="gcc"	  set "COMPILER_EXE=%GCC_EXE%"
	:: C++
	::if "%COMPILER%"=="clang"  set "COMPILER_EXE=%CLANGXX_EXE%"
	::if "%COMPILER%"=="gcc"	  set "COMPILER_EXE=%GXX_EXE%"
	call dk_printVar COMPILER_EXE

	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKC"
	ftype DKC=cmd /c call "%~f0" "%COMPILER_EXE%" "%%1" %%*
	
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\.c"
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.c
	assoc .c=DKC
	
	call dk_echo "DKC install complete"
goto:eof



:runDKC
	set "COMPILER_EXE=%~1"
	set "DKC_FILE=%~2"
	
	echo compiling ...
	if exist temp.exe  del temp.exe
	
	::### Clang/Clang++ ###
	%COMPILER_EXE% -DDKTEST=1 -o temp -static "%DKC_FILE%"
	
	::### GCC/G++ ###
	::%COMPILER_EXE% -DDKTEST=1 -static -static-libgcc -static-libstdc++ -o temp "%DKC_FILE%"
	::%COMPILER_EXE% "%DKC_FILE%" -o temp -static -static-libgcc -static-libstdc++ -DDKTEST=1
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
		echo ERROR: compilation of %DKC_FILE% failed.
		pause
		goto:eof
	)
	
	title %DKC_FILE%
	::cls
    cmd /v:on /k "temp.exe" && echo success: return value: !errorLevel! || echo failed: return value: !errorLevel!
goto:eof
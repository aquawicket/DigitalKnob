@echo off

::### OS ###
::default = DK_HOST_OS
::set "OS=Android"
::set "OS=Emscripten"
::set "OS=iOS"
::set "OS=iOS_Simulator"
::set "OS=Linux"
::set "OS=Mac"
::set "OS=Raspberry"
::set "OS=Windows"

::### ARCH ###
::default = DK_HOST_ARCH
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
	if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
	if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
	
	::###### Install DKC ######
	%dk_call% dk_echo "Installing DKC . . ."
	
	::###### OS ######
	if not defined OS                        %dk_call% dk_validate DK_HOST_OS "%dk_call% dk_getHostTriple"
	if not defined OS                        set "OS=%DK_HOST_OS%"
	%dk_call% dk_printVar OS
	
	::###### ARCH ######
	if not defined ARCH                      %dk_call% dk_validate DK_HOST_ARCH "%dk_call% dk_getHostTriple"
	if not defined ARCH                      set "ARCH=%DK_HOST_ARCH%"
	%dk_call% dk_printVar ARCH
	
	::###### COMPILER ######
	if not defined COMPILER                  set "COMPILER=clang"
	%dk_call% dk_printVar COMPILER
	
	::###### MSYSTEM ######
	if not defined MSYSTEM  if "%COMPILER%"=="clang" if "%ARCH%"=="x86"    set "MSYSTEM=CLANG32"
	if not defined MSYSTEM  if "%COMPILER%"=="clang" if "%ARCH%"=="x86_64" set "MSYSTEM=CLANG64"
	if not defined MSYSTEM  if "%COMPILER%"=="clang" if "%ARCH%"=="arm64"  set "MSYSTEM=CLANGARM64"
	if not defined MSYSTEM  if "%COMPILER%"=="gcc"   if "%ARCH%"=="x86"    set "MSYSTEM=MINGW32"
	if not defined MSYSTEM  if "%COMPILER%"=="gcc"   if "%ARCH%"=="x86_64" set "MSYSTEM=MINGW64"
	%dk_call% dk_printVar MSYSTEM

	::###### COMPILER_EXE ######
	%dk_call% dk_validate DKIMPORTS_DIR     "%dk_call% dk_validateBranch"
echo ### DEBUG_BEGIN ###
	if "%COMPILER%"=="clang"                 call "%DKIMPORTS_DIR%\clang\dk_installClang.cmd"
echo ### DEBUG_END ###
	if "%COMPILER%"=="gcc"                   call "%DKIMPORTS_DIR%\gcc\dk_installGcc.cmd"
	:: C
	if not defined COMPILER_EXE  if "%COMPILER%"=="clang" set "COMPILER_EXE=%CLANG_EXE%"
	if not defined COMPILER_EXE  if "%COMPILER%"=="gcc"	  set "COMPILER_EXE=%GCC_EXE%"
	:: C++
	::if "%COMPILER%"=="clang"  set "COMPILER_EXE=%CLANGXX_EXE%"
	::if "%COMPILER%"=="gcc"	  set "COMPILER_EXE=%GXX_EXE%"
	%dk_call% dk_printVar COMPILER_EXE

	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKC"
	ftype DKC=cmd /c call "%~f0" "%COMPILER_EXE%" "%%1" %%*
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.c"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.c"
	assoc .c=DKC
	
	%dk_call% dk_success "DKC install complete"
%endfunction%



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
		%return%
	)
	
	title %DKC_FILE%
	::cls
    cmd /v:on /k "temp.exe" && echo success: return value: !errorLevel! || echo failed: return value: !errorLevel!
%endfunction%

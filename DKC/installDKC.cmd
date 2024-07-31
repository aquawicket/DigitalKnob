@echo off

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
	
	::###### Choose Environment ######
	::set "MSYSTEM=CLANG32"
	set "MSYSTEM=CLANG64"
	::set "MSYSTEM=CLANGARM64"
	::set "MSYSTEM=MINGW32"
	::set "MSYSTEM=MINGW64"
	::set "MSYSTEM=MSYS"
	::set "MSYSTEM=UCRT64"
	
	::###### Choose Compiler ######
	::set "COMPILER=CLANG"
	::set "COMPILER=CLANGXX"
	::set "COMPILER=GCC"
	::set "COMPILER=GXX"

	:: set default compiler
	if not defined COMPILER if "%MSYSTEM%"=="CLANG32"    set "COMPILER=CLANG"
	if not defined COMPILER if "%MSYSTEM%"=="CLANG64"    set "COMPILER=CLANG"
	if not defined COMPILER if "%MSYSTEM%"=="CLANGARM64" set "COMPILER=CLANG"
	if not defined COMPILER if "%MSYSTEM%"=="MINGW32"    set "COMPILER=GCC"
	if not defined COMPILER if "%MSYSTEM%"=="MINGW64"    set "COMPILER=GCC"
	if not defined COMPILER if "%MSYSTEM%"=="MSYS"       set "COMPILER=GCC"
	if not defined COMPILER if "%MSYSTEM%"=="UCRT64"     set "COMPILER=GCC"
	
	:: get compiler executable
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	if "%COMPILER%"=="CLANG"    call dk_validate CLANG_EXE   "call %DKIMPORTS_DIR%\clang\dk_installClang.cmd"
	if "%COMPILER%"=="CLANGXX"  call dk_validate CLANGXX_EXE "call %DKIMPORTS_DIR%\clang\dk_installClang.cmd"
	if "%COMPILER%"=="GCC"      call dk_validate GCC_EXE     "call %DKIMPORTS_DIR%\gcc\dk_installGcc.cmd"
	if "%COMPILER%"=="GXX"      call dk_validate GXX_EXE     "call %DKIMPORTS_DIR%\gcc\dk_installGcc.cmd"
	if "%COMPILER%"=="CLANG"    set "COMPILER_EXE=%CLANG_EXE%"
	if "%COMPILER%"=="CLANGXX"  set "COMPILER_EXE=%CLANGXX_EXE%"
	if "%COMPILER%"=="GCC"      set "COMPILER_EXE=%GCC_EXE%"
	if "%COMPILER%"=="GXX"      set "COMPILER_EXE=%GXX_EXE%"
	
	
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
	del temp.exe
	
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
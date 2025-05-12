@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_generate()
::#
::#
:dk_generate
 ::%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_title "Generating %Target_App% - %Target_Tuple% - %Target_Type%"
	%dk_call% dk_echo
	%dk_call% dk_info "##################################################################"
	%dk_call% dk_info "	  Generating %Target_App% - %Target_Tuple% - %Target_Type%"
	%dk_call% dk_info "##################################################################"
	%dk_call% dk_echo

	%dk_call% dk_validate DKCPP_APPS_DIR "%dk_call% dk_DKBRANCH_DIR"
	set "TARGET_PATH=%DKCPP_APPS_DIR%/%Target_App%"
	if not exist "%TARGET_PATH%/%Target_Tuple%" (%dk_call% dk_mkdir "%TARGET_PATH%\%Target_Tuple%")
	
	%dk_call% dk_validate DKCMAKE_DIR "%dk_call% dk_DKBRANCH_DIR"
	set "CMAKE_SOURCE_DIR=%DKCMAKE_DIR%"
	set "CMAKE_TARGET_PATH=%TARGET_PATH%"

	::::::::: BUILD CMAKE_ARGS ARRAY :::::::::
	set "Target_Level=RebuildAll"
	set "DKLINK=Static"

	set "CMAKE_ARGS="
	if /i "%Target_Type%" equ "Debug"		(%dk_call% dk_appendArgs CMAKE_ARGS -DDEBUG=ON)
	if /i "%Target_Type%" equ "Release"		(%dk_call% dk_appendArgs CMAKE_ARGS -DRELEASE=ON)
	if /i "%Target_Type%" equ "All"			(%dk_call% dk_appendArgs CMAKE_ARGS -DDEBUG=ON) && (%dk_call% dk_appendArgs CMAKE_ARGS -DRELEASE=ON)
	if /i "%Target_Level%" equ "Build"		(%dk_call% dk_appendArgs CMAKE_ARGS -DBUILD=ON)
	if /i "%Target_Level%" equ "Rebuild"	(%dk_call% dk_appendArgs CMAKE_ARGS -DREBUILD=ON)
	if /i "%Target_Level%" equ "RebuildAll"	(%dk_call% dk_appendArgs CMAKE_ARGS -DREBUILDALL=ON)
	if /i "%DKLINK%" equ "Static"			(%dk_call% dk_appendArgs CMAKE_ARGS -DSTATIC=ON)
	if /i "%DKLINK%" equ "Shared"			(%dk_call% dk_appendArgs CMAKE_ARGS -DSHARED=OFF)
	::if "%Target_Tuple%==emscripten" 		(%dk_call% dk_appendArgs CMAKE_ARGS -DEMSCRIPTEN=ON)

	%dk_call% dk_validate DKCMAKE_FUNCTIONS_DIR_ "%dk_call% dk_DKBRANCH_DIR"
	set "DKCMAKE_FUNCTIONS_DIR_=!DKCMAKE_FUNCTIONS_DIR_:\=/!"   
	%dk_call% dk_appendArgs CMAKE_ARGS -DDKCMAKE_FUNCTIONS_DIR_=%DKCMAKE_FUNCTIONS_DIR_%

	::############ CMake Options ############
	%dk_call% dk_appendArgs CMAKE_ARGS -DCMAKE_VERBOSE_MAKEFILE=1
	::%dk_call% dk_appendArgs CMAKE_ARGS -DCMAKE_COLOR_DIAGNOSTICS=ON
	%dk_call% dk_appendArgs CMAKE_ARGS -Wdev
	::%dk_call% dk_appendArgs CMAKE_ARGS -Werror=dev
	%dk_call% dk_appendArgs CMAKE_ARGS -Wdeprecated
	::%dk_call% dk_appendArgs CMAKE_ARGS -Werror=deprecated
	::%dk_call% dk_appendArgs CMAKE_ARGS --graphviz=graphviz.txt
	::%dk_call% dk_appendArgs CMAKE_ARGS --system-information system_information.txt
	%dk_call% dk_appendArgs CMAKE_ARGS --debug-trycompile
	::%dk_call% dk_appendArgs CMAKE_ARGS --debug-output
	::%dk_call% dk_appendArgs CMAKE_ARGS --trace
	::%dk_call% dk_appendArgs CMAKE_ARGS --trace-expand
	::%dk_call% dk_appendArgs CMAKE_ARGS --warn-uninitialized
	::%dk_call% dk_appendArgs CMAKE_ARGS --warn-unused-vars
	::%dk_call% dk_appendArgs CMAKE_ARGS --check-system-vars

	if /i "%Target_Tuple%" equ "Cosmopolitan"			(%dk_call% dk_prependArgs CMAKE_ARGS -DCOSMOPOLITAN=1)
	if /i "%Target_Tuple%" equ "Win_Arm64_Clang"		(%dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=CLANGARM64)
	if /i "%Target_Tuple%" equ "Win_x86_Clang"			(%dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=CLANG32)
	if /i "%Target_Tuple%" equ "Win_x86_Gcc"			(%dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=MINGW32)
	if /i "%Target_Tuple%" equ "Win_x86_64_Clang"		(%dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=CLANG64)
	if /i "%Target_Tuple%" equ "Win_x86_64_Gcc"			(%dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=MINGW64)
	if /i "%Target_Tuple%" equ "Win_x86_64_Ucrt"		(%dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=UCRT64)
	if /i "%Target_Tuple%" equ "Windows_Arm64_Clang"	(%dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=CLANGARM64)
	if /i "%Target_Tuple%" equ "Windows_x86_Clang"		(%dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=CLANG32)
	if /i "%Target_Tuple%" equ "Windows_x86_Gcc"		(%dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=MINGW32)
	if /i "%Target_Tuple%" equ "Windows_x86_64_Clang"	(%dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=CLANG64)
	if /i "%Target_Tuple%" equ "Windows_x86_64_Gcc"		(%dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=MINGW64)
	if /i "%Target_Tuple%" equ "Windows_x86_64_Ucrt"	(%dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=UCRT64)

	if /i "%Target_Tuple%" equ "Ios_Arm32_Clang"		(set "MULTI_CONFIG=1")
	if /i "%Target_Tuple%" equ "Ios_Arm64_Clang"		(set "MULTI_CONFIG=1")
	if /i "%Target_Tuple%" equ "Iossim_x86_Clang"		(set "MULTI_CONFIG=1")
	if /i "%Target_Tuple%" equ "Iossim_x86_64_Clang"	(set "MULTI_CONFIG=1")
	if /i "%Target_Tuple%" equ "Mac_x86_Clang"			(set "MULTI_CONFIG=1")
	if /i "%Target_Tuple%" equ "Mac_x86_64_Clang"		(set "MULTI_CONFIG=1")
	if /i "%Target_Tuple%" equ "Win_Arm64_Msvc"			(set "MULTI_CONFIG=1")
	if /i "%Target_Tuple%" equ "Win_x86_Msvc"			(set "MULTI_CONFIG=1")
	if /i "%Target_Tuple%" equ "Win_x86_64_Msvc"		(set "MULTI_CONFIG=1")
	if /i "%Target_Tuple%" equ "Windows_Arm64_Msvc"		(set "MULTI_CONFIG=1")
	if /i "%Target_Tuple%" equ "Windows_x86_Msvc"		(set "MULTI_CONFIG=1")
	if /i "%Target_Tuple%" equ "Windows_x86_64_Msvc"	(set "MULTI_CONFIG=1")
	if not defined MULTI_CONFIG							(set "SINGLE_CONFIG=1")

	if /i "%Target_Tuple%" equ "Linux_Arm32_Clang"		(set "WSL_EXE=wsl")
	if /i "%Target_Tuple%" equ "Linux_Arm32_Gcc"		(set "WSL_EXE=wsl")
	if /i "%Target_Tuple%" equ "Linux_Arm64_Clang"		(set "WSL_EXE=wsl")
	if /i "%Target_Tuple%" equ "Linux_Arm64_Gcc"		(set "WSL_EXE=wsl")
	if /i "%Target_Tuple%" equ "Linux_x86_Clang"		(set "WSL_EXE=wsl")
	if /i "%Target_Tuple%" equ "Linux_x86_Gcc"			(set "WSL_EXE=wsl")
	if /i "%Target_Tuple%" equ "Linux_x86_64_Clang"		(set "WSL_EXE=wsl")
	if /i "%Target_Tuple%" equ "Linux_x86_64_Gcc"		(set "WSL_EXE=wsl")

	%dk_call% dk_appendArgs CMAKE_ARGS -S="%CMAKE_SOURCE_DIR%"

	if defined MULTI_CONFIG								(set "CMAKE_BINARY_DIR=%CMAKE_TARGET_PATH%/%Target_Tuple%")
	if defined SINGLE_CONFIG							(set "CMAKE_BINARY_DIR=%CMAKE_TARGET_PATH%/%Target_Tuple%/%Target_Type%")
	%dk_call% dk_assertVar CMAKE_BINARY_DIR
	%dk_call% dk_appendArgs CMAKE_ARGS -B="%CMAKE_BINARY_DIR%"

	if /i "%Target_Tuple%" equ "Cosmopolitan"			(set CMAKE_GENERATOR="MSYS Makefiles")
	if /i "%Target_Tuple%" equ "Android_Arm32_Clang"	(set CMAKE_GENERATOR="Unix Makefiles")
	if /i "%Target_Tuple%" equ "Android_Arm64_Clang"	(set CMAKE_GENERATOR="Unix Makefiles")
	if /i "%Target_Tuple%" equ "Android_X86_Clang"		(set CMAKE_GENERATOR="Unix Makefiles")
	if /i "%Target_Tuple%" equ "Android_X86_64_Clang"	(set CMAKE_GENERATOR="Unix Makefiles")
	if /i "%Target_Tuple%" equ "Emscripten_X86_Clang"	(set CMAKE_GENERATOR="Unix Makefiles")
	if /i "%Target_Tuple%" equ "Ios_Arm32_Clang"		(set CMAKE_GENERATOR="Xcode")
	if /i "%Target_Tuple%" equ "Ios_Arm64_Clang"		(set CMAKE_GENERATOR="Xcode")
	if /i "%Target_Tuple%" equ "Iossim_X86_Clang"		(set CMAKE_GENERATOR="Xcode")
	if /i "%Target_Tuple%" equ "Iossim_X86_64_Clang"	(set CMAKE_GENERATOR="Xcode")
	if /i "%Target_Tuple%" equ "Linux_Arm32_Clang"		(set CMAKE_GENERATOR="Unix Makefiles")
	if /i "%Target_Tuple%" equ "Linux_Arm32_Gcc"		(set CMAKE_GENERATOR="Unix Makefiles")
	if /i "%Target_Tuple%" equ "Linux_Arm64_Clang"		(set CMAKE_GENERATOR="Unix Makefiles")
	if /i "%Target_Tuple%" equ "Linux_Arm64_Gcc"		(set CMAKE_GENERATOR="Unix Makefiles")
	if /i "%Target_Tuple%" equ "Linux_X86_Clang"		(set CMAKE_GENERATOR="Unix Makefiles")
	if /i "%Target_Tuple%" equ "Linux_X86_Gcc"			(set CMAKE_GENERATOR="Unix Makefiles")
	if /i "%Target_Tuple%" equ "Linux_X86_64_Clang"		(set CMAKE_GENERATOR="Unix Makefiles")
	if /i "%Target_Tuple%" equ "Linux_X86_64_Gcc"		(set CMAKE_GENERATOR="Unix Makefiles")
	if /i "%Target_Tuple%" equ "Mac_Arm32_Clang"		(set CMAKE_GENERATOR="Xcode")
	if /i "%Target_Tuple%" equ "Mac_Arm64_Clang"		(set CMAKE_GENERATOR="Xcode")
	if /i "%Target_Tuple%" equ "Mac_X86_Clang"			(set CMAKE_GENERATOR="Xcode")
	if /i "%Target_Tuple%" equ "Mac_X86_64_Clang"		(set CMAKE_GENERATOR="Xcode")
	if /i "%Target_Tuple%" equ "Raspberry_Arm32_Clang"	(set CMAKE_GENERATOR="Unix Makefiles")
	if /i "%Target_Tuple%" equ "Raspberry_Arm32_Gcc"	(set CMAKE_GENERATOR="Unix Makefiles")
	if /i "%Target_Tuple%" equ "Raspberry_Arm64_Clang"	(set CMAKE_GENERATOR="Unix Makefiles")
	if /i "%Target_Tuple%" equ "Raspberry_Arm64_Gcc"	(set CMAKE_GENERATOR="Unix Makefiles")
	if /i "%Target_Tuple%" equ "Win_Arm64_Clang"		(set CMAKE_GENERATOR="MinGW Makefiles")
	if /i "%Target_Tuple%" equ "Win_Arm64_Gcc"			(set CMAKE_GENERATOR="MinGW Makefiles")
	if /i "%Target_Tuple%" equ "Win_Arm64_Msvc"			(set CMAKE_GENERATOR="Visual Studio 17 2022" -A Arm64)
	if /i "%Target_Tuple%" equ "Win_X86_Clang"			(set CMAKE_GENERATOR="MinGW Makefiles")
	if /i "%Target_Tuple%" equ "Win_X86_Gcc"			(set CMAKE_GENERATOR="MinGW Makefiles")
	if /i "%Target_Tuple%" equ "Win_X86_Msvc"			(set CMAKE_GENERATOR="Visual Studio 17 2022" -A Win32)
	if /i "%Target_Tuple%" equ "Win_X86_64"				(set CMAKE_GENERATOR="MinGW Makefiles")
	if /i "%Target_Tuple%" equ "Win_X86_64_Clang"		(set CMAKE_GENERATOR="MinGW Makefiles")
	if /i "%Target_Tuple%" equ "Win_X86_64_Gcc"			(set CMAKE_GENERATOR="MinGW Makefiles")
	if /i "%Target_Tuple%" equ "Win_X86_64_Msvc"		(set CMAKE_GENERATOR="Visual Studio 17 2022" -A x64)
	if /i "%Target_Tuple%" equ "Win_X86_64_Ucrt"		(set CMAKE_GENERATOR="MinGW Makefiles")
	if /i "%Target_Tuple%" equ "Windows_Arm64_Clang"		(set CMAKE_GENERATOR="MinGW Makefiles")
	if /i "%Target_Tuple%" equ "Windows_Arm64_Gcc"			(set CMAKE_GENERATOR="MinGW Makefiles")
	if /i "%Target_Tuple%" equ "Windows_Arm64_Msvc"			(set CMAKE_GENERATOR="Visual Studio 17 2022" -A Arm64)
	if /i "%Target_Tuple%" equ "Windows_X86_Clang"			(set CMAKE_GENERATOR="MinGW Makefiles")
	if /i "%Target_Tuple%" equ "Windows_X86_Gcc"			(set CMAKE_GENERATOR="MinGW Makefiles")
	if /i "%Target_Tuple%" equ "Windows_X86_Msvc"			(set CMAKE_GENERATOR="Visual Studio 17 2022" -A Win32)
	if /i "%Target_Tuple%" equ "Windows_X86_64"				(set CMAKE_GENERATOR="MinGW Makefiles")
	if /i "%Target_Tuple%" equ "Windows_X86_64_Clang"		(set CMAKE_GENERATOR="MinGW Makefiles")
	if /i "%Target_Tuple%" equ "Windows_X86_64_Gcc"			(set CMAKE_GENERATOR="MinGW Makefiles")
	if /i "%Target_Tuple%" equ "Windows_X86_64_Msvc"		(set CMAKE_GENERATOR="Visual Studio 17 2022" -A x64)
	if /i "%Target_Tuple%" equ "Windows_X86_64_Ucrt"		(set CMAKE_GENERATOR="MinGW Makefiles")
	%dk_call% dk_assertVar CMAKE_GENERATOR
	%dk_call% dk_prependArgs CMAKE_ARGS -G %CMAKE_GENERATOR%

:: ###### CMAKE_TOOLCHAIN_FILE ######
:: %dk_call% dk_set TOOLCHAIN "%DKCMAKE_DIR%\toolchains\%Target_Tuple%_toolchain.cmake"
:: %dk_call% dk_assertPath TOOLCHAIN
:: %dk_call% dk_printVar TOOLCHAIN
:: %dk_call% dk_set TOOLCHAIN_FILE "%%TOOLCHAIN:^\=^/%%"
:: if exist %TOOLCHAIN% (%dk_call% dk_appendArgs CMAKE_ARGS -DCMAKE_TOOLCHAIN_FILE=%TOOLCHAIN_FILE%)

:: ###### WSL CMake Fix ######
:: if defined WSLENV; then 
::		%dk_call% dk_chdir "$DKCMAKE_DIR"
::		set -- "$@" "."
::	fi
	::if defined WSL_EXE (
	::	%dk_call% dk_replaceAll "!CMAKE_ARGS!" "C:" "/mnt/c" WSL_CMAKE_ARGS
	::)

	::###### Linux_x86_64 (WSL) ######
	if defined WSL_EXE (%dk_call% dk_replaceAll "!DKSCRIPT_DIR!" "C:" "/mnt/c" DKSCRIPT_DIR)
	if defined WSL_EXE (%WSL_EXE% sh -c "export UPDATE=1 && export Target_App=%Target_App% && export Target_Tuple=%Target_Tuple% && export Target_Type=%Target_Type% && %DKSCRIPT_DIR:\=/%/DKBuilder.sh && exit $(true)")
	if defined WSL_EXE (%return%)

	::###### CMake Configure ######
	%dk_call% dk_validate DKIMPORTS_DIR  "%dk_call% dk_DKIMPORTS_DIR"
	if not defined CMAKE_EXE (call "%DKIMPORTS_DIR%/cmake/DKINSTALL.cmd")
	::%dk_call% dk_validate CMAKE_EXE call "%DKIMPORTS_DIR%/cmake/DKINSTALL.cmd"

	::###### Delete Cmake Cache files ######
	%dk_call% dk_clearCmakeCache "%CMAKE_BINARY_DIR%"

	%dk_call% dk_info "****** CMAKE COMMAND ******"
	echo "%CMAKE_EXE%" %CMAKE_ARGS%

	::############################################
	%dk_call% "%CMAKE_EXE%" %CMAKE_ARGS% && (
		%dk_call% dk_success "CMake Generation Successful"
	) || (
		%dk_call% dk_error "CMake Generation Failed"
	)
	::############################################

	::###### IMPORT VARIABLES ######
	%dk_call% dk_importVars
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_generate
%endfunction%

@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_generate()
::#
::#
:dk_generate
 ::setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_title "Generating %target_app% - %target_triple% - %target_type%"
	%dk_call% dk_echo
	%dk_call% dk_info "##################################################################"
	%dk_call% dk_info "	  Generating %target_app% - %target_triple% - %target_type%"
	%dk_call% dk_info "##################################################################"
	%dk_call% dk_echo

	%dk_call% dk_validate DKCPP_APPS_DIR "%dk_call% dk_DKBRANCH_DIR"
	set "TARGET_PATH=%DKCPP_APPS_DIR%/%target_app%"
	if not exist "%TARGET_PATH%/%target_triple%" (%dk_call% dk_mkdir "%TARGET_PATH%\%target_triple%")
	
	%dk_call% dk_validate DKCMAKE_DIR "%dk_call% dk_DKBRANCH_DIR"
	set "CMAKE_SOURCE_DIR=%DKCMAKE_DIR%"
	set "CMAKE_TARGET_PATH=%TARGET_PATH%"

	::::::::: BUILD CMAKE_ARGS ARRAY :::::::::
	set "target_level=RebuildAll"
	set "DKLINK=Static"

	set "CMAKE_ARGS="
	if "%target_type%" equ "Debug"			(%dk_call% dk_appendArgs CMAKE_ARGS -DDEBUG=ON)
	if "%target_type%" equ "Release"		(%dk_call% dk_appendArgs CMAKE_ARGS -DRELEASE=ON)
	if "%target_type%" equ "All"			(%dk_call% dk_appendArgs CMAKE_ARGS -DDEBUG=ON) && (%dk_call% dk_appendArgs CMAKE_ARGS -DRELEASE=ON)
	if "%target_level%" equ "Build"			(%dk_call% dk_appendArgs CMAKE_ARGS -DBUILD=ON)
	if "%target_level%" equ "Rebuild"		(%dk_call% dk_appendArgs CMAKE_ARGS -DREBUILD=ON)
	if "%target_level%" equ "RebuildAll"	(%dk_call% dk_appendArgs CMAKE_ARGS -DREBUILDALL=ON)
	if "%DKLINK%" equ "Static"				(%dk_call% dk_appendArgs CMAKE_ARGS -DSTATIC=ON)
	if "%DKLINK%" equ "Shared"				(%dk_call% dk_appendArgs CMAKE_ARGS -DSHARED=OFF)
	::if "%target_triple%==emscripten" 		(%dk_call% dk_appendArgs CMAKE_ARGS -DEMSCRIPTEN=ON)

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

	if "%target_triple%" equ "cosmopolitan"			(%dk_call% dk_prependArgs CMAKE_ARGS -DCOSMOPOLITAN=1)
	if "%target_triple%" equ "win_arm64_clang"		(%dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=CLANGARM64)
	if "%target_triple%" equ "win_x86_clang"		(%dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=CLANG32)
	if "%target_triple%" equ "win_x86_gcc"			(%dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=MINGW32)
	if "%target_triple%" equ "win_x86_64_clang"		(%dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=CLANG64)
	if "%target_triple%" equ "win_x86_64_gcc"		(%dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=MINGW64)
	if "%target_triple%" equ "win_x86_64_ucrt"		(%dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=UCRT64)

	if "%target_triple%" equ "ios_arm32_clang"		(set "MULTI_CONFIG=1")
	if "%target_triple%" equ "ios_arm64_clang"		(set "MULTI_CONFIG=1")
	if "%target_triple%" equ "iossim_x86_clang"		(set "MULTI_CONFIG=1")
	if "%target_triple%" equ "iossim_x86_64_clang"	(set "MULTI_CONFIG=1")
	if "%target_triple%" equ "mac_x86_clang"		(set "MULTI_CONFIG=1")
	if "%target_triple%" equ "mac_x86_64_clang"		(set "MULTI_CONFIG=1")
	if "%target_triple%" equ "win_arm64_msvc"		(set "MULTI_CONFIG=1")
	if "%target_triple%" equ "win_x86_msvc"			(set "MULTI_CONFIG=1")
	if "%target_triple%" equ "win_x86_64_msvc"		(set "MULTI_CONFIG=1")
	if not defined MULTI_CONFIG						(set "SINGLE_CONFIG=1")

	if "%target_triple%" equ "linux_arm32_clang"	(set "WSL_EXE=wsl")
	if "%target_triple%" equ "linux_arm32_gcc"		(set "WSL_EXE=wsl")
	if "%target_triple%" equ "linux_arm64_clang"	(set "WSL_EXE=wsl")
	if "%target_triple%" equ "linux_arm64_gcc"		(set "WSL_EXE=wsl")
	if "%target_triple%" equ "linux_x86_clang"		(set "WSL_EXE=wsl")
	if "%target_triple%" equ "linux_x86_gcc"		(set "WSL_EXE=wsl")
	if "%target_triple%" equ "linux_x86_64_clang"	(set "WSL_EXE=wsl")
	if "%target_triple%" equ "linux_x86_64_gcc"		(set "WSL_EXE=wsl")

	%dk_call% dk_appendArgs CMAKE_ARGS -S="%CMAKE_SOURCE_DIR%"

	if defined MULTI_CONFIG							(set "CMAKE_BINARY_DIR=%CMAKE_TARGET_PATH%/%target_triple%")
	if defined SINGLE_CONFIG						(set "CMAKE_BINARY_DIR=%CMAKE_TARGET_PATH%/%target_triple%/%target_type%")
	%dk_call% dk_assertVar CMAKE_BINARY_DIR
	%dk_call% dk_appendArgs CMAKE_ARGS -B="%CMAKE_BINARY_DIR%"

	if "%target_triple%" equ "COSMOPOLITAN"				(set CMAKE_GENERATOR="MSYS Makefiles")
	if "%target_triple%" equ "ANDROID_ARM32_CLANG"		(set CMAKE_GENERATOR="Unix Makefiles")
	if "%target_triple%" equ "ANDROID_ARM64_CLANG"		(set CMAKE_GENERATOR="Unix Makefiles")
	if "%target_triple%" equ "ANDROID_X86_CLANG"		(set CMAKE_GENERATOR="Unix Makefiles")
	if "%target_triple%" equ "ANDROID_X86_64_CLANG"		(set CMAKE_GENERATOR="Unix Makefiles")
	if "%target_triple%" equ "EMSCRIPTEN_X86_CLANG"		(set CMAKE_GENERATOR="Unix Makefiles")
	if "%target_triple%" equ "IOS_ARM32_CLANG"			(set CMAKE_GENERATOR="Xcode")
	if "%target_triple%" equ "IOS_ARM64_CLANG"			(set CMAKE_GENERATOR="Xcode")
	if "%target_triple%" equ "IOSSIM_X86_CLANG"			(set CMAKE_GENERATOR="Xcode")
	if "%target_triple%" equ "IOSSIM_X86_64_CLANG"		(set CMAKE_GENERATOR="Xcode")
	if "%target_triple%" equ "LINUX_ARM32_CLANG"		(set CMAKE_GENERATOR="Unix Makefiles")
	if "%target_triple%" equ "LINUX_ARM32_GCC"			(set CMAKE_GENERATOR="Unix Makefiles")
	if "%target_triple%" equ "LINUX_ARM64_CLANG"		(set CMAKE_GENERATOR="Unix Makefiles")
	if "%target_triple%" equ "LINUX_ARM64_GCC"			(set CMAKE_GENERATOR="Unix Makefiles")
	if "%target_triple%" equ "LINUX_X86_CLANG"			(set CMAKE_GENERATOR="Unix Makefiles")
	if "%target_triple%" equ "LINUX_X86_GCC"			(set CMAKE_GENERATOR="Unix Makefiles")
	if "%target_triple%" equ "LINUX_X86_64_CLANG"		(set CMAKE_GENERATOR="Unix Makefiles")
	if "%target_triple%" equ "LINUX_X86_64_GCC"			(set CMAKE_GENERATOR="Unix Makefiles")
	if "%target_triple%" equ "MAC_ARM32_CLANG"			(set CMAKE_GENERATOR="Xcode")
	if "%target_triple%" equ "MAC_ARM64_CLANG"			(set CMAKE_GENERATOR="Xcode")
	if "%target_triple%" equ "MAC_X86_CLANG"			(set CMAKE_GENERATOR="Xcode")
	if "%target_triple%" equ "MAC_X86_64_CLANG"			(set CMAKE_GENERATOR="Xcode")
	if "%target_triple%" equ "RASPBERRY_ARM32_CLANG"	(set CMAKE_GENERATOR="Unix Makefiles")
	if "%target_triple%" equ "RASPBERRY_ARM32_GCC"		(set CMAKE_GENERATOR="Unix Makefiles")
	if "%target_triple%" equ "RASPBERRY_ARM64_CLANG"	(set CMAKE_GENERATOR="Unix Makefiles")
	if "%target_triple%" equ "RASPBERRY_ARM64_GCC"		(set CMAKE_GENERATOR="Unix Makefiles")
	if "%target_triple%" equ "WIN_ARM64_CLANG"			(set CMAKE_GENERATOR="MinGW Makefiles")
	if "%target_triple%" equ "WIN_ARM64_GCC"			(set CMAKE_GENERATOR="MinGW Makefiles")
	if "%target_triple%" equ "WIN_ARM64_MSVC"			(set CMAKE_GENERATOR="Visual Studio 17 2022" -A arm64)
	if "%target_triple%" equ "WIN_X86_CLANG"			(set CMAKE_GENERATOR="MinGW Makefiles")
	if "%target_triple%" equ "WIN_X86_GCC"				(set CMAKE_GENERATOR="MinGW Makefiles")
	if "%target_triple%" equ "WIN_X86_MSVC"				(set CMAKE_GENERATOR="Visual Studio 17 2022" -A Win32)
	if "%target_triple%" equ "WIN_X86_64"				(set CMAKE_GENERATOR="MinGW Makefiles")
	if "%target_triple%" equ "WIN_X86_64_CLANG"			(set CMAKE_GENERATOR="MinGW Makefiles")
	if "%target_triple%" equ "WIN_X86_64_GCC"			(set CMAKE_GENERATOR="MinGW Makefiles")
	if "%target_triple%" equ "WIN_X86_64_MSVC"			(set CMAKE_GENERATOR="Visual Studio 17 2022" -A x64)
	if "%target_triple%" equ "WIN_X86_64_UCRT"			(set CMAKE_GENERATOR="MinGW Makefiles")
	%dk_call% dk_assertVar CMAKE_GENERATOR
	%dk_call% dk_prependArgs CMAKE_ARGS -G %CMAKE_GENERATOR%

:: ###### CMAKE_TOOLCHAIN_FILE ######
:: %dk_call% dk_set TOOLCHAIN "%DKCMAKE_DIR%\toolchains\%target_triple%_toolchain.cmake"
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

	::###### linux_x86_64 (WSL) ######
	if defined WSL_EXE (%dk_call% dk_replaceAll "!DKSCRIPT_DIR!" "C:" "/mnt/c" DKSCRIPT_DIR)
	if defined WSL_EXE (%WSL_EXE% sh -c "export UPDATE=1 && export target_app=%target_app% && export target_triple=%target_triple% && export target_type=%target_type% && %DKSCRIPT_DIR:\=/%/DKBuilder.sh && exit $(true)")
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
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_generate
%endfunction%

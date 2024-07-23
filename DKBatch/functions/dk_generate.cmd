@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

call dk_source dk_setTitle
::####################################################################
::# dk_generate()
::#
::#
:dk_generate
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	
    call dk_setTitle Generating %APP% - %TARGET_OS% - %TYPE% - %LEVEL% . . .
    call dk_echo
	call dk_info "##################################################################"
	call dk_info "      Generating %APP% - %TARGET_OS% - %TYPE% - %LEVEL%"
	call dk_info "##################################################################"
	call dk_echo
    
    call dk_clearCmakeCache
    call dk_deleteTempFiles
    
    ::if "%TARGET_PATH%"=="" set "TARGET_PATH=%DKAPPS_DIR%\%APP%"
    set "TARGET_PATH=%DKAPPS_DIR%\%APP%"
    ::call dk_printVar TARGET_PATH
    if not exist "%TARGET_PATH%\%TARGET_OS%" call dk_makeDirectory "%TARGET_PATH%\%TARGET_OS%"
    ::cd "%TARGET_PATH%\%TARGET_OS%"
    call set "CMAKE_SOURCE_DIR=%%DKCMAKE_DIR:^\=^/%%"			&:: FIXME: remove the need for call here
    ::call dk_printVar CMAKE_SOURCE_DIR							
    call set "CMAKE_TARGET_PATH=%%TARGET_PATH:^\=^/%%"			&:: FIXME: remove the need for call here
    ::call dk_printVar CMAKE_TARGET_PATH
        
    ::::::::: BUILD CMAKE_ARGS ARRAY :::::::::
    set "DKLEVEL=RebuildAll"
    set "DKLINK=Static"

    set "CMAKE_ARGS="
    ::if "%TYPE%"=="Debug"           call dk_appendArgs CMAKE_ARGS -DDEBUG=ON & call dk_appendArgs CMAKE_ARGS -DRELEASE=OFF
    if "%TYPE%"=="Debug"             call dk_appendArgs CMAKE_ARGS -DDEBUG=ON
	::if "%TYPE%"=="Release"         call dk_appendArgs CMAKE_ARGS -DDEBUG=OFF & call dk_appendArgs CMAKE_ARGS -DRELEASE=ON
    if "%TYPE%"=="Release"           call dk_appendArgs CMAKE_ARGS -DRELEASE=ON
    if "%TYPE%"=="All"               call dk_appendArgs CMAKE_ARGS -DDEBUG=ON & call dk_appendArgs CMAKE_ARGS -DRELEASE=ON
    if "%DKLEVEL%"=="Build"          call dk_appendArgs CMAKE_ARGS -DBUILD=ON
    if "%DKLEVEL%"=="Rebuild"        call dk_appendArgs CMAKE_ARGS -DREBUILD=ON
    if "%DKLEVEL%"=="RebuildAll"     call dk_appendArgs CMAKE_ARGS -DREBUILDALL=ON
    if "%DKLINK%"=="Static"          call dk_appendArgs CMAKE_ARGS -DSTATIC=ON
    if "%DKLINK%"=="Shared"          call dk_appendArgs CMAKE_ARGS -DSHARED=OFF
    ::if "%TARGET_OS%==emscripten" call dk_appendArgs CMAKE_ARGS -DEMSCRIPTEN=ON
	
    set "CMAKE_BINARY_DIR=%CMAKE_TARGET_PATH%/%TARGET_OS%/%TYPE%"
    ::call dk_printVar CMAKE_BINARY_DIR
        
    call dk_appendArgs CMAKE_ARGS -S=%CMAKE_SOURCE_DIR%
    call dk_appendArgs CMAKE_ARGS -B=%CMAKE_BINARY_DIR%

    ::############ CMake Options ############
    ::call dk_appendArgs CMAKE_ARGS -DCMAKE_VERBOSE_MAKEFILE=1
    ::call dk_appendArgs CMAKE_ARGS -DCMAKE_COLOR_DIAGNOSTICS=ON
    call dk_appendArgs CMAKE_ARGS -Wdev
    ::call dk_appendArgs CMAKE_ARGS -Werror=dev
    call dk_appendArgs CMAKE_ARGS -Wdeprecated
    ::call dk_appendArgs CMAKE_ARGS -Werror=deprecated
    ::call dk_appendArgs CMAKE_ARGS --graphviz=graphviz.txt
    ::call dk_appendArgs CMAKE_ARGS --system-information system_information.txt
    ::call dk_appendArgs CMAKE_ARGS --debug-trycompile
    ::call dk_appendArgs CMAKE_ARGS --debug-output
    ::call dk_appendArgs CMAKE_ARGS --trace
    ::call dk_appendArgs CMAKE_ARGS --trace-expand
    ::call dk_appendArgs CMAKE_ARGS --warn-uninitialized
    call dk_appendArgs CMAKE_ARGS --warn-unused-vars
    ::call dk_appendArgs CMAKE_ARGS --check-system-vars
	
	if "%TARGET_OS%"=="win_arm64_clang"    call dk_prependArgs CMAKE_ARGS -DMSYSTEM=CLANGARM64
	if "%TARGET_OS%"=="win_x86_clang"      call dk_prependArgs CMAKE_ARGS -DMSYSTEM=CLANG32
	if "%TARGET_OS%"=="win_x86_mingw"      call dk_prependArgs CMAKE_ARGS -DMSYSTEM=MINGW32
	if "%TARGET_OS%"=="win_x86_64_clang"   call dk_prependArgs CMAKE_ARGS -DMSYSTEM=CLANG64
	if "%TARGET_OS%"=="win_x86_64_mingw"   call dk_prependArgs CMAKE_ARGS -DMSYSTEM=MINGW64
	if "%TARGET_OS%"=="win_x86_64_ucrt"    call dk_prependArgs CMAKE_ARGS -DMSYSTEM=UCRT64
	
	if "%TARGET_OS%"=="android_arm32"      call dk_prependArgs CMAKE_ARGS -G "Unix Makefiles"
	if "%TARGET_OS%"=="android_arm64"      call dk_prependArgs CMAKE_ARGS -G "Unix Makefiles"
	if "%TARGET_OS%"=="emscripten"         call dk_prependArgs CMAKE_ARGS -G "Unix Makefiles"	
	if "%TARGET_OS%"=="ios_arm32"          call dk_prependArgs CMAKE_ARGS -G "Xcode"
	if "%TARGET_OS%"=="ios_arm64"          call dk_prependArgs CMAKE_ARGS -G "Xcode"
	if "%TARGET_OS%"=="iossim_x86"         call dk_prependArgs CMAKE_ARGS -G "Xcode"
	if "%TARGET_OS%"=="iossim_x86_64"      call dk_prependArgs CMAKE_ARGS -G "Xcode"
	if "%TARGET_OS%"=="linux_x86"          call dk_prependArgs CMAKE_ARGS -G "Unix Makefiles"
	if "%TARGET_OS%"=="linux_x86_64"       call dk_prependArgs CMAKE_ARGS -G "Unix Makefiles"
	if "%TARGET_OS%"=="mac_x86"            call dk_prependArgs CMAKE_ARGS -G "Xcode"
	if "%TARGET_OS%"=="mac_x86_64"         call dk_prependArgs CMAKE_ARGS -G "Xcode"
	if "%TARGET_OS%"=="raspberry_arm32"    call dk_prependArgs CMAKE_ARGS -G "Unix Makefiles"
	if "%TARGET_OS%"=="raspberry_arm64"    call dk_prependArgs CMAKE_ARGS -G "Unix Makefiles"
	if "%TARGET_OS%"=="win_arm64_clang"    call dk_prependArgs CMAKE_ARGS -G "MinGW Makefiles"
	if "%TARGET_OS%"=="win_x86_clang"      call dk_prependArgs CMAKE_ARGS -G "MinGW Makefiles"
	if "%TARGET_OS%"=="win_x86_mingw"      call dk_prependArgs CMAKE_ARGS -G "MinGW Makefiles"
	if "%TARGET_OS%"=="win_x86_64_clang"   call dk_prependArgs CMAKE_ARGS -G "MinGW Makefiles"
	if "%TARGET_OS%"=="win_x86_64_mingw"   call dk_prependArgs CMAKE_ARGS -G "MinGW Makefiles"
	if "%TARGET_OS%"=="win_x86_64_ucrt"    call dk_prependArgs CMAKE_ARGS -G "MinGW Makefiles"
	if "%TARGET_OS%"=="win_x86_64_msvc"    call dk_prependArgs CMAKE_ARGS -G "Visual Studio 17 2022"

::	###### CMAKE_TOOLCHAIN_FILE ######
::	call dk_set TOOLCHAIN "%DKCMAKE_DIR%\toolchains\%TARGET_OS%_toolchain.cmake"
::	call dk_assertPath TOOLCHAIN
::	call dk_printVar TOOLCHAIN
::	call dk_set TOOLCHAIN_FILE "%%TOOLCHAIN:^\=^/%%"
::	if exist %TOOLCHAIN% call dk_appendArgs CMAKE_ARGS -DCMAKE_TOOLCHAIN_FILE=%TOOLCHAIN_FILE%
    
	
::	###### WSL CMake Fix ######
::  if defined WSLENV; then 
::		cd "$DKCMAKE_DIR"
::		set -- "$@" "."
::	fi
	
::	###### CMake Configure ######
	if not defined CMAKE_EXE call "%DKIMPORTS_DIR%\cmake\dk_installCmake.cmd"
	
    call dk_info "****** CMAKE COMMAND ******"
    echo "%CMAKE_EXE%" %CMAKE_ARGS%
    call "%CMAKE_EXE%" %CMAKE_ARGS% && call dk_echo "CMake Generation Successful" || call dk_error "CMake Generation Failed"
goto:eof



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_generate
goto:eof

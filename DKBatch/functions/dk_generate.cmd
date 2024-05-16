@echo off
call DK

::####################################################################
::# dk_generate()
::#
::#
:dk_generate () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
    TITLE DigitalKnob - Generating %APP% - %TARGET_OS% - %TYPE% - %LEVEL% . . .
    call dk_echo
	call dk_info "##################################################################"
	call dk_info "      Generating %APP% - %TARGET_OS% - %TYPE% - %LEVEL%"
	call dk_info "##################################################################"
	call dk_echo
    
    call dk_deleteCache
    call dk_deleteTempFiles
    
    ::if "%TARGET_PATH%"=="" set "TARGET_PATH=%DKAPPS_DIR%\%APP%"
    set "TARGET_PATH=%DKAPPS_DIR%\%APP%"
    call dk_printVar TARGET_PATH
    call dk_makeDirectory "%TARGET_PATH%\%TARGET_OS%"
    ::cd "%TARGET_PATH%\%TARGET_OS%"
    call set "CMAKE_SOURCE_DIR=%%DKCMAKE_DIR:^\=^/%%"
    call dk_printVar CMAKE_SOURCE_DIR
    call set "CMAKE_TARGET_PATH=%%TARGET_PATH:^\=^/%%"
    call dk_printVar CMAKE_TARGET_PATH
        
    ::::::::: BUILD CMAKE_ARGS ARRAY :::::::::
    set "DKLEVEL=RebuildAll"
    set "DKLINK=Static"

    set "CMAKE_ARGS="
    ::if "%TYPE%"=="Debug"           call dk_appendCmakeArgs -DDEBUG=ON & call dk_appendCmakeArgs -DRELEASE=OFF
    if "%TYPE%"=="Debug"             call dk_appendCmakeArgs -DDEBUG=ON
    ::if "%TYPE%"=="Release"         call dk_appendCmakeArgs -DDEBUG=OFF & call dk_appendCmakeArgs -DRELEASE=ON
    if "%TYPE%"=="Release"           call dk_appendCmakeArgs -DRELEASE=ON
    if "%TYPE%"=="All"               call dk_appendCmakeArgs -DDEBUG=ON & call dk_appendCmakeArgs -DRELEASE=ON
    if "%DKLEVEL%"=="Build"          call dk_appendCmakeArgs -DBUILD=ON
    if "%DKLEVEL%"=="Rebuild"        call dk_appendCmakeArgs -DREBUILD=ON
    if "%DKLEVEL%"=="RebuildAll"     call dk_appendCmakeArgs -DREBUILDALL=ON
    if "%DKLINK%"=="Static"          call dk_appendCmakeArgs -DSTATIC=ON
    if "%DKLINK%"=="Shared"          call dk_appendCmakeArgs -DSHARED=ON
    ::if "%TARGET_OS%==emscripten" call dk_appendCmakeArgs -DEMSCRIPTEN=ON
        
    set "CMAKE_BINARY_DIR=%CMAKE_TARGET_PATH%/%TARGET_OS%/%TYPE%"
    call dk_printVar CMAKE_BINARY_DIR
        
    call dk_appendCmakeArgs -S=%CMAKE_SOURCE_DIR%
    call dk_appendCmakeArgs -B=%CMAKE_BINARY_DIR%

    ::############ CMake Options ############
    ::call dk_appendCmakeArgs -DCMAKE_VERBOSE_MAKEFILE=1
    ::call dk_appendCmakeArgs -DCMAKE_COLOR_DIAGNOSTICS=ON
    call dk_appendCmakeArgs -Wdev
    ::call dk_appendCmakeArgs -Werror=dev
    call dk_appendCmakeArgs -Wdeprecated
    ::call dk_appendCmakeArgs -Werror=deprecated
    ::call dk_appendCmakeArgs --graphviz=graphviz.txt
    ::call dk_appendCmakeArgs --system-information system_information.txt
    ::call dk_appendCmakeArgs --debug-trycompile
    ::call dk_appendCmakeArgs --debug-output
    ::call dk_appendCmakeArgs --trace
    ::call dk_appendCmakeArgs --trace-expand
    ::call dk_appendCmakeArgs --warn-uninitialized
    call dk_appendCmakeArgs --warn-unused-vars
    ::call dk_appendCmakeArgs --check-system-vars
	
	if "%TARGET_OS%"=="android_arm32"      call dk_prependCmakeArgs -G Unix Makefiles
	if "%TARGET_OS%"=="android_arm64"      call dk_prependCmakeArgs -G Unix Makefiles
	if "%TARGET_OS%"=="emscripten"         call dk_prependCmakeArgs -G Unix Makefiles	
	if "%TARGET_OS%"=="ios_arm32"          call dk_prependCmakeArgs -G Xcode
	if "%TARGET_OS%"=="ios_arm64"          call dk_prependCmakeArgs -G Xcode
	if "%TARGET_OS%"=="iossim_x86"         call dk_prependCmakeArgs -G Xcode
	if "%TARGET_OS%"=="iossim_x86_64"      call dk_prependCmakeArgs -G Xcode
	if "%TARGET_OS%"=="linux_x86"          call dk_prependCmakeArgs -G Unix Makefiles
	if "%TARGET_OS%"=="linux_x86_64"       call dk_prependCmakeArgs -G Unix Makefiles
	if "%TARGET_OS%"=="mac_x86"            call dk_prependCmakeArgs -G Xcode
	if "%TARGET_OS%"=="mac_x86_64"         call dk_prependCmakeArgs -G Xcode
	if "%TARGET_OS%"=="raspberry_arm32"    call dk_prependCmakeArgs -G Unix Makefiles
	if "%TARGET_OS%"=="raspberry_arm64"    call dk_prependCmakeArgs -G Unix Makefiles
	if "%TARGET_OS%"=="win_arm64_clang"    call dk_prependCmakeArgs -G MinGW Makefiles
	if "%TARGET_OS%"=="win_x86_clang"      call dk_prependCmakeArgs -G MinGW Makefiles
	if "%TARGET_OS%"=="win_x86_mingw"      call dk_prependCmakeArgs -G MinGW Makefiles
	if "%TARGET_OS%"=="win_x86_64_clang"   call dk_prependCmakeArgs -G MinGW Makefiles
	if "%TARGET_OS%"=="win_x86_64_mingw"   call dk_prependCmakeArgs -G MinGW Makefiles
	if "%TARGET_OS%"=="win_x86_64_ucrt"    call dk_prependCmakeArgs -G MinGW Makefiles
	
::	###### CMAKE_TOOLCHAIN_FILE ######
::	set "TOOLCHAIN=%DKCMAKE_DIR%\toolchains\%TARGET_OS%_toolchain.cmake"
::	call dk_printVar TOOLCHAIN
::	set "TOOLCHAIN_FILE=%%TOOLCHAIN:^\=^/%%"
::	if exist %TOOLCHAIN% call dk_appendCmakeArgs -DCMAKE_TOOLCHAIN_FILE=%TOOLCHAIN_FILE%
    
	
::	###### WSL CMake Fix ######
::  if defined WSLENV; then 
::		cd "$DKCMAKE_DIR"
::		set -- "$@" "."
::	fi
	
::	###### CMake Configure ######
	call %DKIMPORTS_DIR%\cmake\dk_InstallCmake
	
    call dk_echo
    call dk_info "****** CMAKE COMMAND ******"
    call dk_debug ""%CMAKE_EXE%" %CMAKE_ARGS%"
    "%CMAKE_EXE%" %CMAKE_ARGS%
    call dk_echo
goto:eof



:DKTEST ########################################################################

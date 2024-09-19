@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_generate()
::#
::#
:dk_generate
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_setTitle Generating %APP% - %TARGET_OS% - %TYPE% - %LEVEL% . . .
    %dk_call% dk_echo
    %dk_call% dk_info "##################################################################"
    %dk_call% dk_info "      Generating %APP% - %TARGET_OS% - %TYPE% - %LEVEL%"
    %dk_call% dk_info "##################################################################"
    %dk_call% dk_echo
    
    %dk_call% dk_clearCmakeCache
    %dk_call% dk_deleteTempFiles
    
    ::if "%TARGET_PATH%"=="" set "TARGET_PATH=%DKAPPS_DIR%\%APP%"
    set "TARGET_PATH=%DKAPPS_DIR%\%APP%"
    if not exist "%TARGET_PATH%\%TARGET_OS%" %dk_call% dk_makeDirectory "%TARGET_PATH%\%TARGET_OS%"
    ::call set "CMAKE_SOURCE_DIR=%%DKCMAKE_DIR:^\=^/%%"         &:: FIXME: remove the need for call here
    set "CMAKE_SOURCE_DIR=!DKCMAKE_DIR:\=/!"                    
    ::call set "CMAKE_TARGET_PATH=%TARGET_PATH:^\=^/%"          &:: FIXME: remove the need for call here
    set "CMAKE_TARGET_PATH=!TARGET_PATH:\=/!"   
        
    ::::::::: BUILD CMAKE_ARGS ARRAY :::::::::
    set "DKLEVEL=RebuildAll"
    set "DKLINK=Static"

    set "CMAKE_ARGS="
    ::if "%TYPE%"=="Debug"           %dk_call% dk_appendArgs CMAKE_ARGS -DDEBUG=ON & %dk_call% dk_appendArgs CMAKE_ARGS -DRELEASE=OFF
    if "%TYPE%"=="Debug"             %dk_call% dk_appendArgs CMAKE_ARGS -DDEBUG=ON
    ::if "%TYPE%"=="Release"         %dk_call% dk_appendArgs CMAKE_ARGS -DDEBUG=OFF & %dk_call% dk_appendArgs CMAKE_ARGS -DRELEASE=ON
    if "%TYPE%"=="Release"           %dk_call% dk_appendArgs CMAKE_ARGS -DRELEASE=ON
    if "%TYPE%"=="All"               %dk_call% dk_appendArgs CMAKE_ARGS -DDEBUG=ON & %dk_call% dk_appendArgs CMAKE_ARGS -DRELEASE=ON
    if "%DKLEVEL%"=="Build"          %dk_call% dk_appendArgs CMAKE_ARGS -DBUILD=ON
    if "%DKLEVEL%"=="Rebuild"        %dk_call% dk_appendArgs CMAKE_ARGS -DREBUILD=ON
    if "%DKLEVEL%"=="RebuildAll"     %dk_call% dk_appendArgs CMAKE_ARGS -DREBUILDALL=ON
    if "%DKLINK%"=="Static"          %dk_call% dk_appendArgs CMAKE_ARGS -DSTATIC=ON
    if "%DKLINK%"=="Shared"          %dk_call% dk_appendArgs CMAKE_ARGS -DSHARED=OFF
    ::if "%TARGET_OS%==emscripten" %dk_call% dk_appendArgs CMAKE_ARGS -DEMSCRIPTEN=ON

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
    %dk_call% dk_appendArgs CMAKE_ARGS --warn-unused-vars
    ::%dk_call% dk_appendArgs CMAKE_ARGS --check-system-vars
    
    if "%TARGET_OS%"=="win_arm64_clang"    %dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=CLANGARM64
    if "%TARGET_OS%"=="win_x86_clang"      %dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=CLANG32
    if "%TARGET_OS%"=="win_x86_mingw"      %dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=MINGW32
    if "%TARGET_OS%"=="win_x86_64_clang"   %dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=CLANG64
    if "%TARGET_OS%"=="win_x86_64_mingw"   %dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=MINGW64
    if "%TARGET_OS%"=="win_x86_64_ucrt"    %dk_call% dk_prependArgs CMAKE_ARGS -DMSYSTEM=UCRT64
   
	if "%TARGET_OS%"=="ios_arm32"          set "MULTI_CONFIG=1"
	if "%TARGET_OS%"=="ios_arm64"          set "MULTI_CONFIG=1"
    if "%TARGET_OS%"=="iossim_x86"         set "MULTI_CONFIG=1"
    if "%TARGET_OS%"=="iossim_x86_64"      set "MULTI_CONFIG=1"
	if "%TARGET_OS%"=="mac_x86"            set "MULTI_CONFIG=1"
    if "%TARGET_OS%"=="mac_x86_64"         set "MULTI_CONFIG=1"
	if "%TARGET_OS%"=="win_arm64_msvc"     set "MULTI_CONFIG=1"
	if "%TARGET_OS%"=="win_x86_msvc"       set "MULTI_CONFIG=1"
	if "%TARGET_OS%"=="win_x86_64_msvc"    set "MULTI_CONFIG=1"
	if not defined MULTI_CONFIG            set "SINGLE_CONFIG=1"
	if defined MULTI_CONFIG   set "CMAKE_BINARY_DIR=%CMAKE_TARGET_PATH%/%TARGET_OS%"
	if defined SINGLE_CONFIG  set "CMAKE_BINARY_DIR=%CMAKE_TARGET_PATH%/%TARGET_OS%/%TYPE%"
	if not defined CMAKE_BINARY_DIR  %dk_call% dk_fatal "CMAKE_BINARY_DIR:%CMAKE_BINARY_DIR% is invalid"
	%dk_call% dk_appendArgs CMAKE_ARGS -S="%CMAKE_SOURCE_DIR%"
    %dk_call% dk_appendArgs CMAKE_ARGS -B="%CMAKE_BINARY_DIR%"
	
    if "%TARGET_OS%"=="android_arm32"      %dk_call% dk_prependArgs CMAKE_ARGS -G "Unix Makefiles"
    if "%TARGET_OS%"=="android_arm64"      %dk_call% dk_prependArgs CMAKE_ARGS -G "Unix Makefiles"
    if "%TARGET_OS%"=="android_x86" 	   %dk_call% dk_prependArgs CMAKE_ARGS -G "Unix Makefiles"
	if "%TARGET_OS%"=="android_x86_64"     %dk_call% dk_prependArgs CMAKE_ARGS -G "Unix Makefiles"
    if "%TARGET_OS%"=="emscripten"         %dk_call% dk_prependArgs CMAKE_ARGS -G "Unix Makefiles"  
    if "%TARGET_OS%"=="ios_arm32"          %dk_call% dk_prependArgs CMAKE_ARGS -G "Xcode"
    if "%TARGET_OS%"=="ios_arm64"          %dk_call% dk_prependArgs CMAKE_ARGS -G "Xcode"
    if "%TARGET_OS%"=="iossim_x86"         %dk_call% dk_prependArgs CMAKE_ARGS -G "Xcode"
    if "%TARGET_OS%"=="iossim_x86_64"      %dk_call% dk_prependArgs CMAKE_ARGS -G "Xcode"
    if "%TARGET_OS%"=="linux_x86"          %dk_call% dk_prependArgs CMAKE_ARGS -G "Unix Makefiles"
    if "%TARGET_OS%"=="linux_x86_64"       %dk_call% dk_prependArgs CMAKE_ARGS -G "Unix Makefiles"
    if "%TARGET_OS%"=="mac_x86"            %dk_call% dk_prependArgs CMAKE_ARGS -G "Xcode"
    if "%TARGET_OS%"=="mac_x86_64"         %dk_call% dk_prependArgs CMAKE_ARGS -G "Xcode"
    if "%TARGET_OS%"=="raspberry_arm32"    %dk_call% dk_prependArgs CMAKE_ARGS -G "Unix Makefiles"
    if "%TARGET_OS%"=="raspberry_arm64"    %dk_call% dk_prependArgs CMAKE_ARGS -G "Unix Makefiles"
    if "%TARGET_OS%"=="win_arm64_clang"    %dk_call% dk_prependArgs CMAKE_ARGS -G "MinGW Makefiles"
	if "%TARGET_OS%"=="win_arm64_msvc"     %dk_call% dk_prependArgs CMAKE_ARGS -G "Visual Studio 17 2022" -A ARM64
	if "%TARGET_OS%"=="win_x86_clang"      %dk_call% dk_prependArgs CMAKE_ARGS -G "MinGW Makefiles"
    if "%TARGET_OS%"=="win_x86_mingw"      %dk_call% dk_prependArgs CMAKE_ARGS -G "MinGW Makefiles"
	if "%TARGET_OS%"=="win_x86_msvc"       %dk_call% dk_prependArgs CMAKE_ARGS -G "Visual Studio 17 2022" -A Win32
    if "%TARGET_OS%"=="win_x86_64_clang"   %dk_call% dk_prependArgs CMAKE_ARGS -G "MinGW Makefiles"
    if "%TARGET_OS%"=="win_x86_64_mingw"   %dk_call% dk_prependArgs CMAKE_ARGS -G "MinGW Makefiles"
    if "%TARGET_OS%"=="win_x86_64_msvc"    %dk_call% dk_prependArgs CMAKE_ARGS -G "Visual Studio 17 2022" -A x64
    if "%TARGET_OS%"=="win_x86_64_ucrt"    %dk_call% dk_prependArgs CMAKE_ARGS -G "MinGW Makefiles"

	
::  ###### CMAKE_TOOLCHAIN_FILE ######
::  %dk_call% dk_set TOOLCHAIN "%DKCMAKE_DIR%\toolchains\%TARGET_OS%_toolchain.cmake"
::  %dk_call% dk_assertPath TOOLCHAIN
::  %dk_call% dk_printVar TOOLCHAIN
::  %dk_call% dk_set TOOLCHAIN_FILE "%%TOOLCHAIN:^\=^/%%"
::  if exist %TOOLCHAIN% %dk_call% dk_appendArgs CMAKE_ARGS -DCMAKE_TOOLCHAIN_FILE=%TOOLCHAIN_FILE%
    
    
::  ###### WSL CMake Fix ######
::  if defined WSLENV; then 
::      cd "$DKCMAKE_DIR"
::      set -- "$@" "."
::  fi
    
::  ###### CMake Configure ######
    if not defined CMAKE_EXE call "%DKIMPORTS_DIR%\cmake\dk_installCmake.cmd"
    
    %dk_call% dk_info "****** CMAKE COMMAND ******"
    echo "%CMAKE_EXE%" %CMAKE_ARGS%
    call "%CMAKE_EXE%" %CMAKE_ARGS% && %dk_call% dk_echo "CMake Generation Successful" || %dk_call% dk_error "CMake Generation Failed"
	
::	###### IMPORT VARIABLES ######
	%dk_call% dk_importVars
	
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_generate
%endfunction%

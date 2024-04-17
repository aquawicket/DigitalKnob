::dk_include_guard()

::####################################################################
::# dk_generate()
::#
::#
:dk_generate () {
	call dk_verbose "dk_generate(%*)"
	
    TITLE DigitalKnob - Generating %APP% - %TARGET_OS% - %TYPE% - %LEVEL% . . .
    echo.
	echo ##################################################################
	echo      Generating %APP% - %TARGET_OS% - %TYPE% - %LEVEL%
	echo ##################################################################
	echo.
    
    call dk_deleteCache
    call dk_delete_temp_files
    
    ::if "%TARGET_PATH%"=="" set "TARGET_PATH=%DKAPPS_DIR%\%APP%"
    set "TARGET_PATH=%DKAPPS_DIR%\%APP%"
    call dk_debug TARGET_PATH
    call dk_make_directory "%TARGET_PATH%\%TARGET_OS%"
    ::cd "%TARGET_PATH%\%TARGET_OS%"
    call set CMAKE_SOURCE_DIR=%%DKCMAKE_DIR:^\=^/%%
    call dk_debug CMAKE_SOURCE_DIR
    call set CMAKE_TARGET_PATH=%%TARGET_PATH:^\=^/%%
    call dk_debug CMAKE_TARGET_PATH
        
    ::::::::: BUILD CMAKE_ARGS ARRAY :::::::::
    set DKLEVEL=RebuildAll
    set DKLINK=Static

    set CMAKE_ARGS=
    ::if %TYPE%==Debug           call dk_append_cmake_args -DDEBUG=ON & call dk_append_cmake_args -DRELEASE=OFF
    if %TYPE%==Debug             call dk_append_cmake_args -DDEBUG=ON
    ::if %TYPE%==Release         call dk_append_cmake_args -DDEBUG=OFF & call dk_append_cmake_args -DRELEASE=ON
    if %TYPE%==Release           call dk_append_cmake_args -DRELEASE=ON
    if %TYPE%==All               call dk_append_cmake_args -DDEBUG=ON & call dk_append_cmake_args -DRELEASE=ON
    if %DKLEVEL%==Build          call dk_append_cmake_args -DBUILD=ON
    if %DKLEVEL%==Rebuild        call dk_append_cmake_args -DREBUILD=ON
    if %DKLEVEL%==RebuildAll     call dk_append_cmake_args -DREBUILDALL=ON
    if %DKLINK%==Static          call dk_append_cmake_args -DSTATIC=ON
    if %DKLINK%==Shared          call dk_append_cmake_args -DSHARED=ON
    ::if %TARGET_OS%==emscripten call dk_append_cmake_args -DEMSCRIPTEN=ON
        
    set CMAKE_BINARY_DIR=%CMAKE_TARGET_PATH%/%TARGET_OS%/%TYPE%
    call dk_debug CMAKE_BINARY_DIR
        
    call dk_append_cmake_args -S=%CMAKE_SOURCE_DIR%
    call dk_append_cmake_args -B=%CMAKE_BINARY_DIR%

    ::############ CMake Options ############
    ::call dk_append_cmake_args -DCMAKE_VERBOSE_MAKEFILE=1
    ::call dk_append_cmake_args -DCMAKE_COLOR_DIAGNOSTICS=ON
    call dk_append_cmake_args -Wdev
    ::call dk_append_cmake_args -Werror=dev
    call dk_append_cmake_args -Wdeprecated
    ::call dk_append_cmake_args -Werror=deprecated
    ::call dk_append_cmake_args --graphviz=graphviz.txt
    ::call dk_append_cmake_args --system-information system_information.txt
    ::call dk_append_cmake_args --debug-trycompile
    ::call dk_append_cmake_args --debug-output
    ::call dk_append_cmake_args --trace
    ::call dk_append_cmake_args --trace-expand
    ::call dk_append_cmake_args --warn-uninitialized
    call dk_append_cmake_args --warn-unused-vars
    ::call dk_append_cmake_args --check-system-vars
	
	if %TARGET_OS%==android_arm32      call dk_prepend_cmake_args -G Unix Makefiles
	if %TARGET_OS%==android_arm64      call dk_prepend_cmake_args -G Unix Makefiles
	if %TARGET_OS%==emscripten         call dk_prepend_cmake_args -G Unix Makefiles	
	if %TARGET_OS%==ios_arm32          call dk_prepend_cmake_args -G Xcode
	if %TARGET_OS%==ios_arm64          call dk_prepend_cmake_args -G Xcode
	if %TARGET_OS%==iossim_x86         call dk_prepend_cmake_args -G Xcode
	if %TARGET_OS%==iossim_x86_64      call dk_prepend_cmake_args -G Xcode
	if %TARGET_OS%==linux_x86          call dk_prepend_cmake_args -G Unix Makefiles
	if %TARGET_OS%==linux_x86_64       call dk_prepend_cmake_args -G Unix Makefiles
	if %TARGET_OS%==mac_x86            call dk_prepend_cmake_args -G Xcode
	if %TARGET_OS%==mac_x86_64         call dk_prepend_cmake_args -G Xcode
	if %TARGET_OS%==raspberry_arm32    call dk_prepend_cmake_args -G Unix Makefiles
	if %TARGET_OS%==raspberry_arm64    call dk_prepend_cmake_args -G Unix Makefiles
	if %TARGET_OS%==win_arm64_clang    call dk_prepend_cmake_args -G MinGW Makefiles
	if %TARGET_OS%==win_x86_clang      call dk_prepend_cmake_args -G MinGW Makefiles
	if %TARGET_OS%==win_x86_mingw      call dk_prepend_cmake_args -G MinGW Makefiles
	if %TARGET_OS%==win_x86_64_clang   call dk_prepend_cmake_args -G MinGW Makefiles
	if %TARGET_OS%==win_x86_64_mingw   call dk_prepend_cmake_args -G MinGW Makefiles
	if %TARGET_OS%==win_x86_64_ucrt    call dk_prepend_cmake_args -G MinGW Makefiles
	
::	###### CMAKE_TOOLCHAIN_FILE ######
::	set TOOLCHAIN=%DKCMAKE_DIR%\toolchains\%TARGET_OS%_toolchain.cmake
::	echo "TOOLCHAIN = %TOOLCHAIN%"
::	set TOOLCHAIN_FILE=%%TOOLCHAIN:^\=^/%%
::	if exist %TOOLCHAIN% call dk_append_cmake_args -DCMAKE_TOOLCHAIN_FILE=%TOOLCHAIN_FILE%
    
	
::	###### WSL CMake Fix ######
::  if dk_defined WSLENV; then 
::		cd "$DKCMAKE_DIR"
::		set -- "$@" "."
::	fi
	
::	###### CMake Configure ######
	call dk_validate_cmake
	
    echo.
    echo ****** CMAKE COMMAND ******
    echo "%CMAKE_EXE%" %CMAKE_ARGS%
    "%CMAKE_EXE%" %CMAKE_ARGS%
    echo.
goto:eof
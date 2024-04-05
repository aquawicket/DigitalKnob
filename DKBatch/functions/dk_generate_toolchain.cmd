::dk_include_guard()

::#################################################################################
:: dk_generate_toolchain()
::
::
:dk_generate_toolchain () {
	call dk_verbose "dk_generate_toolchain(%*)"
	
    set toolchain=%1
    
    :: TODO: we need a good way to pull the CMAKE_GENERATOR from the toolchain files.
    :::::: CMAKE_GENERATOR ::::::
    call dk_string_contains %toolchain% android hasAndroid
    if "%hasAndroid%" == "1" ( 
        set "CMAKE_GENERATOR=Unix Makefiles"
    ) else ( if "%hasAndroid%" NEQ "1" set "CMAKE_GENERATOR=MinGW Makefiles" )
    call dk_add_cmake_arg -G %CMAKE_GENERATOR%
    
    ::::::: CMAKE_TOOLCHAIN_FILE :::::::
    ::call set CMAKE_TOOLCHAIN_FILE=%DKCMAKE_DIR%/toolchains/%1.cmake
    ::call set CMAKE_TOOLCHAIN_FILE=%%CMAKE_TOOLCHAIN_FILE:^\=^/%%
    ::if exist %CMAKE_TOOLCHAIN_FILE% call dk_add_cmake_arg -DCMAKE_TOOLCHAIN_FILE=%CMAKE_TOOLCHAIN_FILE%
    
    ::::::: CMake Configure :::::::
    echo.
    echo ****** CMAKE COMMAND ******
    echo "%CMAKE_EXE%" %CMAKE_ARGS%
    "%CMAKE_EXE%" %CMAKE_ARGS%
    echo.
goto:eof
::dk_include_guard()

::#################################################################################
:: dk_generate()
::
::
:dk_generate
	call dk_verbose "%0(%*)"
	
    TITLE DigitalKnob - Generating %APP% - %TARGET_OS% - %TYPE% - %LEVEL% . . .
    echo.
    echo ########################################################## 
    echo ****** Generating %APP% - %TARGET_OS% - %TYPE% - %LEVEL% ******
    echo ##########################################################
    echo.
    
    call dk_deleteCache
    call dk_delete_temp_files
    
    ::if "%TARGET_PATH%"=="" set "TARGET_PATH=%DKAPPS_DIR%\%APP%"
    set "TARGET_PATH=%DKAPPS_DIR%\%APP%"
    call dk_print_var TARGET_PATH
    call dk_make_directory "%TARGET_PATH%\%TARGET_OS%"
    ::cd "%TARGET_PATH%\%TARGET_OS%"
    call set CMAKE_SOURCE_DIR=%%DKCMAKE_DIR:^\=^/%%
    call dk_print_var CMAKE_SOURCE_DIR
    call set CMAKE_TARGET_PATH=%%TARGET_PATH:^\=^/%%
    call dk_print_var CMAKE_TARGET_PATH
        
    ::::::::: BUILD CMAKE_ARGS ARRAY :::::::::
    set DKLEVEL=RebuildAll
    set DKLINK=Static

    set CMAKE_ARGS=
    ::if %TYPE%==Debug            call dk_add_cmake_arg -DDEBUG=ON & call dk_add_cmake_arg -DRELEASE=OFF
    if %TYPE%==Debug            call dk_add_cmake_arg -DDEBUG=ON
    ::if %TYPE%==Release          call dk_add_cmake_arg -DDEBUG=OFF & call dk_add_cmake_arg -DRELEASE=ON
    if %TYPE%==Release          call dk_add_cmake_arg -DRELEASE=ON
    if %TYPE%==All              call dk_add_cmake_arg -DDEBUG=ON & call dk_add_cmake_arg -DRELEASE=ON
    if %DKLEVEL%==Build         call dk_add_cmake_arg -DBUILD=ON
    if %DKLEVEL%==Rebuild       call dk_add_cmake_arg -DREBUILD=ON
    if %DKLEVEL%==RebuildAll    call dk_add_cmake_arg -DREBUILDALL=ON
    if %DKLINK%==Static         call dk_add_cmake_arg -DSTATIC=ON
    if %DKLINK%==Shared         call dk_add_cmake_arg -DSHARED=ON
    ::if %TARGET_OS%==emscripten    call dk_add_cmake_arg -DEMSCRIPTEN=ON
        
    set CMAKE_BINARY_DIR=%CMAKE_TARGET_PATH%/%TARGET_OS%/%TYPE%
    call dk_print_var CMAKE_BINARY_DIR
        
    call dk_add_cmake_arg -S=%CMAKE_SOURCE_DIR%
    call dk_add_cmake_arg -B=%CMAKE_BINARY_DIR%

    :::::::::::: CMake Options :::::::::::::
    ::call dk_add_cmake_arg -DCMAKE_VERBOSE_MAKEFILE=1
    ::call dk_add_cmake_arg -DCMAKE_COLOR_DIAGNOSTICS=ON
    call dk_add_cmake_arg -Wdev
    ::call dk_add_cmake_arg -Werror=dev
    call dk_add_cmake_arg -Wdeprecated
    ::call dk_add_cmake_arg -Werror=deprecated
    ::call dk_add_cmake_arg --graphviz=graphviz.txt
    ::call dk_add_cmake_arg --system-information system_information.txt
    call dk_add_cmake_arg --debug-trycompile
    ::call dk_add_cmake_arg --debug-output
    ::call dk_add_cmake_arg --trace
    ::call dk_add_cmake_arg --trace-expand
    ::call dk_add_cmake_arg --warn-uninitialized
    call dk_add_cmake_arg --warn-unused-vars
    ::call dk_add_cmake_arg --check-system-vars
goto:eof
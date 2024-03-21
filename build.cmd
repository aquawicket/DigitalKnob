::############ DigitalKnob builder script ############
@echo off
setlocal EnableDelayedExpansion

::### keep window open ###
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )


::### call and arguments passed in ###
::if "%*" NEQ "" echo %%^* = %*
if "%*" NEQ "" call %* 

        
:: https://stackoverflow.com/a/4095133/688352

::--------------------------------------------------------
:: convert line endings
::--------------------------------------------------------
::if '%~nx0'=='build.cmd' (
::    more /P build.cmd >build_crlf.cmd
::    del build.cmd & rename build_crlf.cmd build.cmd
::)

::--------------------------------------------------------
:: enable escape sequence console colors
:: https://superuser.com/a/1300251
::--------------------------------------------------------
::REG ADD HKCU\CONSOLE /f /v VirtualTerminalLevel /t REG_DWORD /d 1


::--------------------------------------------------------
:: Main
::--------------------------------------------------------
:main
    ::--------------------------------------------------------
    :: GLOBAL USER VARIABLES
    ::--------------------------------------------------------
    set SCRIPT_DIR=%~dp0
    set SCRIPT_DIR=%SCRIPT_DIR:~0,-1%
	call:print_var SCRIPT_DIR
    set SCRIPT_NAME=%~nx0
	call:print_var SCRIPT_NAME
    echo %SCRIPT_DIR%\%SCRIPT_NAME%

    set CMAKE_DL_WIN_ARM64=https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3-windows-arm64.msi
    set CMAKE_DL_WIN_X86=https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3-windows-i386.msi
    set CMAKE_DL_WIN_X86_64=https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3-windows-x86_64.msi

    set GIT_DL_WIN_X86=https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-32-bit.exe
    set GIT_DL_WIN_X86_64=https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe

    set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
    call:make_directory "%DIGITALKNOB_DIR%"
    call:print_var DIGITALKNOB_DIR

    set "DKTOOLS_DIR=%DIGITALKNOB_DIR%\DKTools"
    call:make_directory "%DKTOOLS_DIR%"
    call:print_var DKTOOLS_DIR
        
    set "DKDOWNLOAD_DIR=%DIGITALKNOB_DIR%\download"
    call:make_directory "%DKDOWNLOAD_DIR%"
    call:print_var DKDOWNLOAD_DIR

    set NATIVE_OS=win
    call:print_var NATIVE_OS
        
    if %PROCESSOR_ARCHITECTURE%==x86 set NATIVE_ARCH=x86
    if %PROCESSOR_ARCHITECTURE%==AMD64 set NATIVE_ARCH=x86_64
    if %PROCESSOR_ARCHITECTURE%==IA64  set NATIVE_ARCH=x86_64
    if %PROCESSOR_ARCHITECTURE%==EM64T set NATIVE_ARCH=x86_64
    if %PROCESSOR_ARCHITECTURE%==ARM64  set NATIVE_ARCH=arm64
    call:print_var NATIVE_ARCH
        
    set NATIVE_TRIPLE=%NATIVE_OS%_%NATIVE_ARCH%
    call:print_var NATIVE_TRIPLE
	
	set NATIVE_ENV=clang
	set NATIVE_TRIPLE=%NATIVE_TRIPLE%_%NATIVE_ENV%

    call:validate_git
    call:validate_branch

	call:print_var DKBRANCH_DIR
	call:print_var DKAPPS_DIR
    call:print_var DKCMAKE_DIR
    call:print_var DK3RDPARTY_DIR
    call:print_var DKIMPORTS_DIR
	call:print_var DKPLUGINS_DIR
        
    call:validate_cmake
        
    :while_loop             
    if "%UPDATE%"==""     call:pick_update & goto:while_loop
    if "%APP%"==""        call:pick_app    & goto:while_loop
    if "%TARGET_OS%"==""  call:pick_os     & goto:while_loop
    if "%TYPE%"==""       call:pick_type   & goto:while_loop

	call:create_cache
	
    call:generate
	if %TARGET_OS%==android_arm32 		call:generate_toolchain android_arm32_toolchain
	if %TARGET_OS%==android_arm64 		call:generate_toolchain android_arm64_toolchain
	if %TARGET_OS%==emscripten  		call:generate_toolchain emscripten_toolchain
	if %TARGET_OS%==win_arm64_clang		call:generate_toolchain windows_arm64_clang_toolchain
	if %TARGET_OS%==win_x86_mingw		call:generate_toolchain windows_x86_mingw_toolchain
	if %TARGET_OS%==win_x86_clang		call:generate_toolchain windows_x86_clang_toolchain
	if %TARGET_OS%==win_x86_msvc		call:generate_toolchain windows_x86_msvc_toolchain
	if %TARGET_OS%==win_x86_64_mingw	call:generate_toolchain windows_x86_64_mingw_toolchain
	if %TARGET_OS%==win_x86_64_clang	call:generate_toolchain windows_x86_64_clang_toolchain
	if %TARGET_OS%==win_x86_64_ucrt	    call:generate_toolchain windows_x86_64_ucrt_toolchain
	if %TARGET_OS%==win_x86_64_msvc		call:generate_toolchain windows_x86_64_msvc_toolchain
	
    call:build
    if %TYPE%==All      call:build_all
    if %TYPE%==Release  call:build_release
    if %TYPE%==Debug    call:build_debug
       
    call:end_message
        
    goto while_loop
    :while_loop_end
goto:eof


:pick_update
    TITLE DigitalKnob - %APP% %TARGET_OS% %TYPE%
    
    call:read_cache
    
    echo.
    if exist "%DKBRANCH_DIR%\cache" if "%_APP_%" NEQ "" if "%_TARGET_OS_%" NEQ "" if "%_TYPE_%" NEQ "" echo  0) Repeat cache [%_APP_% - %_TARGET_OS_% - %_TYPE_%]
    echo  1) Git Update
    echo  2) Git Commit
    echo  3) Push assets
    echo  4) Pull assets
    echo  5) Reset All
    echo  6) Remove All
    echo  7) Clear Screen
    echo  8) Clear cmake cache and .tmp files
    echo  9) Reload
    echo  10) Exit
    echo. 
    echo  Press Enter To Skip
    set choice=
    set /p "choice=Choose a selection: " 
	
	::if not '%choice%'=='' set choice=%choice:~0,1%        ::What does this do?
    if "%choice%"=="0" set "APP=%_APP_%" & set "TARGET_OS=%_TARGET_OS_%" & set "TYPE=%_TYPE_%"
    if "%choice%"=="1" call:git_update
    if "%choice%"=="2" call:git_commit
    if "%choice%"=="3" call:push_assets
    if "%choice%"=="4" call:pull_assets
    if "%choice%"=="5" call:reset_all
    if "%choice%"=="6" call:remove_all
    if "%choice%"=="7" call:clear_screen
    if "%choice%"=="8" call:dk_deleteCache & call:delete_temp_files
    if "%choice%"=="9" call:reload
    if "%choice%"=="10" exit
        
    set UPDATE=true
goto:eof

:pick_app
    TITLE DigitalKnob - %APP% %TARGET_OS% %TYPE%
     
	call:read_cache
	 
    echo.
	if exist "%DKBRANCH_DIR%\cache" if "%_APP_%" NEQ "" if "%_TARGET_OS_%" NEQ "" if "%_TYPE_%" NEQ "" echo  0) Repeat cache [%_APP_% - %_TARGET_OS_% - %_TYPE_%]
    echo  1) HelloWorld
    echo  2) DKCore
    echo  3) DKJavascript
    echo  4) DKSDL
    echo  5) DKSDLRml
    echo  6) DKDomTest
    echo  7) DKTestAll
    echo  8) Enter Manually
    echo  9) Clear Screen
    echo 10) Reload
    echo 11) Go Back
    echo 12) Exit
    set choice=
    set /p choice=Please select an app to build: 
	
    ::if not '%choice%'=='' set choice=%choice:~0,1%        ::What does this do?
	if "%choice%"=="0"  set "APP=%_APP_%" & set "TARGET_OS=%_TARGET_OS_%" & set "TYPE=%_TYPE_%" & goto:eof
    if "%choice%"=="1"  set "APP=HelloWorld"   & goto:eof
    if "%choice%"=="2"  set "APP=DKCore"       & goto:eof
    if "%choice%"=="3"  set "APP=DKJavascript" & goto:eof
    if "%choice%"=="4"  set "APP=DKSDL"        & goto:eof
    if "%choice%"=="5"  set "APP=DKSDLRml"     & goto:eof
    if "%choice%"=="6"  set "APP=DKDomTest"    & goto:eof
    if "%choice%"=="7"  set "APP=DKTestAll"    & goto:eof
    if "%choice%"=="8"  call:enter_manually    & goto:eof
    if "%choice%"=="9" call:clear_screen       & goto:eof
    if "%choice%"=="10" call:reload            & goto:eof
    if "%choice%"=="11" set "UPDATE="          & goto:eof
    if "%choice%"=="12" exit                   & goto:eof
        
    echo %choice%: invalid selection, please try again
    set APP=
goto:eof


:checkApp
    if NOT exist "%DKBRANCH_DIR%\DKApps\%APP%\DKMAKE.cmake" (
        echo ERROR: "%DKBRANCH_DIR%\DKApps\%APP%\DKMAKE.cmake" file not found
        set APP=
    ) 
goto:eof


:pick_os
    TITLE DigitalKnob - %APP% %TARGET_OS% %TYPE%
    echo.
    echo %APP% %TARGET_OS% %TYPE%
       
    :: TODO: this list can be created using the DKCMake/toolchains files.
    echo.
    echo  1) %NATIVE_TRIPLE%
    echo.
    echo  2) Android arm32
    echo  3) Android arm64
    echo  4) Android x86
    echo  5) Android x86_64
    echo  6) Emscripten
    echo  7) Ios arm32
    echo  8) Ios arm64
    echo  9) Ios x86
    echo 10) Ios x86_64
    echo 11) Iossim arm32
    echo 12) Iossim arm64
    echo 13) Iossim x86
    echo 14) Iossim x86_64
    echo 15) Linux arm32
    echo 16) Linux arm64
    echo 17) Linux x86
    echo 18) Linux x86_64
    echo 19) Mac arm32
    echo 20) Mac arm64
    echo 21) Mac x86
    echo 22) Mac x86_64
    echo 23) Raspberry arm32
    echo 24) Raspberry arm64
    echo 25) Raspberry x86
    echo 26) Raspberry x86_64
    echo 27) Windows arm32
    echo 28) Windows arm64 (clang)
	echo 29) Windows x86 (mingw)
	echo 30) Windows x86 (clang)
	echo 31) Windows x86 (msvc)
	echo 32) Windows x86_64 (mingw)
	echo 33) Windows x86_64 (clang)
	echo 34) Windows x86_64 (ucrt)
	echo 35) Windows x86_64 (msvc)
    echo 36) Clear Screen
    echo 37) Go Back
    echo 38) Exit	
    set choice=
    set /p choice=Please select an OS to build for: 
		
    ::if not "%choice%"=="" set choice=%choice:~0,1%        ::What does this do?
    if "%choice%"=="1" set "TARGET_OS=%NATIVE_TRIPLE%"     & goto:eof
    if "%choice%"=="2" set "TARGET_OS=android_arm32"       & goto:eof
    if "%choice%"=="3" set "TARGET_OS=android_arm64"       & goto:eof
    if "%choice%"=="4" set "TARGET_OS=android_x86"         & goto:eof
    if "%choice%"=="5" set "TARGET_OS=android_x86_64"      & goto:eof
    if "%choice%"=="6" set "TARGET_OS=emscripten"          & goto:eof
    if "%choice%"=="7" set "TARGET_OS=ios_arm32"           & goto:eof
    if "%choice%"=="8" set "TARGET_OS=ios_arm64"           & goto:eof
    if "%choice%"=="9" set "TARGET_OS=ios_x86"             & goto:eof
    if "%choice%"=="10" set "TARGET_OS=ios_x86_64"         & goto:eof
    if "%choice%"=="11" set "TARGET_OS=iossim_arm32"       & goto:eof
    if "%choice%"=="12" set "TARGET_OS=iossim_arm64"       & goto:eof
    if "%choice%"=="13" set "TARGET_OS=iossim_x86"         & goto:eof
    if "%choice%"=="14" set "TARGET_OS=iossim_x86_64"      & goto:eof
    if "%choice%"=="15" set "TARGET_OS=linux_arm32"        & goto:eof
    if "%choice%"=="16" set "TARGET_OS=linux_arm64"        & goto:eof
    if "%choice%"=="17" set "TARGET_OS=linux_x86"          & goto:eof
    if "%choice%"=="18" set "TARGET_OS=linux_x86_64"       & goto:eof
    if "%choice%"=="19" set "TARGET_OS=mac_arm32"          & goto:eof
    if "%choice%"=="20" set "TARGET_OS=mac_arm64"          & goto:eof
    if "%choice%"=="21" set "TARGET_OS=mac_x86"            & goto:eof
    if "%choice%"=="22" set "TARGET_OS=mac_x86_64"         & goto:eof
    if "%choice%"=="23" set "TARGET_OS=raspberry_arm32"    & goto:eof
    if "%choice%"=="24" set "TARGET_OS=raspberry_arm64"    & goto:eof
    if "%choice%"=="25" set "TARGET_OS=raspberry_x86"      & goto:eof
    if "%choice%"=="26" set "TARGET_OS=raspberry_x86_64"   & goto:eof
    if "%choice%"=="27" set "TARGET_OS=win_arm32"          & goto:eof
    if "%choice%"=="28" set "TARGET_OS=win_arm64_clang"    & goto:eof
	if "%choice%"=="29" set "TARGET_OS=win_x86_mingw"      & goto:eof
	if "%choice%"=="30" set "TARGET_OS=win_x86_clang"      & goto:eof
	if "%choice%"=="31" set "TARGET_OS=win_x86_msvc"       & goto:eof
	if "%choice%"=="32" set "TARGET_OS=win_x86_64_mingw"   & goto:eof
	if "%choice%"=="33" set "TARGET_OS=win_x86_64_clang"   & goto:eof
	if "%choice%"=="34" set "TARGET_OS=win_x86_64_ucrt"    & goto:eof
	if "%choice%"=="35" set "TARGET_OS=win_x86_64_msvc"    & goto:eof
    if "%choice%"=="36" call:clear_screen                  & goto:eof
    if "%choice%"=="37" set "APP="                         & goto:eof
    if "%choice%"=="38" exit                               & goto:eof
    echo %choice%: invalid selection, please try again
    set TARGET_OS=
goto:eof


:pick_type
    TITLE DigitalKnob - %APP% %TARGET_OS% %TYPE%
    echo.
    echo %APP% %TARGET_OS% %TYPE%
        
    echo.
    echo 1) Debug
    echo 2) Release
    echo 3) All
    echo 4) Clear Screen
    echo 5) Go Back
    echo 6) Exit
    set choice=
    set /p choice=Please select a build type: 
	
    ::if not "%choice%"=="" set choice=%choice:~0,1%        ::What does this do? 
    if "%choice%"=="1" set "TYPE=Debug"    & goto:eof
    if "%choice%"=="2" set "TYPE=Release"  & goto:eof
    if "%choice%"=="3" set "TYPE=All"      & goto:eof
    if "%choice%"=="4" call:clear_screen   & goto:eof
    if "%choice%"=="5" set "TARGET_OS="    & goto:eof
    if "%choice%"=="6" exit                & goto:eof
        
    echo %choice%: invalid selection, please try again
    set TYPE=
goto:eof

:add_cmake_arg <arg>
    if "%*" == "" echo ERROR: add_cmake_arg is empty! & goto:eof
    echo added %*
    set CMAKE_ARGS=%CMAKE_ARGS% "%*"
goto:eof

:generate
    TITLE DigitalKnob - Generating %APP% - %TARGET_OS% - %TYPE% - %LEVEL% . . .
    echo.
    echo ########################################################## 
    echo ****** Generating %APP% - %TARGET_OS% - %TYPE% - %LEVEL% ******
    echo ##########################################################
    echo.
	
    call:dk_deleteCache
    call:delete_temp_files
    
    ::if "%TARGET_PATH%"=="" set "TARGET_PATH=%DKAPPS_DIR%\%APP%"
    set "TARGET_PATH=%DKAPPS_DIR%\%APP%"
    call:print_var TARGET_PATH
    call:make_directory "%TARGET_PATH%\%TARGET_OS%"
    ::cd "%TARGET_PATH%\%TARGET_OS%"
    call set CMAKE_SOURCE_DIR=%%DKCMAKE_DIR:^\=^/%%
    call:print_var CMAKE_SOURCE_DIR
    call set CMAKE_TARGET_PATH=%%TARGET_PATH:^\=^/%%
    call:print_var CMAKE_TARGET_PATH
        
    ::::::::: BUILD CMAKE_ARGS ARRAY :::::::::
    set DKLEVEL=RebuildAll
    set DKLINK=Static

    set CMAKE_ARGS=
    ::if %TYPE%==Debug            call:add_cmake_arg -DDEBUG=ON & call:add_cmake_arg -DRELEASE=OFF
	if %TYPE%==Debug            call:add_cmake_arg -DDEBUG=ON
    ::if %TYPE%==Release          call:add_cmake_arg -DDEBUG=OFF & call:add_cmake_arg -DRELEASE=ON
	if %TYPE%==Release          call:add_cmake_arg -DRELEASE=ON
    if %TYPE%==All              call:add_cmake_arg -DDEBUG=ON & call:add_cmake_arg -DRELEASE=ON
    if %DKLEVEL%==Build         call:add_cmake_arg -DBUILD=ON
    if %DKLEVEL%==Rebuild       call:add_cmake_arg -DREBUILD=ON
    if %DKLEVEL%==RebuildAll    call:add_cmake_arg -DREBUILDALL=ON
    if %DKLINK%==Static         call:add_cmake_arg -DSTATIC=ON
    if %DKLINK%==Shared         call:add_cmake_arg -DSHARED=ON
	::if %TARGET_OS%==emscripten	call:add_cmake_arg -DEMSCRIPTEN=ON
        
    set CMAKE_BINARY_DIR=%CMAKE_TARGET_PATH%/%TARGET_OS%/%TYPE%
    call:print_var CMAKE_BINARY_DIR
        
    call:add_cmake_arg -S=%CMAKE_SOURCE_DIR%
    call:add_cmake_arg -B=%CMAKE_BINARY_DIR%

    :::::::::::: CMake Options :::::::::::::
    ::call:add_cmake_arg -DCMAKE_VERBOSE_MAKEFILE=1
	::call:add_cmake_arg -DCMAKE_COLOR_DIAGNOSTICS=ON
	call:add_cmake_arg -Wdev
	::call:add_cmake_arg -Werror=dev
	call:add_cmake_arg -Wdeprecated
	::call:add_cmake_arg -Werror=deprecated
	::call:add_cmake_arg --graphviz=graphviz.txt
	::call:add_cmake_arg --system-information system_information.txt
	call:add_cmake_arg --debug-trycompile
	::call:add_cmake_arg --debug-output
	::call:add_cmake_arg --trace
	::call:add_cmake_arg --trace-expand
	::call:add_cmake_arg --warn-uninitialized
	call:add_cmake_arg --warn-unused-vars
	::call:add_cmake_arg --check-system-vars
goto:eof

:::generate_msystem
::  call:cmake_eval "include('%DKIMPORTS_DIR%/msys2/DKMAKE.cmake')" "MSYS2"
::  call:print_var MSYS2
::                
::	call:add_cmake_arg -G MinGW Makefiles
::  call:add_cmake_arg -DMSYSTEM=%MSYSTEM%
::                
::  echo.
::  echo ****** CMAKE COMMAND ******
::  echo "%CMAKE_EXE%" %CMAKE_ARGS%
::  "%CMAKE_EXE%" %CMAKE_ARGS%
::  echo.
::goto:eof

:::generate_msvc
::	::call:validate_visual_studio
::	::call:add_cmake_arg -G Visual Studio -A x64
::  ::call:add_cmake_arg -DCMAKE_C_COMPILER=%VISUALSTUDIO_C_COMPILER%"
::    ::call:add_cmake_arg -DCMAKE_CXX_COMPILER=%VISUALSTUDIO_CXX_COMPILER%"
::	
::	echo.
::  echo ****** CMAKE COMMAND ******
::  echo "%CMAKE_EXE%" %CMAKE_ARGS%
::  "%CMAKE_EXE%" %CMAKE_ARGS%
::  echo.
::goto:eof

:generate_toolchain <toolchain>
	set toolchain=%1
	
	:: TODO: we need a good way to pull the CMAKE_GENERATOR from the toolchain files.
	:::::: CMAKE_GENERATOR ::::::
    call:string_contains %toolchain% android hasAndroid
    if "%hasAndroid%" EQU "1" set "CMAKE_GENERATOR=Unix Makefiles"
    if "%hasAndroid%" NEQ "1" set "CMAKE_GENERATOR=MinGW Makefiles"
    call:add_cmake_arg -G %CMAKE_GENERATOR%
	
	::::::: CMAKE_TOOLCHAIN_FILE :::::::
	call set CMAKE_TOOLCHAIN_FILE=%DKCMAKE_DIR%/toolchains/%1.cmake
	call set CMAKE_TOOLCHAIN_FILE=%%CMAKE_TOOLCHAIN_FILE:^\=^/%%
	call:add_cmake_arg -DCMAKE_TOOLCHAIN_FILE=%CMAKE_TOOLCHAIN_FILE%
	
	::::::: CMake Configure :::::::
	echo.
    echo ****** CMAKE COMMAND ******
    echo "%CMAKE_EXE%" %CMAKE_ARGS%
    "%CMAKE_EXE%" %CMAKE_ARGS%
    echo.
goto:eof





:build
    TITLE DigitalKnob - Building %APP% - %TARGET_OS% -%TYPE% - %DKLEVEL% . . .
    echo.
    echo ###########################################################        
    echo ****** Building %APP% - %TARGET_OS% - %TYPE% - %DKLEVEL% ******
    echo ###########################################################
    echo.
goto:eof

:build_all

:build_debug
    if "%MSYSTEM%" NEQ "" (
        %MSYS2%/usr/bin/env MSYSTEM=%MSYSTEM% /usr/bin/bash -lc "'%CMAKE_EXE%' --build %CMAKE_TARGET_PATH%/%TARGET_OS%/Debug --config Debug --verbose"
        goto:eof
    )
    if exist %TARGET_PATH%\%TARGET_OS%\Debug\CMakeCache.txt (
        echo "%CMAKE_EXE%" --build %TARGET_PATH%/%TARGET_OS%/Debug --config Debug --verbose
        "%CMAKE_EXE%" --build %TARGET_PATH%/%TARGET_OS%/Debug --config Debug --verbose
		goto:eof
    )
    if exist %TARGET_PATH%\%TARGET_OS%\CMakeCache.txt (
        echo "%CMAKE_EXE%" --build %TARGET_PATH%/%TARGET_OS% --config Debug --verbose
        "%CMAKE_EXE%" --build %TARGET_PATH%/%TARGET_OS% --config Debug --verbose
		goto:eof
    )
goto:eof

:build_release
    if "%MSYSTEM%" NEQ "" (
        %MSYS2%/usr/bin/env MSYSTEM=%MSYSTEM% /usr/bin/bash -lc "'%CMAKE_EXE%' --build %CMAKE_TARGET_PATH%/%TARGET_OS%/Release --config Debug --verbose"
        goto:eof
    )
    if exist %TARGET_PATH%\%TARGET_OS%\Release\CMakeCache.txt (
        echo "%CMAKE_EXE%" --build %TARGET_PATH%\%TARGET_OS%\Release --config Release --verbose
        "%CMAKE_EXE%" --build %TARGET_PATH%\%TARGET_OS%\Release --config Release --verbose
		goto:eof
    )
    if exist %TARGET_PATH%\%TARGET_OS%\CMakeCache.txt (
        echo "%CMAKE_EXE%" --build %TARGET_PATH%\%TARGET_OS% --config Release --verbose
        "%CMAKE_EXE%" --build %TARGET_PATH%\%TARGET_OS% --config Release --verbose
		goto:eof
    )
goto:eof


:end_message
    TITLE DigitalKnob - Done Building %APP%_%TARGET_OS%_%TYPE% %DKLEVEL% . . .
    echo.
    echo ###########################################################        
    echo ****** Done Building %APP% - %TARGET_OS% - %TYPE% - %DKLEVEL% ******
    echo ###########################################################
    echo.
        
    set UPDATE=
    set APP=
    set TARGET_OS=
    set TYPE=
goto:eof




::--------------------------------------------------------
:: FUNCTIONS
:: https://www.dostips.com/DtTutoFunctions.php
::--------------------------------------------------------

::dk_call()
:dk_call
    ::TODO
    :: Here we try to use DK_call to pass on a call while echoing the call passed
    :: This works in bash script, yet we have issues with this in cmd
    echo %*
    %*
goto:eof

::enter_manually()
:enter_manually
    echo Please type the name of the library, tool or app to build. Then press enter.
    set /p input= 

    set APP=_%input%_
  
    ::Search digitalknob for the matching entry containing a DKMAKE.cmake file  
    ::cd %DIGITALKNOB_DIR%
    ::for /f "delims=" %%a in ('dir /b /s /a-d DKMAKE.cmake ^| findstr /E /R "%input%\\DKMAKE.cmake" ') do set "path=%%a"
    ::set "TARGET_PATH=%path:~0,-13%"
    
    if exist "%DKIMPORTS_DIR%\%input%\DKMAKE.cmake" set "TARGET_PATH=%DKIMPORTS_DIR%\%input%"
    if exist "%DKPLUGINS_DIR%\%input%\DKMAKE.cmake" set "TARGET_PATH=%DKPLUGINS_DIR%\%input%"
    if exist "%DKAPPS_DIR%\%input%\DKMAKE.cmake" set "TARGET_PATH=%DKAPPS_DIR%\%input%"
    ::call:print_var TARGET_PATH
    
    call:get_parent_folder %TARGET_PATH% parent
    ::call:print_var parent
    
    if %parent%==DKApps goto:eof
    call:make_directory  %DKAPPS_DIR%\%APP%
    
    :: create DKApps/<APP>/DKMAKE.cmake 
    echo dk_depend(%input%)> %DKAPPS_DIR%\%APP%\DKMAKE.cmake
    
    :: create DKApps/<APP>/main.cpp
    echo int main(int argc, char** argv) { return 0; } > %DKAPPS_DIR%\%APP%\main.cpp
goto:eof

:: get_parent_folder
:get_parent_folder
    for %%a in ("%1") do for %%b in ("%%~dpa\.") do set "parent=%%~nxb"
    set "%2=%parent%"
goto:eof


:: push_assets()
:push_assets
    echo not implemented,  TODO
goto:eof


:: pull_assets()
:pull_assets
    echo not implemented,  TODO
goto:eof


:: reset_apps()
:reset_apps
    echo Resetting Apps . . .

    set /P CONFIRM="Are you sure? [Y] " 
    if /I "%CONFIRM%" NEQ "Y" goto:eof

    cd %DKAPPS_DIR%
    "%GIT_EXE%" clean -f -d
goto:eof


:: reset_plugins()
:reset_plugins
    echo Resetting DKPlugins . . .

    set /P CONFIRM="Are you sure? [Y] " 
    if /I "%CONFIRM%" NEQ "Y" goto:eof
        
    cd %DKPLUGINS_DIR%
    "%GIT_EXE%" clean -f -d
goto:eof


:: reset_3rdparty()
:reset_3rdparty
    echo Resetting 3rdParty Libraries . . .
        
    set /P CONFIRM="Are you sure? [Y] " 
    if /I "%CONFIRM%" NEQ "Y" goto:eof
        
    cd %DK3RDPARTY_DIR%
    "%GIT_EXE%" clean -f -d
goto:eof


:: :reset_all()
:reset_all
    if "%1" EQU "wipe" goto:wipe
        
    cls
    echo.
    echo.
    echo  Do you want to reset the entire local repository . . .?
    echo. This will delete digitalknob, everything will be reset,
    echo. and the repository will be re-cloned. All libraries and tools
    echo. will be redownloaded and rebuild from start. Save any changes 
    echo. you wish to commit or save beforehand.
    echo. 
        
    set /P CONFIRM="Are you sure? [Y] " 
    if /I "%CONFIRM%" NEQ "Y" goto:eof
        
    :: first we need to relocate this file up one directory
    :: make sure script is running from DKBRANCH_DIR
    if not "%SCRIPT_DIR%" == "%DKBRANCH_DIR%" (
        echo WARNING: this file isn't running from the branch directory
        echo Is must be in the branch directory to continue.
        call:print_var SCRIPT_DIR
        call:print_var DKBRANCH_DIR
        goto:eof
    )
    
    call:kill_process java.exe
	call:kill_process adb.exe
	
    echo "RELOCATING SCRIPT TO -> %DIGITALKNOB_DIR%\%SCRIPT_NAME%"
    copy /Y %SCRIPT_DIR%\%SCRIPT_NAME% %DIGITALKNOB_DIR%\%SCRIPT_NAME%
    start "" "%DIGITALKNOB_DIR%\%SCRIPT_NAME%" :reset_all wipe
    exit    
        
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    :wipe   
    ::do we need admin rights?
    ::runas /user:Administrator cmd
    ::do we need to uninstall any apps?
    ::do we need to remove any environment variables?
      
	:: TODO: kill java.exe processes
	:: TODO: kill adb.exe process
	  
    cd %DIGITALKNOB_DIR%

    echo.
    echo DELETING %DKBRANCH_DIR% . . . .
    call rmdir %DKBRANCH_DIR% /s /q
    echo done.
        
    :: wait for the folders to get deleted
    ping 127.0.0.1 -n 6 >nul
    ping 127.0.0.1 -n 6 >nul
        
    if exist %DKBRANCH_DIR% echo "Oh no, the BRANCH folder is still there! :( "
        
    call:git_update NO_CONFIRM
        
    start "" "%DKBRANCH_DIR%\%SCRIPT_NAME%" & del /f %DIGITALKNOB_DIR%\%SCRIPT_NAME% & exit
goto:eof


:: :remove_all()
:remove_all
    if "%1" EQU "wipe" goto:wipe
        
    cls
    echo.
    echo.
    echo  Do you want to remove the entire local repository . . .?
    echo. This will delete digitalknob. Save any changes 
    echo. you wish to commit or save beforehand.
    echo. 
        
    set /P CONFIRM="Are you sure? [Y] " 
    if /I "%CONFIRM%" NEQ "Y" goto:eof
        
    :: first we need to relocate this file up one directory
    :: make sure script is running from DKBRANCH_DIR
    if not "%SCRIPT_DIR%" == "%DKBRANCH_DIR%" (
        echo WARNING: this file isn't running from the branch directory
        echo Is must be in the branch directory to continue.
        call:print_var SCRIPT_DIR
        call:print_var DKBRANCH_DIR
        goto:eof
    )
    
	call:kill_process java.exe
	call:kill_process adb.exe
	
    echo "RELOCATING SCRIPT TO -> %DIGITALKNOB_DIR%\%SCRIPT_NAME%"
    copy /Y %SCRIPT_DIR%\%SCRIPT_NAME% %DIGITALKNOB_DIR%\%SCRIPT_NAME%
    start "" "%DIGITALKNOB_DIR%\%SCRIPT_NAME%" :remove_all wipe
    exit    
        
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    :wipe   
    ::do we need admin rights?
    ::runas /user:Administrator cmd   
    ::do we need to kill any processes? 
    ::do we need to uninstall any apps?  
    ::do we need to remove any environment variables?
        
    cd %DIGITALKNOB_DIR%
    echo.
    echo DELETING %DKBRANCH_DIR% . . . .
    call rmdir %DKBRANCH_DIR% /s /q
    echo done.
        
    :: wait for the folders to get deleted
    ping 127.0.0.1 -n 6 >nul
    ping 127.0.0.1 -n 6 >nul
        
    if exist %DKBRANCH_DIR% echo "Oh no, the BRANCH folder is still there! :( "
goto:eof


:: reload()
:reload
    echo .
    echo reloading %SCRIPT_NAME%
    start "" "%SCRIPT_DIR%\%SCRIPT_NAME%"
    exit
goto:eof


:: check_error()
:check_error
    if %ERRORLEVEL% EQU 0 goto:eof
    call:error "ERRORLEVEL = %ERRORLEVEL%"
    pause
    exit
goto:eof


:: download()
:download
    echo Downloading %~1
    if exist "%~2" (
        echo %~2 already exist
        goto:eof
    )

    echo please wait . . .
    ::certutil.exe -urlcache -split -f %~1 %~2
    powershell -Command "(New-Object Net.WebClient).DownloadFile('%~1', '%~2')"
    call:check_error
goto:eof


:: make_directory()
:make_directory
    if NOT exist "%~1" mkdir "%~1"
goto:eof


:: validate_branch()
:validate_branch
    :: https://stackoverflow.com/a/33662275
    :: If the current folder matches the current branch set DKBRANCH, default to Development
    for %%I in (.) do set FOLDER=%%~nxI
        
    set DKBRANCH=Development
    if exist .git (
        "%GIT_EXE%" branch | find "* %FOLDER%" > NUL & IF ERRORLEVEL 0 (
            set DKBRANCH=%FOLDER%
        )
    )

    call:print_var DKBRANCH
	set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\%DKBRANCH%"
	set "DKAPPS_DIR=%DKBRANCH_DIR%\DKApps"
    set "DKCMAKE_DIR=%DKBRANCH_DIR%\DKCMake"
	set "DKPLUGINS_DIR=%DKBRANCH_DIR%\DKPlugins"
    set "DK3RDPARTY_DIR=%DKBRANCH_DIR%\3rdParty"
    set "DKIMPORTS_DIR=%DK3RDPARTY_DIR%\_DKIMPORTS"
	
    :: make sure script is running from DKBRANCH_DIR
    ::if not %SCRIPT_DIR% == %DKBRANCH_DIR% (
    ::      if not exist %DKBRANCH_DIR%\%SCRIPT_NAME% (
    ::              copy %SCRIPT_DIR%\%SCRIPT_NAME% %DKBRANCH_DIR%\%SCRIPT_NAME%
    ::      )
    ::      echo .
    ::      echo "RELOADING SCRIPT TO -> %DKBRANCH_DIR%\%SCRIPT_NAME%"
    ::      pause
    ::      start "" "%DKBRANCH_DIR%\%SCRIPT_NAME%"
    ::      if exist %DKBRANCH_DIR%\%SCRIPT_NAME% (
    ::              del "%SCRIPT_DIR%\%SCRIPT_NAME%"
    ::      )
    ::      exit
    ::)
    call:check_error
goto:eof


:: validate_git()
:validate_git
    if "%NATIVE_ARCH%"=="arm32" set GIT_DL=
    if "%NATIVE_ARCH%"=="arm64" set GIT_DL=%GIT_DL_WIN_ARM64%
    if "%NATIVE_ARCH%"=="x86" set GIT_DL=%GIT_DL_WIN_X86%
    if "%NATIVE_ARCH%"=="x86_64" set GIT_DL=%GIT_DL_WIN_X86_64%
        
    call:get_filename %GIT_DL% GIT_DL_FILE
    ::call:print_var GIT_DL_FILE

    set GIT_FOLDER=%GIT_DL_FILE:~0,-4%
    call:convert_to_c_identifier %GIT_FOLDER% GIT_FOLDER
    call:convert_to_lowercase %GIT_FOLDER% GIT_FOLDER
    ::call:print_var GIT_FOLDER
        
    set "GIT_EXE=%DKTOOLS_DIR%\%GIT_FOLDER%\bin\git.exe"
    call:print_var GIT_EXE
        
    if exist "%GIT_EXE%" goto:eof
        
    echo.   
    echo "Installing git . . ."
    call:download %GIT_DL% "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%"
    echo "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" /DIR=%DKTOOLS_DIR%\%GIT_FOLDER%
    "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" /DIR=%DKTOOLS_DIR%\%GIT_FOLDER%
        
    if NOT exist "%GIT_EXE%" (
        call:assert "cannot find git"
    )
        
    call:check_error
goto:eof


:: validate_cmake()
:validate_cmake
    if "%NATIVE_ARCH%"=="arm32"     set CMAKE_DL=
    if "%NATIVE_ARCH%"=="arm64"     set CMAKE_DL=%CMAKE_DL_WIN_ARM64%
    if "%NATIVE_ARCH%"=="x86" set CMAKE_DL=%CMAKE_DL_WIN_X86%
    if "%NATIVE_ARCH%"=="x86_64" set CMAKE_DL=%CMAKE_DL_WIN_X86_64%
        
    call:get_filename %CMAKE_DL% CMAKE_DL_FILE
    call:print_var CMAKE_DL_FILE
        
    set CMAKE_FOLDER=%CMAKE_DL_FILE:~0,-4%
    call:convert_to_c_identifier %CMAKE_FOLDER% CMAKE_FOLDER
	call:convert_to_lowercase %CMAKE_FOLDER% CMAKE_FOLDER
    call:print_var CMAKE_FOLDER
        
    set "CMAKE_EXE=%DKTOOLS_DIR%\%CMAKE_FOLDER%\bin\cmake.exe"
    call:print_var CMAKE_EXE
        
    if exist "%CMAKE_EXE%" goto:eof
       
    echo.   
    echo "Installing cmake . . ."
    call:download %CMAKE_DL% "%DKDOWNLOAD_DIR%\%CMAKE_DL_FILE%"
    echo MsiExec.exe /i "%DKDOWNLOAD_DIR%\%CMAKE_DL_FILE%" INSTALL_ROOT="%DKTOOLS_DIR%\%CMAKE_FOLDER%" /qn
    MsiExec.exe /i "%DKDOWNLOAD_DIR%\%CMAKE_DL_FILE%" INSTALL_ROOT="%DKTOOLS_DIR%\%CMAKE_FOLDER%"
        
    if NOT exist "%CMAKE_EXE%" (
        call:assert "cannot find cmake"
    )
        
    call:check_error
goto:eof


:: validate_visual_studio()
:validate_visual_studio
    call:cmake_eval "include('%DKIMPORTS_DIR%/visualstudio/DKMAKE.cmake')" "VISUALSTUDIO_GENERATOR;VISUALSTUDIO_X86_CXX_COMPILER;VISUALSTUDIO_X64_CXX_COMPILER;"
    call:check_error
goto:eof

:: validate_msys2()
:validate_msys2
    call:cmake_eval "include('%DKIMPORTS_DIR%/msys2/DKMAKE.cmake')" "MSYS2;MSYS2_GENERATOR"
    call:check_error
goto:eof

:: validate_gcc()
:validate_gcc
    call:cmake_eval "include('%DKIMPORTS_DIR%/gcc/DKMAKE.cmake')" "GCC_C_COMPILER;GCC_CXX_COMPILER"
    call:check_error
goto:eof

:: validate_make()
:validate_make
    call:cmake_eval "include('%DKIMPORTS_DIR%/make/DKMAKE.cmake')" "MAKE_PROGRAM"
    call:check_error
goto:eof

:: validate_openjdk()
:validate_openjdk
    call:cmake_eval "include('%DKIMPORTS_DIR%/openjdk/DKMAKE.cmake')" "OPENJDK"
    call:check_error
goto:eof

:: validate_android_ndk()
:validate_android_ndk
    call:cmake_eval "include('%DKIMPORTS_DIR%/android-ndk/DKMAKE.cmake')" "ANDROID_GENERATOR;ANDROID_API;ANDROID_NDK;ANDROID_TOOLCHAIN_FILE"
    call:print_var ANDROID_GENERATOR
    call:print_var ANDROID_API
    call:print_var ANDROID_NDK
    call:print_var ANDROID_TOOLCHAIN_FILE
    call:check_error
goto:eof


:: validate_emscripten()
:validate_emscripten
    call:cmake_eval "include('%DKIMPORTS_DIR%/emsdk/DKMAKE.cmake')" "EMSDK;EMSDK_ENV;EMSDK_GENERATOR;EMSDK_TOOLCHAIN_FILE;EMSDK_C_COMPILER;EMSDK_CXX_COMPILER"
    call:print_var EMSDK
    call:print_var EMSDK_ENV
    call:print_var EMSDK_GENERATOR
    call:print_var EMSDK_TOOLCHAIN_FILE
    call:print_var EMSDK_C_COMPILER
    call:print_var EMSDK_CXX_COMPILER
    call:check_error
goto:eof


:: command_to_variable <command . .> <variable_name>
:command_to_variable
    if [%2] == [] (
        echo "ERROR: command_to_variable() requires at least 2 parameters"
        goto:eof
    )
    set command=

    :command_args
    set arg=%1
    set arg=%arg:"=_QUOTE_%
        
    if not "%~2"=="" (
        if "%command%"=="" (
            set "command=%arg%"
        ) else (
            set "command=%command% %arg%"
        )
    )
    set variable_name=%~1
    shift
    if not "%~1"=="" goto command_args

    set command=%command:_QUOTE_="%

    for /F "tokens=*" %%g in ('%command% 2^> nul') do (
        set %variable_name%=%%g
        set "variable_value=%%g"
    )

    ::echo command_to_variable(%*) -^> %%%variable_name%%% = %variable_value%
    call:check_error
goto:eof



:: dk_deleteCache()
:dk_deleteCache
    ::call:cmake_eval "dk_deleteCache()"
    echo Deleteing CMake cache . . .
    cd "%DIGITALKNOB_DIR%"
    for /r %%i in (CMakeCache.*) do del "%%i"
    for /d /r %%i in (*CMakeFiles*) do rd /s /q "%%i"
    call:check_error
goto:eof


:: delete_temp_files()
:delete_temp_files
    ::call:cmake_eval "dk_deleteTempFiles()"
    echo Deleteing .tmp files . . .
    cd "%DIGITALKNOB_DIR%"
    for /r %%i in (*.tmp) do del "%%i"
    for /r %%i in (*.TMP) do del "%%i"
    call:check_error
goto:eof


:: git_update() NO_CONFIRM
:git_update
    if "%1" NEQ "NO_CONFIRM" (
        echo Git Update? Any local changes will be lost.
        set /P CONFIRM="Are you sure? [Y] " 
    )
    if /I "%CONFIRM%" NEQ "Y" goto:eof
        
    if NOT exist "%DKBRANCH_DIR%\.git" (
        "%GIT_EXE%" clone https://github.com/aquawicket/DigitalKnob.git "%DKBRANCH_DIR%"
    )
    call:check_error

    cd "%DKBRANCH_DIR%"
    "%GIT_EXE%" pull --all
    "%GIT_EXE%" checkout -- .
    call:check_error

    "%GIT_EXE%" checkout %DKBRANCH%
    if NOT "%ERRORLEVEL%" == "0" (
        echo Remote has no %DKBRANCH% branch. Creating...
        "%GIT_EXE%" checkout -b %DKBRANCH% main
        "%GIT_EXE%" push --set-upstream origin %DKBRANCH%
    )

    call:check_error
goto:eof


:: git_commit()
:git_commit
    echo "Please enter some details about this commit, then press enter."
    set /p message=">" 
        
    cd %DKBRANCH_DIR%
        
    call:command_to_variable "%GIT_EXE%" config --global credential.helper STORE
    if not "%STORE%"=="store" (
        "%GIT_EXE%" config --global credential.helper store
        echo "git credential.helper is now set to store"
    )
        
    call:command_to_variable "%GIT_EXE%" config --global user.email USER_EMAIL
    if "%USER_EMAIL%"=="" (
        echo.
        echo please enter an email address
        set /p input=">" 
        "%GIT_EXE%" config --global user.email "%input%"
        echo.
        echo "git user.email %input% saved"
        echo.
    )
        
    call:command_to_variable "%GIT_EXE%" config --global user.email USER_NAME
    if "%USER_NAME%"=="" (
        echo.
        echo please enter a username
        set /p input=">" 
        "%GIT_EXE%" config --global user.name "%input%"
        echo.
        echo "git user.name %input% saved"
        echo.
    )
        
    if "%message%"=="" set "message=git commit"
        
    echo.
    echo git commit "%message%"
    set /P CONFIRM="Are you sure? [Y] " 
    if /I "%CONFIRM%" NEQ "Y" goto:eof
        
    "%GIT_EXE%" commit -a -m "%message%"
    "%GIT_EXE%" push
        
    call:check_error
goto:eof

:: clear_screen()
:clear_screen
    cls
goto:eof


:: cmake_eval <cmake_commands;.;.;> <return_variables;.;.;.> <-DVARS;.;.;>
:cmake_eval
	echo.
	echo  $ cmake_eval (%*)
	echo.
	
    if [%1] == [] (
        echo "ERROR: cmake_eval() parameter1 is invalid"
        goto:eof
    )
    if not exist "%CMAKE_EXE%" ( 
        echo "ERROR: Could not locate CMAKE_EXE" 
        goto:eof
    )
    if not exist "%DKCMAKE_DIR%" ( 
        echo "ERROR: Could not locate DKCMAKE_DIR" 
        goto:eof
    )

    set commands=%1
    set variables=%2

    call set commands=%%commands:"=%%
    set "DKCOMMAND=%commands%"
    call set DKCOMMAND=%%DKCOMMAND:^\=^/%%
    ::call:print_var DKCOMMAND

    set "EVAL_VARS=%DKCMAKE_DIR%\cmake_vars.cmd"
    call set DKCMAKE_DIR=%%DKCMAKE_DIR:^\=^/%%
        
    ::echo "%CMAKE_EXE%" "-DDKCMAKE_DIR=%DKCMAKE_DIR%" "-DDKCOMMAND=%DKCOMMAND%" -P "%DKCMAKE_DIR%/dev/cmake_eval.cmake" --log-level=TRACE >cmake_eval.out 2>cmake_eval.err

    if [%2] == [] goto no_return_values
    goto with_return_values

    :no_return_values
        "%CMAKE_EXE%" "-DDKCMAKE_DIR=%DKCMAKE_DIR%" "-DDKCOMMAND=%DKCOMMAND%" -P "%DKCMAKE_DIR%/dev/cmake_eval.cmake"
    goto:eof

    :with_return_values
        "%CMAKE_EXE%" "-DDKCMAKE_DIR=%DKCMAKE_DIR%" "-DDKCOMMAND=%DKCOMMAND%" "-DDKRETURN=%~2" %~3 -P %DKCMAKE_DIR%/dev/cmake_eval.cmake
        if not exist %DKCMAKE_DIR%/cmake_vars.cmd goto:eof
        call %EVAL_VARS%
        ::del %EVAL_VARS%
    goto:eof

    ::call:print_var ERRORLEVEL

    :::: work with cmake return code files ::::
    :: std::out
    set out=
    if exist "cmake_eval.out" (
        for /f "Tokens=* Delims=" %%x in (cmake_eval.out) do (
            set out=!out!%%x
            echo %%x
        )
    )
    ::out contains all of the lines
    ::del cmake_eval.out
    ::echo %out%    

    :: std::err
    set err=
    if exist "cmake_eval.err" (
        for /f "Tokens=* Delims=" %%x in (cmake_eval.err) do (
            set err=!err!%%x
            echo [91m %%x [0m
        )
    )
    ::del cmake_eval.out
    ::err contains all of the lines
    ::echo %err%

    call:check_error
goto:eof

:: command_exists <command> <result>
:command_exists
    set "command=%1"
    cmd /c "(help %command% > nul || exit 0) && where %command% > nul 2> nul"
    if %ERRORLEVEL% EQU 0 echo "%command% found" & goto:eof
    echo "%command% NOT found"
goto:eof

:: string_contains <haystack> <needle> <result>
:string_contains
	echo string_contains(%1 %2)
    call set "haystack=%1"
	call set "needle=%2"
	if not "x!haystack:%needle%=!"=="x%haystack%" set "%3=1" & goto:eof
	set "%3=0"
goto:eof

:: get_filename <path> <output_variable>
:get_filename
    if [%1] == [] (
        echo "ERROR: get_filename() parameter 1 is invalid"
        goto:eof
    )
    if [%2] == [] (
        echo "ERROR: get_filename() parameter 2 is invalid"
        goto:eof
    )
    
    for %%F in ("%1") do (
        set %2=%%~nxF
        set val=%%~nxF
    )
    
    ::echo get_filename(%*) -^> %2 = %val%
    call:check_error
goto:eof

:: create_cache
:create_cache
    echo creating cache...
    ::call:print_var APP
    ::call:print_var TARGET_OS
    ::call:print_var TYPE
    ::call:print_var LEVEL
        
    :: https://stackoverflow.com/a/5143293/688352
    echo %APP%>"%DKBRANCH_DIR%\cache"
    echo %TARGET_OS%>>"%DKBRANCH_DIR%\cache"
    echo %TYPE%>>"%DKBRANCH_DIR%\cache"
    ::echo %LEVEL%>>"%DKBRANCH_DIR%\cache"
goto:eof

:: read_cache
:read_cache
    echo reading cache...
    if not exist %DKBRANCH_DIR%\cache goto:eof
    set /a count = 0
    for /f "tokens=*" %%a in (%DKBRANCH_DIR%\cache) do (
        set a=%%a: =%
        ::echo !count!: %%a
        if !count! == 0 set "_APP_=%%a"
        if !count! == 1 set "_TARGET_OS_=%%a"
        if !count! == 2 set "_TYPE_=%%a"
        if !count! == 3 set "_LEVEL_=%%a"
        call set /a count += 1
    )
        
    set _APP_=%_APP_: =%
    set _TARGET_OS_=%_TARGET_OS_: =%
    set _TYPE_=%_TYPE_: =%
    set _LEVEL_=%_LEVEL_: =%
goto:eof

:: convert_to_c_identifier <in> <out>
:convert_to_c_identifier
    set "_input=%1"
    set "_output="
    set "map=abcdefghijklmnopqrstuvwxyz 1234567890"

    :c_identifier_loop
        if not defined _input goto c_identifier_endLoop    
        for /F "delims=*~ eol=*" %%C in ("!_input:~0,1!") do (
                if "!map:%%C=!" NEQ "!map!" set "_output=!_output!%%C"
                if "!map:%%C=!" EQU "!map!" set "_output=!_output!_"
        )
        set "_input=!_input:~1!"
    goto c_identifier_loop

    :c_identifier_endLoop
        set %2=!_output!
goto:eof

::convert_to_lowercase <in> <out>
:convert_to_lowercase
    set _string=%1
    set "_UCASE=ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    set "_LCASE=abcdefghijklmnopqrstuvwxyz"
	
	for /l %%a in (0,1,25) do (
        call set "_FROM=%%_UCASE:~%%a,1%%
        call set "_TO=%%_LCASE:~%%a,1%%
        call set "_string=%%_string:!_FROM!=!_TO!%%
    )
	::call:print_var _string
	set %2=%_string%
goto:eof

:::::::: print_var ::::::::
:print_var
	set var=%1
	call set value=%%%var%%%
	if "%var%" NEQ "" echo %var% = %value%
	::else
		::echo %1 = !!!INVALID!!!
goto:eof

:: kill_process <name>
:kill_process
	taskkill /IM "%1" /F > nul
goto:eof

:: end
:end
    echo "ERROR: reached the end of the script"
    pause
    exit
 

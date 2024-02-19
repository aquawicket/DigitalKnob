::############ DigitalKnob builder script ############
@echo off

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
	set SCRIPTPATH=%~dp0
	set SCRIPTPATH=%SCRIPTPATH:~0,-1%
	set SCRIPTNAME=%~nx0
	echo %SCRIPTPATH%\%SCRIPTNAME%

	set CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi
	set GIT_DL=https://github.com/git-for-windows/git/releases/download/v2.30.1.windows.1/Git-2.30.1-32-bit.exe
	set GIT_USER_EMAIL=aquawicket@hotmail.com
	set GIT_USER_NAME=aquawicket
	

    set "DIGITALKNOB=%HOMEDRIVE%%HOMEPATH%\digitalknob"
    call:make_directory "%DIGITALKNOB%"
    echo DIGITALKNOB = %DIGITALKNOB%

    set "DKDOWNLOAD=%DIGITALKNOB%\download"
    call:make_directory "%DKDOWNLOAD%"
    echo DKDOWNLOAD = %DKDOWNLOAD%

    call:validate_cmake
    call:validate_git
    call:validate_branch

    echo DKPATH = %DKPATH%
    echo DKCMAKE = %DKCMAKE%
    echo DK3RDPARTY = %DK3RDPARTY%
    echo DKIMPORTS = %DKIMPORTS%

    :while_loop             
        if "%UPDATE%"==""     call:pick_update & goto:while_loop
        if "%APP%"==""        call:pick_app    & goto:while_loop
        if "%TARGET_OS%"==""  call:pick_os     & goto:while_loop
        if "%TYPE%"==""       call:pick_type   & goto:while_loop

        call:generate
        if %TARGET_OS%==win32       call:generate_win32
        if %TARGET_OS%==win64       call:generate_win64
        if %TARGET_OS%==android32   call:generate_android32
        if %TARGET_OS%==android64   call:generate_android64
        if %TARGET_OS%==emscripten  call:generate_emscripten
                
        call:build
		if %TYPE%==All      call:build_all
		if %TYPE%==Release  call:build_release
        if %TYPE%==Debug    call:build_debug
       
        call:end_message
        
    goto while_loop
    :while_loop_end
goto:eof


:pick_update
    set UPDATE=
        
    echo.
    echo  1) Git Update
    echo  2) Git Commit
    echo  3) Push assets
    echo  4) Pull assets
    echo  5) Reset Apps
    echo  6) Reset Plugins
    echo  7) Reset 3rdParty
    echo  8) Reset All
    echo  9) Clear Screen
    echo  10) Clear cmake cache and .tmp files
    echo  11) Reload
    echo  12) Exit
    echo. 
    echo  Press Enter To Skip
        
    set choice=
    set /p "choice=Choose a selection: "
    if "%choice%"=="1"  call:git_update
    if "%choice%"=="2"  call:git_commit
    if "%choice%"=="3"  call:push_assets
    if "%choice%"=="4"  call:pull_assets
    if "%choice%"=="5"  call:reset_apps
    if "%choice%"=="6"  call:reset_plugins
    if "%choice%"=="7"  call:reset_3rdparty
    if "%choice%"=="8"  call:reset_all
    if "%choice%"=="9"  call:clear_screen
    if "%choice%"=="10" call:dk_deleteCache & call:delete_temp_files
    if "%choice%"=="11" call:reload
    if "%choice%"=="12" exit
	
    set UPDATE=true
goto:eof

:pick_app
	TITLE DigitalKnob - %APP% %TARGET_OS% %TYPE%
    
	set APP=  
    echo.
    echo  1) HelloWorld
    echo  2) DKCore
    echo  3) DKJavascript
    echo  4) DKBuilder
    echo  5) DKSDL
    echo  6) DKSDLRml
    echo  7) DKDomTest
    echo  8) DKTestAll
	echo  9) Enter Manually
    echo 10) Clear Screen
    echo 11) Reload
    echo 12) Go Back
    echo 13) Exit
    set choice=
    set /p choice=Please select an app to build:
    ::if not '%choice%'=='' set choice=%choice:~0,1%        ::What does this do?
    if "%choice%"=="1"  set "APP=HelloWorld"   & goto:eof
    if "%choice%"=="2"  set "APP=DKCore"       & goto:eof
    if "%choice%"=="3"  set "APP=DKJavascript" & goto:eof
    if "%choice%"=="4"  set "APP=DKBuilder"    & goto:eof
    if "%choice%"=="5"  set "APP=DKSDL"        & goto:eof
    if "%choice%"=="6"  set "APP=DKSDLRml"     & goto:eof
    if "%choice%"=="7"  set "APP=DKDomTest"    & goto:eof
    if "%choice%"=="8"  set "APP=DKTestAll"    & goto:eof
	if "%choice%"=="9"  call:enter_manually    & goto:eof
    if "%choice%"=="10" call:clear_screen      & goto:eof
    if "%choice%"=="11" call:reload            & goto:eof
    if "%choice%"=="12" set "UPDATE="          & goto:eof
    if "%choice%"=="13" exit                   & goto:eof
	
    echo %choice%: invalid selection, please try again
	set APP=
goto:eof


:checkApp
    if NOT exist "%DKPATH%\DKApps\%APP%\DKMAKE.cmake" (
        echo ERROR: %APP%/DKMAKE.cmake file not found
        set APP=
    ) 
goto:eof


:pick_os
    set TARGET_OS=
    TITLE DigitalKnob - %APP% %TARGET_OS% %TYPE%
        
    :: TODO
    :: 1) Windows (x86_64)

    :: 2) Android (arm32)
    :: 3) Android (arm64)
    :: 4) Android (x86)
    :: 5) Android (x86_64)
    :: 6) iOS (arm32)
    :: 7) iOS (arm64)
    :: 8) iOS (x86)
    :: 9) iOS (x86_64)
    :: 10) iOS-Simulator (arm32)
    :: 11) iOS-Simulator (arm64)
    :: 12) iOS-Simulator (x86)
    :: 13) iOS-Simulator (x86_64)
    :: 14) Linux (c)
    :: 15) Linux (arm64)
    :: 16) Linux (x86)
    :: 17) Linux (x86_64)
    :: 18) Mac (arm32)
    :: 19) Mac (arm64)
    :: 20) Mac (x86)
    :: 21) Mac (x86_64)
    :: 22) Raspberry (arm32)
    :: 23) Raspberry (arm64)
    :: 24) Raspberry (x86)
    :: 25) Raspberry (x86_64)
    :: 26) Windows (arm32)
    :: 27) Windows (arm64)
    :: 28) Windows (x86)
    :: 29) Windows (x86_64)
    :: 30) Clear Screen
    :: 31) Go Back
    :: 32) Exit
    echo %APP% %TARGET_OS% %TYPE%
    echo.
    echo 1) Windows 32
    echo 2) Windows 64
    echo 3) Android 32
    echo 4) Android 64
    echo 5) Emscripten
    echo 6) Clear Screen
    echo 7) Go Back
    echo 8) Exit
    set choice=
    set /p choice=Please select an OS to build for: 
    ::if not "%choice%"=="" set choice=%choice:~0,1%        ::What does this do?
    if "%choice%"=="1" set "TARGET_OS=win32"		& goto:eof
    if "%choice%"=="2" set "TARGET_OS=win64"		& goto:eof
    if "%choice%"=="3" set "TARGET_OS=android32"	& goto:eof
    if "%choice%"=="4" set "TARGET_OS=android64"	& goto:eof
    if "%choice%"=="5" set "TARGET_OS=emscripten"	& goto:eof
    if "%choice%"=="6' call:clear_screen			& goto:eof
    if "%choice%"=="7" set "APP="					& goto:eof
    if "%choice%"=="8" exit							& goto:eof
	echo %choice%: invalid selection, please try again
	set TARGET_OS=
goto:eof


:pick_type
    set TYPE=
    TITLE DigitalKnob - %APP% %TARGET_OS% %TYPE%
        
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

:generate
    TITLE DigitalKnob - Generating %APP%_%TARGET_OS%_%TYPE% %LEVEL% . . .
    echo.
    echo ########################################################## 
    echo ****** Generating %APP% - %TARGET_OS% - %TYPE% - %LEVEL% ******
    echo ##########################################################
    echo.

    call:dk_deleteCache
    call:delete_temp_files
	
	if "%TARGET_PATH%"=="" set "TARGET_PATH=%DKPATH%\DKApps\%APP%"
    call:make_directory "%TARGET_PATH%\%TARGET_OS%"
    cd "%TARGET_PATH%\%TARGET_OS%"
	echo APP = %APP%
	echo TARGET_OS = %TARGET_OS%
	echo TYPE = %TYPE%
	echo LEVEL = %LEVEL%
	call set CMAKE_TARGET_PATH=%%TARGET_PATH:^\=^/%%
	echo TARGET_PATH = %TARGET_PATH%
	echo CMAKE_TARGET_PATH = %CMAKE_TARGET_PATH%	
	
    ::::::::: BUILD CMAKE_ARGS ARRAY :::::::::
    set DKLEVEL=RebuildAll
    set DKLINK=Static

    set CMAKE_ARGS=
    if %TYPE%==Debug            set "CMAKE_ARGS=-DDEBUG=ON -DRELEASE=OFF"
    if %TYPE%==Release          set "CMAKE_ARGS=-DDEBUG=OFF -DRELEASE=ON"
    if %TYPE%==All              set "CMAKE_ARGS=-DDEBUG=ON -DRELEASE=ON"
    if %DKLEVEL%==Build         set "CMAKE_ARGS=%CMAKE_ARGS% -DBUILD=ON"
    if %DKLEVEL%==Rebuild       set "CMAKE_ARGS=%CMAKE_ARGS% -DREBUILD=ON"
    if %DKLEVEL%==RebuildAll    set "CMAKE_ARGS=%CMAKE_ARGS% -DREBUILDALL=ON"
    if %DKLINK%==Static         set "CMAKE_ARGS=%CMAKE_ARGS% -DSTATIC=ON"
    if %DKLINK%==Shared         set "CMAKE_ARGS=%CMAKE_ARGS% -DSHARED=ON"
        
    :::::::::::: CMake Options :::::::::::::
    set "CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_VERBOSE_MAKEFILE=1"
    ::set "CMAKE_ARGS=%CMAKE_ARGS% --debug-output"
    ::set "CMAKE_ARGS=%CMAKE_ARGS% --trace"
    ::set "CMAKE_ARGS=%CMAKE_ARGS% --warn-unused-vars"

    :::::::::::: GENERATOR ::::::::::::

    :::::::::::: MAKE_PROGRAM ::::::::::::

    :::::::::::: C_COMPILER; CXX_COMPILER ::::::::::::

    :::::::::::: EXE_LINKER_FLAGS ::::::::::::
        
goto:eof

:generate_win32
		set COMPILER=MINGW32
		
		::call:validate_msys2
		call:cmake_eval "include('%DKIMPORTS%/msys2/DKMAKE.cmake')"
		
		::call:validate_msys2
        call:cmake_eval "include('%DKIMPORTS%/msys2/DKMAKE.cmake')" "MSYS2;MSYS2_GENERATOR" "-DMSYSTEM=MINGW32"
        echo MSYS2 = %MSYS2%
        echo MSYS2_GENERATOR = %MSYS2_GENERATOR%
		
		::call:validate_cmake
        call:cmake_eval "include('%DKIMPORTS%/cmake/DKMAKE.cmake')" "CMAKE_EXE" "-DMSYSTEM=MINGW32"
        echo CMAKE_EXE = %CMAKE_EXE%
                     
        ::call:validate_gcc
        call:cmake_eval "include('%DKIMPORTS%/gcc/DKMAKE.cmake')" "GCC_C_COMPILER;GCC_CXX_COMPILER" "-DMSYSTEM=MINGW32"
        echo GCC_C_COMPILER = %GCC_C_COMPILER%
        echo GCC_CXX_COMPILER = %GCC_CXX_COMPILER%
        set "CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_C_COMPILER=%GCC_C_COMPILER%"
        set "CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_CXX_COMPILER=%GCC_CXX_COMPILER%"
                
        ::call:validate_make
        call:cmake_eval "include('%DKIMPORTS%/make/DKMAKE.cmake')" "MAKE_PROGRAM" "-DMSYSTEM=MINGW32"
		echo MAKE_PROGRAM = %MAKE_PROGRAM%
                
        call set DKPATH=%%DKPATH:^\=^/%%
        %MSYS2%/usr/bin/env MSYSTEM=MINGW32 /usr/bin/bash -lc "'%CMAKE_EXE%' -G '%MSYS2_GENERATOR%' -DMSYSTEM=MINGW32 %CMAKE_ARGS% -S%DKCMAKE% -B%DKPATH%/DKApps/%APP%/%TARGET_OS%/Debug"
        set TARGET=%APP%_APP
        goto build

	
    ::call:validate_visual_studio
    ::set "CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_C_COMPILER=%VISUALSTUDIO_X86_CXX_COMPILER%"
    ::set "CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_CXX_COMPILER=%VISUALSTUDIO_X86_CXX_COMPILER%"
    ::"%CMAKE%" -G "%VISUALSTUDIO_GENERATOR%" -A Win32 %CMAKE_ARGS% "%DKCMAKE%"
    ::set TARGET=%APP%_APP
goto:eof

:generate_win64
		set COMPILER=MINGW64
		
		::call:validate_msys2
		call:cmake_eval "include('%DKIMPORTS%/msys2/DKMAKE.cmake')"
		
		::call:validate_msys2
        call:cmake_eval "include('%DKIMPORTS%/msys2/DKMAKE.cmake')" "MSYS2;MSYS2_GENERATOR" "-DMSYSTEM=MINGW64"
        echo MSYS2 = %MSYS2%
        echo MSYS2_GENERATOR = %MSYS2_GENERATOR%
		
		::call:validate_cmake
        call:cmake_eval "include('%DKIMPORTS%/cmake/DKMAKE.cmake')" "CMAKE_EXE" "-DMSYSTEM=MINGW64"
        echo CMAKE_EXE = %CMAKE_EXE%
                
        ::call:validate_gcc
        call:cmake_eval "include('%DKIMPORTS%/gcc/DKMAKE.cmake')" "GCC_C_COMPILER;GCC_CXX_COMPILER" "-DMSYSTEM=MINGW64"
        echo GCC_C_COMPILER = %GCC_C_COMPILER%
        echo GCC_CXX_COMPILER = %GCC_CXX_COMPILER%
        set "CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_C_COMPILER=%GCC_C_COMPILER%"
        set "CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_CXX_COMPILER=%GCC_CXX_COMPILER%"
                
        ::call:validate_make
        call:cmake_eval "include('%DKIMPORTS%/make/DKMAKE.cmake')" "MAKE_PROGRAM" "-DMSYSTEM=MINGW64"
		echo MAKE_PROGRAM = %MAKE_PROGRAM%
                
        call set DKPATH=%%DKPATH:^\=^/%%
        %MSYS2%/usr/bin/env MSYSTEM=MINGW64 /usr/bin/bash -lc "'%CMAKE_EXE%' -G '%MSYS2_GENERATOR%' -DMSYSTEM=MINGW64 %CMAKE_ARGS% -S%DKCMAKE% -B%DKPATH%/DKApps/%APP%/%TARGET_OS%/Debug"
        set TARGET=%APP%_APP
        goto build
    
    ::call:validate_visual_studio
    ::set "CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_C_COMPILER=%VISUALSTUDIO_X64_CXX_COMPILER%"
    ::set "CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_CXX_COMPILER=%VISUALSTUDIO_X64_CXX_COMPILER%"
    ::"%CMAKE%" -G "%VISUALSTUDIO_GENERATOR%" -A x64 %CMAKE_ARGS% %DKCMAKE%
    ::set TARGET=%APP%_APP
goto:eof

:generate_android32
    ::call:validate_visual_studio
    call:validate_android_ndk
    call:validate_openjdk
    call %OPENJDK%\registerJDK.cmd
    "%CMAKE%" -G "%VISUALSTUDIO_GENERATOR%" -A ARM -DANDROID_ABI=armeabi-v7a -DANDROID_PLATFORM=%ANDROID_API% -DANDROID_NDK=%ANDROID_NDK% -DCMAKE_TOOLCHAIN_FILE=%ANDROID_TOOLCHAIN_FILE% -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -S%DKCMAKE% -B%CMAKE_TARGET_PATH%/%TARGET_OS%
    set TARGET=main
goto:eof

:generate_android64
    ::call:validate_visual_studio
    call:validate_android_ndk
    call:validate_openjdk
    call %OPENJDK%\registerJDK.cmd
    "%CMAKE%" -G "%VISUALSTUDIO_GENERATOR%" -A ARM64 -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=%ANDROID_API% -DANDROID_NDK=%ANDROID_NDK% -DCMAKE_TOOLCHAIN_FILE=%ANDROID_TOOLCHAIN_FILE% -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -S%DKCMAKE% -B%CMAKE_TARGET_PATH%/%TARGET_OS%
    set TARGET=main
goto:eof



:generate_emscripten
    call:validate_emscripten
	set "CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_TOOLCHAIN_FILE=%EMSDK_TOOLCHAIN_FILE%"
	set "CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_C_COMPILER=%EMSDK_C_COMPILER%"
	set "CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_CXX_COMPILER=%EMSDK_CXX_COMPILER%"
	
	set "debug=0==1"
	set "release=0==1"
    if %TYPE%==Debug set "debug=1==1"
	if %TYPE%==Release set "release=1==1"
	if %TYPE%==All set "debug=1==1" & set "release=1==1"
	
	set TARGET=%APP%_APP
	
	if %debug% "%EMSDK_ENV%" && "%CMAKE%" -G "%EMSDK_GENERATOR%" %CMAKE_ARGS% -S%DKCMAKE% -B%CMAKE_TARGET_PATH%/%TARGET_OS%/Debug
	if %release% "%EMSDK_ENV%" && "%CMAKE%" -G "%EMSDK_GENERATOR%" %CMAKE_ARGS% -S%DKCMAKE% -B%CMAKE_TARGET_PATH%/%TARGET_OS%/Release
goto:eof


:build
    TITLE DigitalKnob - Building %APP%_%TARGET_OS%_%TYPE% %DKLEVEL% . . .
    echo.
    echo ###########################################################        
    echo ****** Building %APP% - %TARGET_OS% - %TYPE% - %DKLEVEL% ******
    echo ###########################################################
    echo.
goto:eof

:build_all

:build_debug
	if "%COMPILER%"=="MINGW32" (
        %MSYS2%/usr/bin/env MSYSTEM=MINGW32 /usr/bin/bash -lc "'%CMAKE_EXE%' --build %CMAKE_TARGET_PATH%/%TARGET_OS%/Debug --target %TARGET% --config Debug --verbose"
		if %TYPE%==All goto:build_release
		goto:end_message
    )
    if "%COMPILER%"=="MINGW64" (
        %MSYS2%/usr/bin/env MSYSTEM=MINGW64 /usr/bin/bash -lc "'%CMAKE_EXE%' --build %CMAKE_TARGET_PATH%/%TARGET_OS%/Debug --target %TARGET% --config Debug --verbose"
		if %TYPE%==All goto:build_release
		goto:end_message
    )
        
    if exist %TARGET_PATH%\%TARGET_OS%\Debug\CMakeCache.txt (
		echo "%CMAKE%" --build %TARGET_PATH%\%TARGET_OS%\Debug --target %TARGET% --config Debug --verbose
        "%CMAKE%" --build %TARGET_PATH%\%TARGET_OS%\Debug --target %TARGET% --config Debug --verbose
    )
    if exist %TARGET_PATH%\%TARGET_OS%\CMakeCache.txt (
		echo "%CMAKE%" --build %TARGET_PATH%\%TARGET_OS% --target %TARGET% --config Debug --verbose
        "%CMAKE%" --build %TARGET_PATH%\%TARGET_OS% --target %TARGET% --config Debug --verbose
    )
	
	if %TYPE%==All goto:build_release
	goto:end_message
goto:eof

:build_release
	if "%COMPILER%"=="MINGW32" (
        %MSYS2%/usr/bin/env MSYSTEM=MINGW32 /usr/bin/bash -lc "'%CMAKE_EXE%' --build %CMAKE_TARGET_PATH%/%TARGET_OS%/Release --target %TARGET% --config Debug --verbose"
        goto end_message
    )
    if "%COMPILER%"=="MINGW64" (
        %MSYS2%/usr/bin/env MSYSTEM=MINGW64 /usr/bin/bash -lc "'%CMAKE_EXE%' --build %CMAKE_TARGET_PATH%/%TARGET_OS%/Release --target %TARGET% --config Debug --verbose"
        goto end_message
    )
	
    if exist %TARGET_PATH%\%TARGET_OS%\Release\CMakeCache.txt (
        "%CMAKE%" --build %TARGET_PATH%\%TARGET_OS%\Release --target %TARGET% --config Release --verbose
    )
    if exist %TARGET_PATH%\%TARGET_OS%\CMakeCache.txt (
        "%CMAKE%" --build %TARGET_PATH%\%TARGET_OS% --target %TARGET% --config Release --verbose
    )
goto:eof


:end_message
    echo:
    echo ******* Done building %APP% - %TARGET_OS% - %TYPE% *******
        
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
	::cd %DIGITALKNOB%
	::for /f "delims=" %%a in ('dir /b /s /a-d DKMAKE.cmake ^| findstr /E /R "%input%\\DKMAKE.cmake" ') do set "path=%%a"
	::set "TARGET_PATH=%path:~0,-13%"
	
	if exist "%DKPATH%\3rdParty\_DKIMPORTS\%input%\DKMAKE.cmake" set "TARGET_PATH=%DKPATH%\3rdParty\_DKIMPORTS\%input%"
	if exist "%DKPATH%\DKPlugins\%input%\DKMAKE.cmake" set "TARGET_PATH=%DKPATH%\DKPlugins\%input%"
	if exist "%DKPATH%\DKApps\%input%\DKMAKE.cmake" set "TARGET_PATH=%DKPATH%\DKApps\%input%"
	
	::echo TARGET_PATH = %TARGET_PATH%
	
	call:get_parent_folder %TARGET_PATH% parent
	::echo parent = %parent%
	
	if %parent%==DKApps goto:eof
	call:make_directory  %DKPATH%\DKApps\%APP%
	echo dk_depend(%input%)> %DKPATH%\DKApps\%APP%\DKMAKE.cmake
	
	echo.
	::echo %input%
	echo %TARGET_PATH%
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

	set /P CONFIRM=Are you sure (Y)?
	if /I "%CONFIRM%" NEQ "Y" goto:eof

	cd %DKPATH%\DKApps
	"%GIT%" clean -f -d
goto:eof


:: reset_plugins()
:reset_plugins
	echo Resetting DKPlugins . . .

	set /P CONFIRM=Are you sure (Y)?
	if /I "%CONFIRM%" NEQ "Y" goto:eof
	
	cd %DKPATH%\DKPlugins
	"%GIT%" clean -f -d
goto:eof


:: reset_3rdparty()
:reset_3rdparty
	echo Resetting 3rdParty Libraries . . .
	
	set /P CONFIRM=Are you sure (Y)?
	if /I "%CONFIRM%" NEQ "Y" goto:eof
	
	cd %DKPATH%\3rdParty
	"%GIT%" clean -f -d
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
	
	set /P CONFIRM=Are you sure (Y)?
	if /I "%CONFIRM%" NEQ "Y" goto:eof
	
	:: first we need to relocate this file up one directory
	:: make sure script is running from DKPATH
    if not "%SCRIPTPATH%" == "%DKPATH%" (
		echo WARNING: this file isn't running from the branch directory
		echo Is must be in the branch directory to continue.
		echo SCRIPTPATH = %SCRIPTPATH%
		echo DKPATH = %DKPATH%
		goto:oef
	)
	
	echo "RELOCATING SCRIPT TO -> %DIGITALKNOB%\%SCRIPTNAME%"
    copy /Y %SCRIPTPATH%\%SCRIPTNAME% %DIGITALKNOB%\%SCRIPTNAME%
	start "" "%DIGITALKNOB%\%SCRIPTNAME%" :reset_all wipe
	exit	
	
	::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	:wipe	
	::do we need admin rights?
	::runas /user:Administrator cmd
	
	::do we need to kill any processes?
	
	::do we need to uninstall any apps?
	
	::do we need to remove any environment variables?
	
	::should we do a git clean first?
	::cd %DKPATH%
	::"%GIT%" clean -f -d
	
	cd %DIGITALKNOB%
	echo.
	echo DELETING %DKDOWNLOAD% . . . .
	call rmdir %DKDOWNLOAD% /s /q
	echo done.
	echo.
	echo DELETING %DKPATH% . . . .
	call rmdir %DKPATH% /s /q
	echo done.
	
	:: wait 10 seconds at lease for the folders to get deleted
	ping 127.0.0.1 -n 6 >nul
	ping 127.0.0.1 -n 6 >nul
	
	if exist %DKDOWNLOAD% echo "Oh no, the downloads folder is still there! :( "
	if exist %DKPATH% echo "Oh no, the BRANCH folder is still there! :( "
	
	call:git_update NO_CONFIRM
	
	start "" "%DKPATH%\%SCRIPTNAME%" & del /f %DIGITALKNOB%\%SCRIPTNAME% & exit
goto:eof


:: reload()
:reload
    echo .
    echo reloading %SCRIPTNAME%
    start "" "%SCRIPTPATH%\%SCRIPTNAME%"
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
    )
    if NOT exist "%~2" (
        echo please wait . . .
        certutil.exe -urlcache -split -f %~1 %~2
    )
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
        "%GIT%" branch | find "* %FOLDER%" > NUL & IF ERRORLEVEL 0 (
            set DKBRANCH=%FOLDER%
        )
    )

    ::echo DKBRANCH = %DKBRANCH%
    set "DKPATH=%DIGITALKNOB%\%DKBRANCH%"
    set "DKCMAKE=%DKPATH%\DKCMake"
    set "DK3RDPARTY=%DKPATH%\3rdParty"
    set "DKIMPORTS=%DK3RDPARTY%\_DKIMPORTS"

    :: make sure script is running from DKPATH
    ::if not %SCRIPTPATH% == %DKPATH% (
    ::      if not exist %DKPATH%\%SCRIPTNAME% (
    ::              copy %SCRIPTPATH%\%SCRIPTNAME% %DKPATH%\%SCRIPTNAME%
    ::      )
    ::      echo .
    ::      echo "RELOADING SCRIPT TO -> %DKPATH%\%SCRIPTNAME%"
    ::      pause
    ::      start "" "%DKPATH%\%SCRIPTNAME%"
    ::      if exist %DKPATH%\%SCRIPTNAME% (
    ::              del "%SCRIPTPATH%\%SCRIPTNAME%"
    ::      )
    ::      exit
    ::)
    call:check_error
goto:eof


:: validate_git()
:validate_git
    if NOT exist "%GIT%" (
        call:command_to_variable where git.exe GIT
    )
    if NOT exist "%GIT%" (
        call:command_to_variable where /R "%ProgramFiles(x86)%\Git" git.exe GIT
    )
    if NOT exist "%GIT%" (
        call:command_to_variable where /R "%ProgramFiles%\Git" git.exe GIT
    )
    call:get_filename %GIT_DL% GIT_DL_FILE
    if NOT exist "%GIT%" (
        echo "installing git"
        call:download %GIT_DL% "%DKDOWNLOAD%\%GIT_DL_FILE%"
        "%DKDOWNLOAD%\%GIT_DL_FILE%" /VERYSILENT /NORESTART
        call:command_to_variable where git GIT
    )
    if NOT exist "%GIT%" (
        call:assert "cannot find git"
    )
    echo GIT = %GIT%
    call:check_error
goto:eof


:: validate_cmake()
:validate_cmake
    if NOT exist "%CMAKE%" (
        call:command_to_variable where cmake.exe CMAKE
    )
    if NOT exist "%CMAKE%" (
        call:command_to_variable where /R "%ProgramFiles%\CMake" cmake.exe CMAKE
    )
    if NOT exist "%CMAKE%" (
        call:command_to_variable where /R "%ProgramFiles(x86)%\CMake" cmake.exe CMAKE
    )
    call:get_filename %CMAKE_DL% CMAKE_DL_FILE
    if NOT exist "%CMAKE%" (
        echo "installing cmake"
        echo CMAKE_DL_FILE = %CMAKE_DL_FILE%
        call:download %CMAKE_DL% "%DKDOWNLOAD%\%CMAKE_DL_FILE%"

        MsiExec.exe /i "%DKDOWNLOAD%\%CMAKE_DL_FILE%" /qn
        
        if NOT exist "%CMAKE%" (
            call:command_to_variable where /R "%ProgramFiles%\CMake\bin" cmake.exe CMAKE
        )
        if NOT exist "%CMAKE%" (
            call:command_to_variable where /R "%ProgramFiles(x86)%\CMake\bin" cmake.exe CMAKE
        )
    )
    if NOT exist "%CMAKE%" (
        call:assert "cannot find cmake"
    )
    echo CMAKE = %CMAKE%
    call:check_error
goto:eof


:: validate_visual_studio()
:validate_visual_studio
    call:cmake_eval "include('%DKIMPORTS%/visualstudio/DKMAKE.cmake')" "VISUALSTUDIO_GENERATOR;VISUALSTUDIO_X86_CXX_COMPILER;VISUALSTUDIO_X64_CXX_COMPILER;"
    call:check_error
goto:eof

:: validate_msys2()
:validate_msys2
    call:cmake_eval "include('%DKIMPORTS%/msys2/DKMAKE.cmake')" "MSYS2;MSYS2_GENERATOR"
    call:check_error
goto:eof

:: validate_gcc()
:validate_gcc
    call:cmake_eval "include('%DKIMPORTS%/gcc/DKMAKE.cmake')" "GCC_C_COMPILER;GCC_CXX_COMPILER"
    call:check_error
goto:eof

:: validate_make()
:validate_make
    call:cmake_eval "include('%DKIMPORTS%/make/DKMAKE.cmake')" "MAKE_PROGRAM"
    call:check_error
goto:eof

:: validate_openjdk()
:validate_openjdk
    call:cmake_eval "include('%DKIMPORTS%/openjdk/DKMAKE.cmake')" "OPENJDK"
    call:check_error
goto:eof

:: validate_android_ndk()
:validate_android_ndk
    call:cmake_eval "include('%DKIMPORTS%/android-ndk/DKMAKE.cmake')" "ANDROID_API;ANDROID_NDK;ANDROID_TOOLCHAIN_FILE"
    echo ANDROID_API = %ANDROID_API%
    echo ANDROID_NDK = %ANDROID_NDK%
    echo ANDROID_TOOLCHAIN_FILE = %ANDROID_TOOLCHAIN_FILE%
    call:check_error
goto:eof


:: validate_emscripten()
:validate_emscripten
    call:cmake_eval "include('%DKIMPORTS%/emsdk/DKMAKE.cmake')" "EMSDK;EMSDK_ENV;EMSDK_GENERATOR;EMSDK_TOOLCHAIN_FILE;EMSDK_C_COMPILER;EMSDK_CXX_COMPILER"
    echo EMSDK = %EMSDK%
    echo EMSDK_ENV = %EMSDK_ENV%
    echo EMSDK_GENERATOR = %EMSDK_GENERATOR%
    echo EMSDK_TOOLCHAIN_FILE = %EMSDK_TOOLCHAIN_FILE%
	echo EMSDK_C_COMPILER = %EMSDK_C_COMPILER%
	echo EMSDK_CXX_COMPILER = %EMSDK_CXX_COMPILER%
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

    for /F "tokens=*" %%g in ('%command%') do (
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
    cd "%DIGITALKNOB%"
    for /r %%i in (CMakeCache.*) do del "%%i"
    for /d /r %%i in (*CMakeFiles*) do rd /s /q "%%i"
    call:check_error
goto:eof


:: delete_temp_files()
:delete_temp_files
    ::call:cmake_eval "dk_deleteTempFiles()"
    echo Deleteing .tmp files . . .
    cd "%DIGITALKNOB%"
    for /r %%i in (*.tmp) do del "%%i"
    for /r %%i in (*.TMP) do del "%%i"
    call:check_error
goto:eof


:: git_update() NO_CONFIRM
:git_update
	if ! ["%1"] == ["NO_CONFIRM"] (
		echo Git Update? Any local changes will be lost.
		set /P CONFIRM=Are you sure (Y)?
		if /I "%CONFIRM%" NEQ "Y" goto:eof
	)
	
    if NOT exist "%DKPATH%\.git" (
        "%GIT%" clone https://github.com/aquawicket/DigitalKnob.git "%DKPATH%"
    )
    call:check_error

    cd "%DKPATH%"
    "%GIT%" pull --all
    "%GIT%" checkout -- .
    call:check_error

    "%GIT%" checkout %DKBRANCH%
    if NOT "%ERRORLEVEL%" == "0" (
        echo Remote has no %DKBRANCH% branch. Creating...
        "%GIT%" checkout -b %DKBRANCH% main
        "%GIT%" push --set-upstream origin %DKBRANCH%
    )

    call:check_error
goto:eof


:: git_commit()
:git_commit
	echo Git Commit
	set /P CONFIRM=Are you sure (Y)?
	if /I "%CONFIRM%" NEQ "Y" goto:eof
	
	echo "Please enter some details about this commit, then press enter."
	set /p message=">"
	
    cd %DKPATH%
	call:command_to_variable "%GIT%" config --global user.email USER_EMAIL
    if not "%USER_EMAIL%"=="%GIT_USER_EMAIL%" "%GIT%" config --global user.email "%GIT_USER_EMAIL%"
	
	call:command_to_variable "%GIT%" config --global user.email USER_NAME
    if not "%USER_NAME%"=="%GIT_USER_NAME%" "%GIT%" config --global user.name "%GIT_USER_NAME%"
	
	call:command_to_variable "%GIT%" config --global credential.helper STORE
	if not "%STORE%"=="store" "%GIT%" config --global credential.helper store
	 
	if ["%message%"]==[""] set "message=git commit"
	"%GIT%" commit -a -m "%message%"
    "%GIT%" push
	
    call:check_error
goto:eof

:: clear_screen()
:clear_screen
    cls
goto:eof


:: cmake_eval <cmake_commands;.;.;> <return_variables;.;.;.> <-DVARS;.;.;>
:cmake_eval
    if [%1] == [] (
        echo "ERROR: cmake_eval() parameter1 is invalid"
        goto:eof
    )
    if not exist "%CMAKE%" ( 
        echo "ERROR: Could not locate CMAKE" 
        goto:eof
    )
    if not exist "%DKCMAKE%" ( 
        echo "ERROR: Could not locate DKCMAKE" 
        goto:eof
    )

    set commands=%1
    set variables=%2

    call set commands=%%commands:"=%%
    set "DKCOMMAND=%commands%"
    call set DKCOMMAND=%%DKCOMMAND:^\=^/%%
    echo DKCOMMAND = %DKCOMMAND%

    set "EVAL_VARS=%DKCMAKE%\cmake_vars.cmd"
    call set DKCMAKE=%%DKCMAKE:^\=^/%%
        
    ::echo "%CMAKE%" "-DDKCMAKE=%DKCMAKE%" "-DDKCOMMAND=%DKCOMMAND%" -P "%DKCMAKE%/dev/cmake_eval.cmake" --log-level=TRACE >cmake_eval.out 2>cmake_eval.err

    if [%2] == [] goto no_return_values
    goto with_return_values

    :no_return_values
        "%CMAKE%" "-DDKCMAKE=%DKCMAKE%" "-DDKCOMMAND=%DKCOMMAND%" -P "%DKCMAKE%/dev/cmake_eval.cmake"
        goto:eof

    :with_return_values
        "%CMAKE%" "-DDKCMAKE=%DKCMAKE%" "-DDKCOMMAND=%DKCOMMAND%" "-DDKRETURN=%~2" %~3 -P %DKCMAKE%/dev/cmake_eval.cmake
        if not exist %DKCMAKE%/cmake_vars.cmd goto:eof
        call %EVAL_VARS%
        ::del %EVAL_VARS%
        goto:eof

    ::echo return code: %ERRORLEVEL%

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

:: command_exists <command> <result>
:::command_exists
::	set "command=%1"
::	cmd /c "(help %command% > nul || exit 0) && where %command% > nul 2> nul"
::	if %ERRORLEVEL% EQU 0 set "%2=1" & goto:eof
::	set "%2=0"
::goto:eof

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


:end
	echo "ERROR: reached the end of the script"
	pause
	exit

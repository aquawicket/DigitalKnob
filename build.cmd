::############ DigitalKnob builder script ############
@echo off

::--------------------------------------------------------
:: keep window open
::--------------------------------------------------------
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

::--------------------------------------------------------
:: convert line endings
::--------------------------------------------------------
::if '%~nx0'=='build.cmd' (
::    more /P build.cmd >build_crlf.cmd
::    del build.cmd & rename build_crlf.cmd build.cmd
::)


::--------------------------------------------------------
:: GLOBAL USER VARIABLES
::--------------------------------------------------------
set "SCRIPTPATH=%~dp0"
set "SCRIPTPATH=%SCRIPTPATH:~0,-1%"
set "SCRIPTNAME=%~nx0"
echo %SCRIPTPATH%\%SCRIPTNAME%

set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi"
set "GIT_DL=https://github.com/git-for-windows/git/releases/download/v2.30.1.windows.1/Git-2.30.1-32-bit.exe"
set "GIT_USER_EMAIL=aquawicket@hotmail.com"
set "GIT_USER_NAME=aquawicket"


::--------------------------------------------------------
:: Main
::--------------------------------------------------------
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




set "APP="
set "OS="
set "TYPE="

:pickapp
    echo.
    echo  1) Git Update
    echo  2) Git Commit
    echo  3) HelloWorld
    echo  4) DKCore
    echo  5) DKJavascript
    echo  6) DKBuilder
    echo  7) DKSDL
    echo  8) DKSDLRml
    echo  9) DKDomTest
    echo 10) DKTestAll
    echo 11) Clear Screen
    echo 12) Reload
    echo 13) Exit
    set choice=
    set /p choice=Please select an app to build:
    ::if not '%choice%'=='' set choice=%choice:~0,1%        ::What does this do?
    if '%choice%'=='1' call:git_update & goto pickapp
    if '%choice%'=='2' call:git_commit & goto pickapp
    if '%choice%'=='3' set "APP=HelloWorld" & goto checkApp
    if '%choice%'=='4' set "APP=DKCore" & goto checkApp
    if '%choice%'=='5' set "APP=DKJavascript" & goto checkApp
    if '%choice%'=='6' set "APP=DKBuilder" & goto checkApp
    if '%choice%'=='7' set "APP=DKSDL" & goto checkApp
    if '%choice%'=='8' set "APP=DKSDLRml" & goto checkApp
    if '%choice%'=='9' set "APP=DKDomTest" & goto checkApp
    if '%choice%'=='10' set "APP=DKTestAll" & goto checkApp
    if '%choice%'=='11' call:clear_screen & goto pickapp
    if '%choice%'=='12' call:reload
    if '%choice%'=='13' call:end
    echo "%choice%" is not valid, try again
goto pickapp



:checkApp
    if NOT exist "%DKPATH%\DKApps\%APP%\DKMAKE.cmake" (
        echo ERROR: %APP%/DKMAKE.cmake file not found
        goto pickapp
    ) 
goto pickos



:pickos
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
    echo %APP%
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
    ::if not '%choice%'=='' set choice=%choice:~0,1%        ::What does this do?
    if '%choice%'=='1' set "OS=win32" & goto type
    if '%choice%'=='2' set "OS=win64" & goto type
    if '%choice%'=='3' set "OS=android32" & goto type
    if '%choice%'=='4' set "OS=android64" & goto type
    if '%choice%'=='5' set "OS=emscripten" & goto type
    if '%choice%'=='6' call:clear_screen & goto pickos
    if '%choice%'=='7' goto pickapp
    if '%choice%'=='8' call:end
    echo "%choice%" is not valid, try again
    goto pickos



:type
    echo %APP% - %OS%
    echo.
    echo 1) Debug
    echo 2) Release
    echo 3) All
    echo 4) Clear Screen
    echo 5) Go Back
    echo 6) Exit
    set choice=
    set /p choice=Please select a build type: 
    ::if not '%choice%'=='' set choice=%choice:~0,1%        ::What does this do?
    if '%choice%'=='1' set "TYPE=Debug" & goto generate
    if '%choice%'=='2' set "TYPE=Release" & goto generate
    if '%choice%'=='3' set "TYPE=All" & goto generate
    if '%choice%'=='4' call:clear_screen & goto type
    if '%choice%'=='5' goto pickos
    if '%choice%'=='6' call:end
    echo "%choice%" is not valid, try again
    goto type


:generate
    echo ""
    echo ########################################################## 
    echo ****** Generating %APP% - %OS% - %TYPE% - %LEVEL% ******
    echo ##########################################################
    echo ""

    call:dk_deleteCache
    call:delete_temp_files

    set "APP_PATH=%DKPATH%\DKApps\%APP%"
    echo APP_PATH = %APP_PATH%
    call:make_directory "%APP_PATH%\%OS%"
    cd "%APP_PATH%\%OS%"


    ::::::::: BUILD CMAKE_ARGS ARRAY :::::::::
    set "DKLEVEL=RebuildAll"
    set "DKLINK=Static"

    set "CMAKE_ARGS="
    if %TYPE%==Debug                set "CMAKE_ARGS=-DDEBUG=ON -DRELEASE=OFF"
    if %TYPE%==Release              set "CMAKE_ARGS=-DDEBUG=OFF -DRELEASE=ON"
    if %TYPE%==All                  set "CMAKE_ARGS=-DDEBUG=ON -DRELEASE=ON"
    if %DKLEVEL%==Build             set "CMAKE_ARGS=%CMAKE_ARGS% -DBUILD=ON"
    if %DKLEVEL%==Rebuild           set "CMAKE_ARGS=%CMAKE_ARGS% -DREBUILD=ON"
    if %DKLEVEL%==RebuildAll        set "CMAKE_ARGS=%CMAKE_ARGS% -DREBUILDALL=ON"
    if %DKLINK%==Static             set "CMAKE_ARGS=%CMAKE_ARGS% -DSTATIC=ON"
    if %DKLINK%==Shared             set "CMAKE_ARGS=%CMAKE_ARGS% -DSHARED=ON"
                                    set "CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_VERBOSE_MAKEFILE=1"

    :::::::::::: GENERATOR ::::::::::::

    :::::::::::: MAKE_PROGRAM ::::::::::::

    :::::::::::: C_COMPILER; CXX_COMPILER ::::::::::::

    :::::::::::: EXE_LINKER_FLAGS ::::::::::::


    :: Goto OS to build
    if %OS%==win32 goto generate_win32
    if %OS%==win64 goto generate_win64
    if %OS%==android32 goto generate_android32
    if %OS%==android64 goto generate_android64
    if %OS%==emscripten goto generate_emscripten

:generate_win32
    ::call:validate_visual_studio
    ::"CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_C_COMPILER=%VISUALSTUDIO_X86_CXX_COMPILER%"
    ::"CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_CXX_COMPILER=%VISUALSTUDIO_X86_CXX_COMPILER%"
    ::"%CMAKE%" -G "%VISUALSTUDIO_GENERATOR%" -A Win32 %CMAKE_ARGS% "%DKCMAKE%"
    ::set TARGET=%APP%_APP

    call:validate_msys2
    ::TITLE DigitalKnob - MINGW32
    ::call set DKPATH=%%DKPATH:^\=^/%%
    ::%MSYS2%/usr/bin/env MSYSTEM=MINGW32 /usr/bin/bash -lc "clear && %DKPATH%/build.sh"
    ::goto:eof
goto build

:generate_win64
    ::call:validate_visual_studio
    ::"CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_C_COMPILER=%VISUALSTUDIO_X64_CXX_COMPILER%"
    ::"CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_CXX_COMPILER=%VISUALSTUDIO_X64_CXX_COMPILER%"
    ::"%CMAKE%" -G "%VISUALSTUDIO_GENERATOR%" -A x64 %CMAKE_ARGS% %DKCMAKE%
    ::set TARGET=%APP%_APP
	
    call:validate_msys2
	call:validate_gcc
	"CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_C_COMPILER=%C_COMPILER%"
    "CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_CXX_COMPILER=%CXX_COMPILER%"
	::"%CMAKE%" -G "%MSYS2_GENERATOR%" %CMAKE_ARGS% %DKCMAKE%
	pause
    ::call set DKPATH=%%DKPATH:^\=^/%%
	::TITLE DigitalKnob - MINGW64
    ::%MSYS2%/usr/bin/env MSYSTEM=MINGW64 /usr/bin/bash -lc "clear && %CMAKE% -G %MSYS2_GENERATOR% %CMAKE_ARGS% %DKCMAKE%"
goto build

:generate_android32
    call:validate_visual_studio
    call:validate_android_ndk
    call:validate_openjdk
    call %OPENJDK%\registerJDK.cmd
    "%CMAKE%" -G "%VISUALSTUDIO_GENERATOR%" -A ARM -DANDROID_ABI=armeabi-v7a -DANDROID_PLATFORM=%ANDROID_API% -DANDROID_NDK=%ANDROID_NDK% -DCMAKE_TOOLCHAIN_FILE=%ANDROID_TOOLCHAIN_FILE% -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -S%DKCMAKE% -B%APP_PATH%/%OS%
    set TARGET=main
goto build

:generate_android64
    call:validate_visual_studio
    call:validate_android_ndk
    call:validate_openjdk
    call %OPENJDK%\registerJDK.cmd
    "%CMAKE%" -G "%VISUALSTUDIO_GENERATOR%" -A ARM64 -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=%ANDROID_API% -DANDROID_NDK=%ANDROID_NDK% -DCMAKE_TOOLCHAIN_FILE=%ANDROID_TOOLCHAIN_FILE% -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -S%DKCMAKE% -B%APP_PATH%/%OS%
    set TARGET=main
goto build

:generate_emscripten
    call:validate_emscripten
    if %TYPE%==Debug (
        call "%EMSDK_ENV%" & "%CMAKE%" -G "%EMSDK_GENERATOR%" -DCMAKE_TOOLCHAIN_FILE="%EMSDK_TOOLCHAIN_FILE%" -S%DKCMAKE% -B%APP_PATH%/%OS%/Debug
    )
    if %TYPE%==Release (
        call "%EMSDK_ENV%" & "%CMAKE%" -G "%EMSDK_GENERATOR%" -DCMAKE_TOOLCHAIN_FILE="%EMSDK_TOOLCHAIN_FILE%" -S%DKCMAKE% -B%APP_PATH%/%OS%/Release
    )
    if %TYPE%==All (
        call "%EMSDK_ENV%" & "%CMAKE%" -G "%EMSDK_GENERATOR%" -DCMAKE_TOOLCHAIN_FILE="%EMSDK_TOOLCHAIN_FILE%" -S%DKCMAKE% -B%APP_PATH%/%OS%/Debug
        call "%EMSDK_ENV%" & "%CMAKE%" -G "%EMSDK_GENERATOR%" -DCMAKE_TOOLCHAIN_FILE="%EMSDK_TOOLCHAIN_FILE%" -S%DKCMAKE% -B%APP_PATH%/%OS%/Release
    )
    set TARGET=%APP%_APP
goto build


:build
echo ""
echo ###########################################################        
echo ****** Building %APP% - %OS% - %TYPE% - %LEVEL% ******
echo ###########################################################
echo ""


echo TYPE = %TYPE%
if %TYPE%==Debug goto build_debug
if %TYPE%==Release goto build_release
if %TYPE%==All goto build_all
call:assert "TYPE not set"

:build_debug
    if exist %APP_PATH%\%OS%\Debug\CMakeCache.txt (
        "%CMAKE%" --build %APP_PATH%\%OS%\Debug --target %TARGET% --config Debug --verbose
    )
    if exist %APP_PATH%\%OS%\CMakeCache.txt (
        "%CMAKE%" --build %APP_PATH%\%OS% --target %TARGET% --config Debug --verbose
    )
goto end_message

:build_release
    if exist %APP_PATH%\%OS%\Release\CMakeCache.txt (
        "%CMAKE%" --build %APP_PATH%\%OS%\Release --target %TARGET% --config Release --verbose
    )
    if exist %APP_PATH%\%OS%\CMakeCache.txt (
        "%CMAKE%" --build %APP_PATH%\%OS% --target %TARGET% --config Release --verbose
    )
goto end_message

:build_all
    if exist %APP_PATH%\%OS%\Debug\CMakeCache.txt (
        "%CMAKE%" --build %APP_PATH%\%OS%\Debug --target %TARGET% --config Debug --verbose
    )
    if exist %APP_PATH%\%OS%\CMakeCache.txt (
        "%CMAKE%" --build %APP_PATH%\%OS% --target %TARGET% --config Debug --verbose
    )
    if exist %APP_PATH%\%OS%\Debug\CMakeCache.txt (
        "%CMAKE%" --build %APP_PATH%\%OS%\Release --target %TARGET% --config Release --verbose
    )
    if exist %APP_PATH%\%OS%\CMakeCache.txt (
        "%CMAKE%" --build %APP_PATH%\%OS% --target %TARGET% --config Release --verbose
    )
goto end_message

:end_message
echo:
echo ******* Done building %APP% - %OS% - %TYPE% *******
goto pickapp




::--------------------------------------------------------
:: FUNCTIONS
:: https://www.dostips.com/DtTutoFunctions.php
::--------------------------------------------------------

:: reload()
:reload
    echo .
    echo reloading %SCRIPTNAME%
    start "" "%SCRIPTPATH%\%SCRIPTNAME%"
    exit
goto:eof


:: end()
:end
    echo Done
    exit
goto:eof


:: assert()
:assert
    echo ASSERT: %~1
    pause
    exit
goto:eof


:: check_error()
:check_error
    if "%ERRORLEVEL%" == "0" goto:eof
    call:assert "ERRORLEVEL = %ERRORLEVEL%"
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
    for %%I in (.) do set "FOLDER=%%~nxI"
        
    set "DKBRANCH=Development"
    if exist .git (
        "%GIT%" branch | find "* %FOLDER%" > NUL & IF ERRORLEVEL 0 (
            set "DKBRANCH=%FOLDER%"
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


@echo on
:: validate_visual_studio()
:validate_visual_studio
    call:cmake_eval "include('%DKIMPORTS%/visualstudio/DKMAKE.cmake')" "VISUALSTUDIO_GENERATOR;VISUALSTUDIO_X86_CXX_COMPILER;VISUALSTUDIO_X64_CXX_COMPILER;"
    call:check_error
goto:eof

:: validate_msys2()
:validate_msys2
    call:cmake_eval "include('%DKIMPORTS%/msys2/DKMAKE.cmake')" "MSYS2"
    echo MSYS2 = %MSYS2%
    call:check_error
goto:eof

:: validate_gcc()
:validate_gcc
    call:cmake_eval "include('%DKIMPORTS%/gcc/DKMAKE.cmake')" "C_COMPILER;CXX_COMPILER"
    echo C_COMPILER = %C_COMPILER%
	echo CXX_COMPILER = %CXX_COMPILER%
    call:check_error
goto:eof

:: validate_openjdk()
:validate_openjdk
    call:cmake_eval "include('%DKIMPORTS%/openjdk/DKMAKE.cmake')" "OPENJDK"
    echo OPENJDK = %OPENJDK%
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
    call:cmake_eval "include('%DKIMPORTS%/emsdk/DKMAKE.cmake')" "EMSDK;EMSDK_ENV;EMSDK_GENERATOR;EMSDK_TOOLCHAIN_FILE"
    echo EMSDK = %EMSDK%
    echo EMSDK_ENV = %EMSDK_ENV%
    echo EMSDK_GENERATOR = %EMSDK_GENERATOR%
    echo EMSDK_TOOLCHAIN_FILE = %EMSDK_TOOLCHAIN_FILE%
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
    set "variable_name=%~1"
    shift
    if not "%~1"=="" goto command_args

    set command=%command:_QUOTE_="%

    for /F "tokens=*" %%g in ('%command%') do (
        set "%variable_name%=%%g"
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


:: git_update()
:git_update
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
    cd %DKPATH%
    "%GIT%" config user.email "%GIT_USER_EMAIL%"
    "%GIT%" config user.name "%GIT_USER_NAME%"
    "%GIT%" commit -a -m "git commit"
    "%GIT%" push
    call:check_error
goto:eof


:: clear_screen()
:clear_screen
    cls
goto:eof


:: cmake_eval <cmake_commands;.;.;> <variables;.;.;.>
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
        "%CMAKE%" "-DDKCMAKE=%DKCMAKE%" "-DDKCOMMAND=%DKCOMMAND%" "-DDKRETURN=%~2" -P %DKCMAKE%/dev/cmake_eval.cmake
        if not exist %DKCMAKE%/cmake_vars.cmd goto:eof
        call %EVAL_VARS%
                del %EVAL_VARS%

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

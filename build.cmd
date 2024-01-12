@echo off

::############ DigitalKnob builder script ############

if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit ) :: keep window open



::--------------------------------------------------------
:: GLOBAL USER VARIABLES
::--------------------------------------------------------
set "GIT_DL=https://github.com/git-for-windows/git/releases/download/v2.30.1.windows.1/Git-2.30.1-32-bit.exe"
set "GIT_USER_EMAIL=aquawicket@hotmail.com"
set "GIT_USER_NAME=aquawicket"
set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi"
set "MSBUILD_DL=https://aka.ms/vs/17/release/vs_community.exe"
set "ANDROID_API=31"
set "ANDROID_NDK_BUILD=23.1.7779620"
set "ANDROID_NDK_DL=https://dl.google.com/android/repository/android-ndk-r23b-windows.zip"
set "PYTHON_FOLDER=python-2.7.18"
set "PYTHON_DL=https://www.python.org/ftp/python/2.7.18/python-2.7.18.msi"
set "EMSDK_GIT=https://github.com/emscripten-core/emsdk.git"



::--------------------------------------------------------
:: Main
::--------------------------------------------------------
set "DIGITALKNOB=C:\Users\%USERNAME%\digitalknob"
call:make_directory "%DIGITALKNOB%"
set "DKDOWNLOAD=%DIGITALKNOB%\download"
call:make_directory "%DKDOWNLOAD%"

call:validate_git
call:validate_branch

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
echo 12) Exit
set choice=
set /p choice=Please select an app to build:
::if not '%choice%'=='' set choice=%choice:~0,1%	::What does this do?
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
if '%choice%'=='12' call:end
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
::  1) Windows (x86_64)

:: 	2) Android (arm32)
:: 	3) Android (arm64)
:: 	4) Android (x86)
:: 	5) Android (x86_64)
:: 	6) iOS (arm32)
:: 	7) iOS (arm64)
:: 	8) iOS (x86)
:: 	9) iOS (x86_64)
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
::if not '%choice%'=='' set choice=%choice:~0,1%	::What does this do?
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
::if not '%choice%'=='' set choice=%choice:~0,1%	::What does this do?
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


call:clear_cmake_cache
call:delete_temp_files
call::validate_cmake

set "APP_PATH=%DKPATH%\DKApps\%APP%"
echo APP_PATH = %APP_PATH%
call:make_directory "%APP_PATH%\%OS%"
cd "%APP_PATH%\%OS%"


if %OS%==win32 goto generate_win32
if %OS%==win64 goto generate_win64
if %OS%==android32 goto generate_android32
if %OS%==android64 goto generate_android64
if %OS%==emscripten goto generate_emscripten

:generate_win32
call:validate_visual_studio
"%CMAKE%" -G "Visual Studio 17 2022" -A Win32 -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON %DKCMAKE%
set TARGET=%APP%_APP
goto build

:generate_win64
call:validate_visual_studio
"%CMAKE%" -G "Visual Studio 17 2022" -A x64 -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON %DKCMAKE%
set TARGET=%APP%_APP
goto build

:generate_android32
call:validate_android_ndk
::call:validate_openjdk
::call %DKPATH%\3rdParty\_DKIMPORTS\openjdk\registerJDK.cmd
"%CMAKE%" -G "Visual Studio 17 2022" -A ARM -DANDROID_ABI=armeabi-v7a -DANDROID_PLATFORM=%ANDROID_API% -DANDROID-NDK=%ANDROID_NDK% -DCMAKE_TOOLCHAIN_FILE=%ANDROID_NDK%/build/cmake/android.toolchain.cmake -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -S%DKCMAKE% -B%APP_PATH%/%OS%
set TARGET=main
goto build

:generate_android64
call:validate_android_ndk
::call:validate_openjdk
::call %DKPATH%\3rdParty\_DKIMPORTS\openjdk\registerJDK.cmd
"%CMAKE%" -G "Visual Studio 17 2022" -A ARM64 -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=%ANDROID_API% -DANDROID-NDK=%ANDROID_NDK% -DCMAKE_TOOLCHAIN_FILE=%ANDROID_NDK%/build/cmake/android.toolchain.cmake -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -S%DKCMAKE% -B%APP_PATH%/%OS%
set TARGET=main
goto build

:generate_emscripten
call:validate_emscripten
set EMSDK=DIGITALKNOB+C:/Users/Administrator/digitalknob/Development/3rdParty/emsdk-main
set EMSDK_ENV=%EMSDK%/emsdk_env
set EMSDK_TOOLCHAIN_FILE=%EMSDK%/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake
call:assert "emscriten incomplete"

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
echo "Building %APP_PATH% for %OS%"
"%CMAKE%" --build %APP_PATH%\%OS% --target %TARGET% --config Debug --verbose
goto end_message

:build_release
"%CMAKE%" --build %APP_PATH%\%OS% --target %TARGET% --config Release --verbose
goto end_message

:build_all
"%CMAKE%" --build %APP_PATH%\%OS% --target %TARGET% --config Debug --verbose
"%CMAKE%" --build %APP_PATH%\%OS% --target %TARGET% --config Release --verbose
goto end_message

:end_message
echo:
echo ******* Done building %APP% - %OS% - %TYPE% *******
goto pickapp




::--------------------------------------------------------
:: FUNCTIONS
:: https://www.dostips.com/DtTutoFunctions.php
::--------------------------------------------------------

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
	::bitsadmin /transfer myDownloadJob /download /priority normal %~1 %~2
	call:check_error
goto:eof

:: make_directory()
:make_directory
	if NOT exist "%~1" mkdir "%~1"
goto:eof

:: extract()
:extract
	echo Extracting %~1 to %~2
	if NOT exist "%~2" (
		call:assert "extract(): destination path '%~2' does not exist"
	)
	chdir "%~2"
	"%CMAKE%" -E tar x "%~1"
	call:check_error
goto:eof

:: rename()
:rename
	echo Renaming %~1 to %~2
	if NOT exist "%~1" (
		call:assert "source path '%~1' does not exist"
	)
	"%CMAKE%" -E rename "%~1" "%~2"
	call:check_error
goto:eof

:: validate_branch()
:validate_branch
	:: https://stackoverflow.com/a/33662275
	:: If the current folder matches the current branch set DKBRANCH, default to Development
	for %%I in (.) do set "FOLDER=%%~nxI"
	"%GIT%" branch | find "* %FOLDER%" > NUL & IF ERRORLEVEL 1 (
		set "DKBRANCH=Development"
	) else (
		set "DKBRANCH=%FOLDER%"
	)
	set "DKPATH=%DIGITALKNOB%\%DKBRANCH%"
	set "DKCMAKE=%DIGITALKNOB%\%DKBRANCH%\DKCMake"
	echo DKBRANCH = %DKBRANCH%
	call:check_error
goto:eof

:: validate_git()
:validate_git
	if exist "C:\Program Files\Git\bin\git.exe" set "GIT=C:\Program Files\Git\bin\git.exe"
	if exist "C:\Program Files (x86)\Git\bin\git.exe" set "GIT=C:\Program Files (x86)\Git\bin\git.exe"
	if NOT exist "%GIT%" (
		echo "installing git"
		call:download %GIT_DL% "%DKDOWNLOAD%\Git-2.30.1-32-bit.exe"
		"%DKDOWNLOAD%\Git-2.30.1-32-bit.exe" /VERYSILENT /NORESTART
		if exist "C:\Program Files\Git\bin\git.exe" set "GIT=C:\Program Files\Git\bin\git.exe"
		if exist "C:\Program Files (x86)\Git\bin\git.exe" set "GIT=C:\Program Files (x86)\Git\bin\git.exe"
	)
	if NOT exist "%GIT%" (
		call:assert "GIT is still and invalid command"
	)
	echo GIT = %GIT%
	call:check_error
goto:eof

:: validate_cmake()
:validate_cmake
	if exist "C:\Program Files\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files\CMake\bin\cmake.exe"
	if exist "C:\Program Files (x86)\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files (x86)\CMake\bin\cmake.exe"
	if NOT exist "%CMAKE%" (
		echo "installing cmake"
		call:download %CMAKE_DL% "%DKDOWNLOAD%\cmake-3.21.1-windows-i386.msi"
		"%DKDOWNLOAD%\cmake-3.21.1-windows-i386.msi"
		if exist "C:\Program Files\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files\CMake\bin\cmake.exe"
		if exist "C:\Program Files (x86)\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files (x86)\CMake\bin\cmake.exe"
	)
	call:check_error
goto:eof

:: validate_visual_studio()
:validate_visual_studio
	if exist "C:\Program Files\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
	if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
	if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
	if exist "C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
	if NOT exist "%MSBUILD%" (
		echo "installing Visual Studio"
		call:download %MSBUILD_DL% "%DKDOWNLOAD%\vs_Community.exe"
		"%DKDOWNLOAD%\vs_Community.exe"
	)
	if exist "C:\Program Files\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
	if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
	if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
	if exist "C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
	call:check_error
goto:eof

:: validate_openjdk()
:validate_openjdk
	:: TODO
	call:assert "validate_openjdk() not implemented"
goto:eof

:: validate_android_ndk()
:validate_android_ndk
	set "ANDROID_NDK=%DIGITALKNOB%\%DKBRANCH%\3rdParty\android-sdk\ndk\%ANDROID_NDK_BUILD%"
	echo ANDROID_NDK = %ANDROID_NDK%
	if NOT exist "%ANDROID_NDK%" (
		echo "installing android-ndk"
		call:download %ANDROID_NDK_DL% "%DKDOWNLOAD%\android-ndk-r23b-windows.zip"
		call:make_directory "%DIGITALKNOB%\%DKBRANCH%\3rdParty\android-sdk"
		call:make_directory "%DIGITALKNOB%\%DKBRANCH%\3rdParty\android-sdk\ndk"
		call:extract "%DKDOWNLOAD%\android-ndk-r23b-windows.zip" "%DIGITALKNOB%\%DKBRANCH%\3rdParty\android-sdk\ndk"
		call:rename "%DIGITALKNOB%\%DKBRANCH%\3rdParty\android-sdk\ndk\android-ndk-r23b" "C:\Users\Administrator\digitalknob\Development\3rdParty\android-sdk\ndk\23.1.7779620"
	)
	if not '%VS_NdkRoot%'=='%ANDROID_NDK%' setx VS_NdkRoot %ANDROID_NDK%
	:: replace all \ characters with / in ANDROID_NDK for cmake compatability
	set ANDROID_NDK=%ANDROID_NDK:\=/%
	call:check_error
goto:eof

:: validate_emscripten()
:validate_emscripten
	call:validate_python
	
	set "EMSDK=%DIGITALKNOB%\%DKBRANCH%\3rdParty\emsdk-main"
	if NOT exist "%EMSDK%\.git" (
		echo "installing emsdk"
		"%GIT%" clone "%EMSDK_GIT%" "%DIGITALKNOB%\%DKBRANCH%\3rdParty\emsdk-main"
	)
	::"%GIT%" checkout -- .
	cd "%DIGITALKNOB%\%DKBRANCH%\3rdParty\emsdk-main"
	"%GIT%" checkout main
	"%GIT%" pull
		
	call "%DIGITALKNOB%\%DKBRANCH%\3rdParty\emsdk-main\emsdk.bat" install latest
	call "%DIGITALKNOB%\%DKBRANCH%\3rdParty\emsdk-main\emsdk.bat" activate latest
	
	call "%DIGITALKNOB%\%DKBRANCH%\3rdParty\emsdk-main\emsdk.bat" install mingw-4.6.2-32bit
	call "%DIGITALKNOB%\%DKBRANCH%\3rdParty\emsdk-main\emsdk.bat" activate mingw-4.6.2-32bit
	
	::CPP_DK_Execute("chmod 777 "+DIGITALKNOB+"DK/3rdParty/emsdk-main/emsdk_env.sh")  :: MSYS
goto:eof

:: validate_python()
:validate_python
	set "PYTHON_PATH=%DIGITALKNOB%\%DKBRANCH%\3rdParty\%PYTHON_FOLDER%"
	set "PYTHON_EXE=%PYTHON_PATH%\python.exe"
	::call:make_directory "%PYTHON_PATH%"
	set PATH=%PATH%;%PYTHON_PATH%
	
	if NOT exist %PYTHON_EXE% (
		echo "installing python"
		call:download %PYTHON_DL% "%DKDOWNLOAD%\python-2.7.18.msi"
		"%DKDOWNLOAD%\python-2.7.18.msi" /passive PrependPath=1 TargetDir=%PYTHON_PATH%
	)
	if NOT exist %PYTHON_PATH%\Scripts\pip.exe (
		"%PYTHON_EXE%" -m ensurepip
	)
		

goto:eof

:: clear_cmake_cache()
:clear_cmake_cache
	echo Deleteing CMake cache . . .
	cd "%DIGITALKNOB%"
	for /r %%i in (CMakeCache.*) do del "%%i"
	for /d /r %%i in (*CMakeFiles*) do rd /s /q "%%i"
	call:check_error
goto:eof

:: delete_temp_files()
:delete_temp_files
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
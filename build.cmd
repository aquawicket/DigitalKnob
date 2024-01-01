:: Windows Batch file DK builder
@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit ) :: keep window open

call:check_error
::--------------------------------------------------------
:: GLOBAL USER VARIABLES
::--------------------------------------------------------
:: GIT download link
set "GIT_DL=https://github.com/git-for-windows/git/releases/download/v2.30.1.windows.1/Git-2.30.1-32-bit.exe"

:: CMAKE download link
set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi"

:: MSBuild download link
::set "MSBUILD_DL=https://download.visualstudio.microsoft.com/download/pr/5e397ebe-38b2-4e18-a187-ac313d07332a/169156e6e9a005d49b357c42240184dc1e3ccc28ebc777e70d49257c074f77e8/vs_Community.exe"
set "MSBUILD_DL=https://aka.ms/vs/17/release/vs_community.exe"

:: Android Ndk download link
set "ANDROID_API=31"
set "ANDROID_NDK_BUILD=23.1.7779620"
set "ANDROID_NDK_DL=https://dl.google.com/android/repository/android-ndk-r23b-windows.zip"



::--------------------------------------------------------
:: Main
::--------------------------------------------------------
set "DIGITALKNOB=C:\Users\%USERNAME%\digitalknob"
if NOT exist "%DIGITALKNOB%" mkdir "%DIGITALKNOB%"
set "DKDOWNLOAD=%DIGITALKNOB%\download"
if NOT exist "%DKDOWNLOAD%" mkdir "%DKDOWNLOAD%"

call:validate_git
call:validate_branch

set "APP="
set "OS="
set "TYPE="

:pickapp
ECHO.
ECHO 1. Git Update
ECHO 2. Git Commit
ECHO 3. DKCore
ECHO 4. DKJavascript
ECHO 5. DKBuilder
ECHO 6. DKSDL
ECHO 7. DKSDLRml
ECHO 8. DKDomTest
ECHO 9. DKTestAll
ECHO c. Clear Screen
ECHO x. Exit
set choice=
set /p choice=Please select an app to build: 
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto gitupdate
if '%choice%'=='2' goto gitcommit
if '%choice%'=='3' goto dkcore
if '%choice%'=='4' goto dkjavascript
if '%choice%'=='5' goto dkbuilder
if '%choice%'=='6' goto dksdl
if '%choice%'=='7' goto dksdlrml
if '%choice%'=='8' goto dkdomtest
if '%choice%'=='9' goto dktestall
if '%choice%'=='c' goto clearscreen
if '%choice%'=='x' goto end
ECHO "%choice%" is not valid, try again
goto pickapp

:gitupdate
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


::call:check_error
goto pickapp

:gitcommit
cd %DKPATH%
"%GIT%" config user.email "aquawicket@hotmail.com"
"%GIT%" config user.name "aquawicket"
"%GIT%" commit -a -m "git commit"
::call:check_error
"%GIT%" push
::call:check_error
goto pickapp

:clearscreen
cls
goto pickapp

:dkcore
set APP=DKCore
goto checkApp

:dkjavascript
set APP=DKJavascript
goto checkApp

:dkbuilder
set APP=DKBuilder
goto checkApp

:dksdl
set APP=DKSDL
goto checkApp

:dksdlrml
set APP=DKSDLRml
goto checkApp

:dkdomtest
set APP=DKDomTest
goto checkApp

:dktestall
set APP=DKTestAll
goto checkApp

:checkApp
if NOT exist "%DKPATH%\DKApps\%APP%\DKMAKE.cmake" (
	ECHO ERROR: %APP%/DKMAKE.cmake file not found
	goto pickapp
) 
goto pickos


:pickos
ECHO %APP%
ECHO.
ECHO 1. Windows 32
ECHO 2. Windows 64
ECHO 3. Android 32
ECHO 4. Android 64
ECHO 5. Emscripten
ECHO b. Go Back
ECHO x. Exit
set choice=
set /p choice=Please select an OS to build for: 
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto win32
if '%choice%'=='2' goto win64
if '%choice%'=='3' goto android32
if '%choice%'=='4' goto android64
if '%choice%'=='5' goto emscripten
if '%choice%'=='b' goto pickapp
if '%choice%'=='x' goto end
ECHO "%choice%" is not valid, try again
goto pickos

:win32
set OS=win32
goto type

:win64
set OS=win64
goto type

:android32
set OS=android32
goto type

:android64
set OS=android64
goto type

:emscripten
set OS=emscripten
goto type


:type
ECHO %APP% - %OS%
ECHO.
ECHO 1. Debug
ECHO 2. Release
ECHO 3. All
ECHO b. Go Back
ECHO x. Exit
set choice=
set /p choice=Please select a build type: 
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto debug
if '%choice%'=='2' goto release
if '%choice%'=='3' goto all
if '%choice%'=='b' goto pickos
if '%choice%'=='x' goto end
ECHO "%choice%" is not valid, try again
goto type

:debug
set TYPE=Debug
goto generate

:release
set TYPE=Release
goto generate

:all
set TYPE=All
goto generate



:generate
call:clear_cmake_cache
call:delete_temp_files
call::validate_cmake

echo ****** BUILDING %APP% - %OS% - %TYPE% ******

set "APP_PATH=%DKPATH%\DKApps\%APP%"
ECHO %APP_PATH%
if NOT exist "%APP_PATH%\%OS%" mkdir "%APP_PATH%\%OS%"
::call:check_error
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
::call:check_error
goto build

:generate_win64
call:validate_visual_studio
"%CMAKE%" -G "Visual Studio 17 2022" -A x64 -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON %DKCMAKE%
set TARGET=%APP%_APP
::call:check_error
goto build

:generate_android32
call:validate_android_ndk
call %DKPATH%\3rdParty\_DKIMPORTS\openjdk\registerJDK.cmd
"%CMAKE%" -G "Visual Studio 17 2022" -A ARM -DANDROID_ABI=armeabi-v7a -DANDROID_PLATFORM=%ANDROID_API% -DANDROID-NDK=%ANDROID_NDK% -DCMAKE_TOOLCHAIN_FILE=%ANDROID_NDK%/build/cmake/android.toolchain.cmake -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -S%DKCMAKE% -B%APP_PATH%/%OS%
set TARGET=main
::call:check_error
goto build

:generate_android64
call:validate_android_ndk
call %DKPATH%\3rdParty\_DKIMPORTS\openjdk\registerJDK.cmd
"%CMAKE%" -G "Visual Studio 17 2022" -A ARM64 -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=%ANDROID_API% -DANDROID-NDK=%ANDROID_NDK% -DCMAKE_TOOLCHAIN_FILE=%ANDROID_NDK%/build/cmake/android.toolchain.cmake -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -S%DKCMAKE% -B%APP_PATH%/%OS%
set TARGET=main
::call:check_error
goto build

:generate_emscripten
call:validate_emscripten
set EMSDK=DIGITALKNOB+C:/Users/Administrator/digitalknob/Development/3rdParty/emsdk-main
set EMSDK_ENV=%EMSDK%/emsdk_env
set EMSDK_TOOLCHAIN_FILE=%EMSDK%/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake
echo emscriten incomplete
goto error
::goto build

:build
echo TYPE = %TYPE%
if %TYPE%==Debug goto build_debug
if %TYPE%==Release goto build_release
if %TYPE%==All goto build_all
goto error

:build_debug
"%CMAKE%" --build %APP_PATH%\%OS% --target %TARGET% --config Debug
::call:check_error
goto end_message

:build_release
"%CMAKE%" --build %APP_PATH%\%OS% --target %TARGET% --config Release
::call:check_error
goto end_message

:build_all
"%CMAKE%" --build %APP_PATH%\%OS% --target %TARGET% --config Debug
"%CMAKE%" --build %APP_PATH%\%OS% --target %TARGET% --config Release
::call:check_error
goto end_message

:end_message
echo:
echo ******* Done building %APP% - %OS% - %TYPE% *******
goto pickapp

:error
echo Failed with error code: %ERRORLEVEL%
pause

:end
ECHO Done
exit




::--------------------------------------------------------
:: FUNCTIONS
:: https://www.dostips.com/DtTutoFunctions.php
::--------------------------------------------------------

:: check_error()
:check_error
	if "%ERRORLEVEL%" == "0" goto:eof
	echo ERROR: %ERRORLEVEL%
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
	::bitsadmin /transfer myDownloadJob /download /priority normal %~1 %~2
	call:check_error
goto:eof

:: extract()
:extract
	echo Extracting %~1 to %~2
	%CMAKE% -E tar %~1 %~2
	call:check_error
goto:eof

:: validate_branch()
:validate_branch
	:: https://stackoverflow.com/a/33662275
	:: If the current folder matches the current branch set DKBRANCH, default to Development
	for %%I in (.) do set "FOLDER=%%~nxI"
	"%GIT%" branch | find "* %FOLDER%" > NUL & IF ERRORLEVEL 1 (
		set "DKBRANCH=Development"
	) ELSE (
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
		ECHO "installing git"
		call:download %GIT_DL% "%DKDOWNLOAD%\Git-2.30.1-32-bit.exe"
		::call:check_error
		"%DKDOWNLOAD%\Git-2.30.1-32-bit.exe" /VERYSILENT /NORESTART
		::call:check_error
		if exist "C:\Program Files\Git\bin\git.exe" set "GIT=C:\Program Files\Git\bin\git.exe"
		if exist "C:\Program Files (x86)\Git\bin\git.exe" set "GIT=C:\Program Files (x86)\Git\bin\git.exe"
	)
	if NOT exist "%GIT%" (
		ECHO "GIT is still and invalid command"
		goto error
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
		echo "%CMAKE_DL%"
		call:download %CMAKE_DL% "%DKDOWNLOAD%\cmake-3.21.1-windows-i386.msi"
		call:check_error
		"%DKDOWNLOAD%\cmake-3.21.1-windows-i386.msi"
		call:check_error
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
		echo "%MSBUILD_DL%"
		
		call:download %MSBUILD_DL% "%DKDOWNLOAD%\vs_Community.exe"
		::call:check_error
		"%DKDOWNLOAD%\vs_Community.exe"
		::call:check_error
		if exist "C:\Program Files\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
		if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
		if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
		if exist "C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
	)
	call:check_error
goto:eof

:: validate_android_ndk()
:validate_android_ndk
	if exist %DIGITALKNOB%\%DKBRANCH%\3rdParty\android-sdk\ndk\%ANDROID_NDK_BUILD%" set "ANDROID_NDK=%DIGITALKNOB%\%DKBRANCH%\3rdParty\android-sdk\ndk\%ANDROID_NDK_BUILD%"
	if NOT exist "%ANDROID_NDK%" (
		echo "installing android ndk"
		call:download %ANDROID_NDK_DL% "%DKDOWNLOAD%\android-ndk-r23b-windows.zip"
		call:extract "%DKDOWNLOAD%\android-ndk-r23b-windows.zip" "%ANDROID_NDK%"
	)
	if not '%VS_NdkRoot%'=='%ANDROID_NDK%' setx VS_NdkRoot %ANDROID_NDK%
	call:check_error
goto:eof

:: clear_cmake_cache()
:clear_cmake_cache
	echo Deleteing CMake cache . . .
	cd "%DIGITALKNOB%"
	for /r %%i in (CMakeCache.*) do del "%%i"
	::call:check_error
	for /d /r %%i in (*CMakeFiles*) do rd /s /q "%%i"
	::call:check_error
	call:check_error
goto:eof

:: delete_temp_files()
:delete_temp_files
	echo Deleteing .tmp files . . .
	cd "%DIGITALKNOB%"
	for /r %%i in (*.tmp) do del "%%i"
	::call:check_error
	for /r %%i in (*.TMP) do del "%%i"
	::call:check_error
	call:check_error
goto:eof
:: Windows Batch file DK builder
@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

::set "BRANCH=Development"
set "BRANCH=CPP_DOM"
set "DIGITALKNOB=C:\Users\%USERNAME%\digitalknob"
set "DKPATH=%DIGITALKNOB%\%BRANCH%"
set "DKCMAKE=%DIGITALKNOB%\%BRANCH%\DKCMake"
set "DKDOWNLOAD=%DIGITALKNOB%\download"
set "GIT_DL=https://github.com/git-for-windows/git/releases/download/v2.30.1.windows.1/Git-2.30.1-32-bit.exe"
set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi"
::set "MSBUILD_DL=https://download.visualstudio.microsoft.com/download/pr/5e397ebe-38b2-4e18-a187-ac313d07332a/169156e6e9a005d49b357c42240184dc1e3ccc28ebc777e70d49257c074f77e8/vs_Community.exe"
set "MSBUILD_DL=https://aka.ms/vs/17/release/vs_community.exe"
set "download=certutil.exe -urlcache -split -f"
::set "download=bitsadmin /transfer myDownloadJob /download /priority normal"
set "APP="
set "OS="
set "TYPE="
if NOT exist "%DIGITALKNOB%" mkdir "%DIGITALKNOB%"
if NOT exist "%DKDOWNLOAD%" mkdir "%DKDOWNLOAD%"

:pickapp
ECHO.
ECHO 1. Git Update
ECHO 2. Git Commit
ECHO 3. DKCore
ECHO 4. DKJavascript
ECHO 5. DKBuilder
ECHO 6. DKBuilderGui
ECHO 7. DKSDL
ECHO 8. DKSDLRml
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
if '%choice%'=='6' goto dkbuildergui
if '%choice%'=='7' goto dksdl
if '%choice%'=='8' goto dksdlrml
if '%choice%'=='c' goto clearscreen
if '%choice%'=='x' goto end
ECHO "%choice%" is not valid, try again
goto pickapp

:gitupdate
if exist "C:\Program Files\Git\bin\git.exe" set "GIT=C:\Program Files\Git\bin\git.exe"
if exist "C:\Program Files (x86)\Git\bin\git.exe" set "GIT=C:\Program Files (x86)\Git\bin\git.exe"
if NOT exist "%GIT%" (
	ECHO "installing git"
	%download% %GIT_DL% "%DKDOWNLOAD%\Git-2.30.1-32-bit.exe"
	::if NOT "%ERRORLEVEL%" == "0" goto error
	"%DKDOWNLOAD%\Git-2.30.1-32-bit.exe" /VERYSILENT /NORESTART
	::if NOT "%ERRORLEVEL%" == "0" goto error
	if exist "C:\Program Files\Git\bin\git.exe" set "GIT=C:\Program Files\Git\bin\git.exe"
	if exist "C:\Program Files (x86)\Git\bin\git.exe" set "GIT=C:\Program Files (x86)\Git\bin\git.exe"
)
if NOT exist "%DKPATH%\.git" (
	"%GIT%" clone https://github.com/aquawicket/DigitalKnob.git "%DKPATH%"
)
if NOT "%ERRORLEVEL%" == "0" goto error

cd "%DKPATH%"
"%GIT%" pull --all
"%GIT%" checkout -- .
if NOT "%ERRORLEVEL%" == "0" goto error
"%GIT%" checkout %BRANCH%
if NOT "%ERRORLEVEL%" == "0" (
	echo Remote has no %BRANCH% branch. Creating...
	"%GIT%" checkout -b %BRANCH% main
	"%GIT%" push --set-upstream origin %BRANCH%
)


::if NOT "%ERRORLEVEL%" == "0" goto error
goto pickapp

:gitcommit
if exist "C:\Program Files\Git\bin\git.exe" set "GIT=C:\Program Files\Git\bin\git.exe"
if exist "C:\Program Files (x86)\Git\bin\git.exe" set "GIT=C:\Program Files (x86)\Git\bin\git.exe"
if NOT exist "%GIT%" (
	ECHO "installing git"
	%download% %GIT_DL% "%DKDOWNLOAD%\Git-2.30.1-32-bit.exe"
	::if NOT "%ERRORLEVEL%" == "0" goto error
	"%DKDOWNLOAD%\Git-2.30.1-32-bit.exe /VERYSILENT /NORESTART"
	::if NOT "%ERRORLEVEL%" == "0" goto error
	if exist "C:\Program Files\Git\bin\git.exe" set "GIT=C:\Program Files\Git\bin\git.exe"
	if exist "C:\Program Files (x86)\Git\bin\git.exe" set "GIT=C:\Program Files (x86)\Git\bin\git.exe"
)
cd %DKPATH%
"%GIT%" config user.email "aquawicket@hotmail.com"
"%GIT%" config user.name "aquawicket"
"%GIT%" commit -a -m "git commit"
::if NOT "%ERRORLEVEL%" == "0" goto error
"%GIT%" push
::if NOT "%ERRORLEVEL%" == "0" goto error
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

:dkbuildergui
set APP=DKBuilderGui
goto checkApp

:dksdl
set APP=DKSDL
goto checkApp

:dksdlrml
set APP=DKSDLRml
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
ECHO b. Go Back
ECHO x. Exit
set choice=
set /p choice=Please select an OS to build for: 
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto win32
if '%choice%'=='2' goto win64
if '%choice%'=='3' goto android32
if '%choice%'=='4' goto android64
if '%choice%'=='b' goto pickapp
if '%choice%'=='x' goto end
ECHO "%choice%" is not valid, try again
goto pickos

:win32
set OS="win32"
goto type

:win64
set OS="win64"
goto type

:android32
set OS="android32"
goto type

:android64
set OS="android64"
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
goto build

:release
set TYPE=Release
goto build

:all
set TYPE=All
goto build



:build
echo Deleteing CMake cache . . .
cd "%DIGITALKNOB%"
for /r %%i in (CMakeCache.*) do del "%%i"
::if NOT "%ERRORLEVEL%" == "0" goto error
for /d /r %%i in (*CMakeFiles*) do rd /s /q "%%i"
::if NOT "%ERRORLEVEL%" == "0" goto error

echo Deleteing .tmp files . . .
cd "%DIGITALKNOB%"
for /r %%i in (*.tmp) do del "%%i"
::if NOT "%ERRORLEVEL%" == "0" goto error
for /r %%i in (*.TMP) do del "%%i"
::if NOT "%ERRORLEVEL%" == "0" goto error


echo ****** BUILDING %APP% - %OS% - %TYPE% ******
if exist "C:\Program Files\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files\CMake\bin\cmake.exe"
if exist "C:\Program Files (x86)\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files (x86)\CMake\bin\cmake.exe"
if NOT exist "%CMAKE%" (
    echo "installing cmake"
	echo "%CMAKE_DL%"
	%download% %CMAKE_DL% "%DKDOWNLOAD%\cmake-3.21.1-windows-i386.msi"
	if NOT "%ERRORLEVEL%" == "0" goto error
	"%DKDOWNLOAD%\cmake-3.21.1-windows-i386.msi"
	if NOT "%ERRORLEVEL%" == "0" goto error
	if exist "C:\Program Files\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files\CMake\bin\cmake.exe"
	if exist "C:\Program Files (x86)\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files (x86)\CMake\bin\cmake.exe"
)
if exist "C:\Program Files\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
if exist "C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
if NOT exist "%MSBUILD%" (
    echo "installing Visual Studio"
	echo "%MSBUILD_DL%"
	
	%download% %MSBUILD_DL% "%DKDOWNLOAD%\vs_Community.exe"
	::if NOT "%ERRORLEVEL%" == "0" goto error
	"%DKDOWNLOAD%\vs_Community.exe"
	::if NOT "%ERRORLEVEL%" == "0" goto error
	if exist "C:\Program Files\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
	if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
	if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
	if exist "C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
)
set "APP_PATH=%DKPATH%\DKApps\%APP%"
ECHO %APP_PATH%
if NOT exist "%APP_PATH%\%OS%" mkdir "%APP_PATH%\%OS%"
::if NOT "%ERRORLEVEL%" == "0" goto error
cd "%APP_PATH%\%OS%"
::"%CMAKE%" -G "Visual Studio 16 2019" -A Win32 -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON %DKCMAKE%
"%CMAKE%" -G "Visual Studio 17 2022" -A Win32 -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON %DKCMAKE%
::if NOT "%ERRORLEVEL%" == "0" goto error

echo TYPE = %TYPE%
if %TYPE%==Debug goto build_debug
if %TYPE%==Release goto build_release
if %TYPE%==All goto build_all
goto error

:build_debug
"%MSBUILD%" %APP%_APP.sln /p:Configuration=Debug
::if NOT "%ERRORLEVEL%" == "0" goto error
goto pickapp

:build_release
"%MSBUILD%" %APP%_APP.sln /p:Configuration=Release
::if NOT "%ERRORLEVEL%" == "0" goto error
goto pickapp

:build_all
"%MSBUILD%" %APP%_APP.sln /p:Configuration=Debug
"%MSBUILD%" %APP%_APP.sln /p:Configuration=Release
::if NOT "%ERRORLEVEL%" == "0" goto error
goto pickapp


:error
echo Failed with error code: %ERRORLEVEL%
pause

:end
ECHO Done
exit
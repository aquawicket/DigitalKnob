:: Windows Batch file DK builder
@ECHO off

set "DIGITALKNOB=C:\Users\%USERNAME%\digitalknob"
set "DKPATH=%DIGITALKNOB%\DK"
set "GIT_DL=https://github.com/git-for-windows/git/releases/download/v2.30.1.windows.1/Git-2.30.1-32-bit.exe"
set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi"
set "MSBUILD_DL=https://download.visualstudio.microsoft.com/download/pr/5e397ebe-38b2-4e18-a187-ac313d07332a/169156e6e9a005d49b357c42240184dc1e3ccc28ebc777e70d49257c074f77e8/vs_Community.exe"
::set "download=certutil.exe -urlcache -split -f"
set "download=bitsadmin /transfer myDownloadJob /download /priority normal"
set "APP="
set "OS="
set "TYPE="

:pickapp
ECHO.
ECHO 1. Git Update
ECHO 2. DKBuilder
ECHO 3. DKSDLRmlUi
ECHO 4. DKTestAll
ECHO 5. Exit
set choice=
set /p choice=Please select an app to build: 
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto gitupdate
if '%choice%'=='2' goto dkbuilder
if '%choice%'=='3' goto dksdlrmlui
if '%choice%'=='4' goto dktestall
if '%choice%'=='5' goto end
ECHO "%choice%" is not valid, try again
goto pickapp

:gitupdate
set "GIT=C:\PROGRA~1\Git\bin\git.exe"
if exist %GIT%. (
	echo "found git"
) else (
    echo "installing git"
	echo "%GIT_DL%"
	%download% %GIT_DL% %DIGITALKNOB%\Git-2.30.1-32-bit.exe
	Git-2.30.1-32-bit.exe
)
git clone https://github.com/aquawicket/DigitalKnob.git %DKPATH%
cd %DKPATH%
git checkout -- .
git pull origin master
goto pickapp
:dkbuilder
set APP=DKBuilder
goto pickos
:dksdlrmlui
set APP=DKSDLRmlUi
goto pickos
:dktestall
set APP=DKTestAll
goto pickos



:pickos
ECHO %APP%
ECHO.
ECHO 1. Windows 32
ECHO 2. Windows 64
ECHO 3. Go Back
ECHO 4. Exit
set choice=
set /p choice=Please select an OS to build for: 
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto win32
if '%choice%'=='2' goto win64
if '%choice%'=='3' goto pickapp
if '%choice%'=='4' goto end
ECHO "%choice%" is not valid, try again
goto pickos
:win32
set OS="win32"
goto build
:win64
set OS="win64"
goto build


:type
ECHO %APP% - %OS%
ECHO.
ECHO 1. Debug
ECHO 2. Release
ECHO 3. All
ECHO 4. Go Back
ECHO 5. Exit
set choice=
set /p choice=Please select a build type: 
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto debug
if '%choice%'=='2' goto release
if '%choice%'=='3' goto all
if '%choice%'=='4' goto pickos
if '%choice%'=='5' goto end
ECHO "%choice%" is not valid, try again
goto type
:debug
set TYPE="Debug"
goto build
:release
set TYPE="Release"
goto build
:all
set TYPE="All"
goto build


:build
echo Deleteing CMake cache . . .
cd %DIGITALKNOB%
for /r %%i in (CMakeCache.*) do del "%%i"
for /d /r %%i in (*CMakeFiles*) do rd /s /q "%%i"


echo ****** BUILDING %APP% - %OS% ******
set "CMAKE=C:\PROGRA~2\CMake\bin\cmake.exe"
if exist %CMAKE%. (
	echo "found cmake"
) else (
    echo "installing cmake"
	echo "%CMAKE_DL%"
	%download% %CMAKE_DL% %DIGITALKNOB%\cmake-3.21.1-windows-i386.msi
	cmake-3.21.1-windows-i386.msi
)
set "MSBUILD=C:\PROGRA~2\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
if exist %MSBUILD%. (
	echo "found msbuild"
) else (
    echo "installing Visual Studio"
	echo "%MSBUILD_DL%"
	%download% %MSBUILD_DL% %DIGITALKNOB%\vs_Community.exe
	vs_Community.exe"
)
set APP_PATH=%DKPATH%\DKApps\%APP%
ECHO %APP_PATH%
mkdir %APP_PATH%\%OS%
cd %APP_PATH%\%OS%"
%CMAKE% -G "Visual Studio 16 2019" -A Win32 -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON %DKPATH%
%MSBUILD% %APP%.sln /p:Configuration=Debug
%MSBUILD% %APP%.sln /p:Configuration=Release

:end
ECHO Exit
pause

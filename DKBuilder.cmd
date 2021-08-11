@ECHO off

set "DIGITALKNOB=C:\Users\%USERNAME%\digitalknob"
set "DKPATH=%DIGITALKNOB%\DK"
set "CMAKE=C:\PROGRA~2\CMake\bin\cmake.exe"
set MSBUILD="C:\PROGRA~2\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
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
echo Resetting CMake Cache . . .
echo Deleting CMakeCache.txt files . . .
cd %DIGITALKNOB%
::del /f /s *MakeCache.txt
for /r %%i in (CMakeCache.*) do del "%%i"
echo Deleteing CMakeFiles folders . . .
for /d /r %%X in (*CMakeFiles*) do rd /s /q "%%X"
::for /d /r %%i in (*CMakeFiles*) do rmdir /s /q "%%i"
echo ****** BUILDING %APP% - %OS% ******
set APP_PATH=%DKPATH%\DKApps\%APP%
ECHO %APP_PATH%
mkdir %APP_PATH%\%OS%
cd %APP_PATH%\%OS%"
del %APP_PATH%\%OS%\CMakeCache.txt"
%CMAKE% -G "Visual Studio 16 2019" -A Win32 -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON %DKPATH%
:: %APP_PATH%\%OS%
%MSBUILD% %APP%.sln /p:Configuration=Debug
%MSBUILD% %APP%.sln /p:Configuration=Release

:end
ECHO Exit
pause

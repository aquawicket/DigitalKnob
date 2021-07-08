@ECHO off

set "APP="
set "OS="

:start
ECHO.
ECHO 1. *UPDATE*
ECHO 2. DKBuilder
ECHO 3. DKSDLRmlUi
ECHO 4. DKTestAll
ECHO 5. EXIT
set choice=
set /p choice=Please select an app to build: 
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto updater
if '%choice%'=='2' goto dkbuilder
if '%choice%'=='3' goto dksdlrmlui
if '%choice%'=='4' goto dktestall
if '%choice%'=='5' goto end
ECHO "%choice%" is not valid, try again
goto start

:updater
git clone https://github.com/aquawicket/DigitalKnob.git C:\Users\%USERNAME%\digitalknob\DK
cd C:\Users\%USERNAME%\digitalknob\DK
git checkout -- .
git pull origin master
goto start
:dkbuilder
set APP=DKBuilder
goto pickos
:dksdlrmlui
set APP=DKSDLRmlUi
goto pickos
:dktestall
set APP=DKTestAll
goto pickos
ECHO "ERROR: HOW DID YOU GET HERE?"



:pickos
ECHO APP = %APP%
ECHO.
ECHO 1. win32
ECHO 2. win64
ECHO 3. GoBack
ECHO 4. EXIT
set choice=
set /p choice=Please select an OS to build for: 
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto win32
if '%choice%'=='2' goto win64
if '%choice%'=='3' goto goback
if '%choice%'=='4' goto exit
ECHO "%choice%" is not valid, try again
goto pickos
:win32
set OS="win32"
goto build
:win64
set OS="win64"
goto build
:goback
goto start


:build
cd C:\Users\%USERNAME%\digitalknob
echo Deleteing all CMakeCache.txt files....
del /S *CMakeCache.txt
echo Deleteing all CMakeFiles folders....
FOR /D /R %%X IN (CMakeFile*) DO RD /S /Q "%%X"
echo ****** BUILDING %APP% - %OS% ******
set APP_PATH=C:\Users\%USERNAME%\digitalknob\DK\DKApps\%APP%
ECHO %APP_PATH%
mkdir %APP_PATH%\%OS%
cd %APP_PATH%\%OS%"
del %APP_PATH%\%OS%\CMakeCache.txt"
C:\PROGRA~2\CMake\bin\cmake.exe -G "Visual Studio 16 2019" -A Win32 -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON C:\Users\%USERNAME%\digitalknob\DK
:: %APP_PATH%\%OS%
"C:\PROGRA~2\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" %APP%.sln /p:Configuration=Release

:end
ECHO Exit
pause

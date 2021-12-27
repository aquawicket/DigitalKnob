:: Let's ask the use to type in what they want to build
:: could be an app, library or anything with a DKMAKE.cmake file
:: We whould also give the option to list targets as well

@echo off
set "DIGITALKNOB=C:\Users\%USERNAME%\digitalknob"
set "DKPATH=%DIGITALKNOB%\DK"
set "DKCMAKE=%DIGITALKNOB%\DK\DKCMake"
if exist "C:\Program Files\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files\CMake\bin\cmake.exe"
if exist "C:\Program Files (x86)\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files (x86)\CMake\bin\cmake.exe"
if NOT exist "%CMAKE%" (
    echo "unable to find CMake.  please install"
	pause
	exit
)

set "OS="
set "CPU="
:pickos
echo.
echo 1. win32
echo 2. win64
echo 3. android32
echo 4. android64
echo 5. Exit
set choice=
set /p choice=Please select an OS to build for: 
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' set "OS=win32" && set "CPU=Win32" && goto picktarget
if '%choice%'=='2' set "OS=win64" && set "CPU=x64" && goto picktarget
if '%choice%'=='3' set "OS=android32" && set "CPU=ARM" && goto picktarget
if '%choice%'=='4' set "OS=android64" && set "CPU=ARM64" && goto picktarget
if '%choice%'=='5' goto end
ECHO "%choice%" is not valid, please try again
goto pickos

:picktarget
echo Please type the name of the library, tool or app to build. Then press enter.
set /p input=
set "cmnd="%CMAKE%" -G "Visual Studio 17 2022" -A %CPU% -DDEBUG=ON -DRELEASE=ON -DSTATIC=ON -DREBUILDALL=ON -DHAVE_DKDuktape=1 -DTARGET=%input% -DOS=%OS% -S "%DKCMAKE%" -B "%DKCMAKE%\temp""

echo.
echo %cmnd%
echo.
%cmnd%
"cmd /c "%DKCMAKE%\temp\%input%.cmd"


::rmdir /Q /S "%DKCMAKE%\temp"

:end
ECHO Done
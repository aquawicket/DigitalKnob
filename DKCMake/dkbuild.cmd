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

echo Please type the name of the library, tool or app to build. Then press enter.
set /p input=
set "cmnd="%CMAKE%" -G "Visual Studio 17 2022" -A Win32 -DDEBUG=ON -DRELEASE=ON -DSTATIC=ON -DREBUILDALL=ON -DTARGET=%input% -S "%DKCMAKE%" -B "%DKCMAKE%\build""
echo %cmnd%
%cmnd%


pause

:end
ECHO Done
:: Let's ask the use to type in what they want to build
:: could be an app, library or anything with a DKMAKE.cmake file
:: We whould also give the option to list targets as well

@echo off
if exist "C:\Program Files\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files\CMake\bin\cmake.exe"
if exist "C:\Program Files (x86)\CMake\bin\cmake.exe" set "CMAKE=C:\Program Files (x86)\CMake\bin\cmake.exe"
if NOT exist "%CMAKE%" (
    echo "unable to find CMake.  please install"
	pause
	exit
)

echo Please type the name of the library, tool or app to build. Then press enter.
set /p input=
set cmnd="%CMAKE% -G "VS_GENERATOR" -A Win32 -DDEBUG -DRELEASE -DSTATIC -DTARGET=%input%"
%cmnd%


pause

:end
ECHO Done
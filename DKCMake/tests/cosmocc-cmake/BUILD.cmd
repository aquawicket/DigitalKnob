@echo off

@RD /S /Q "build"

::###### Configure helloWorld ######
set "BASH_EXE=C:\Users\Administrator\digitalknob\Development\3rdParty\msys2-x86_64-20240727\usr\bin\bash.exe"
set "CMAKE_EXE=C:/Users/Administrator/digitalknob/DKTools/cmake-3.29.5-windows-x86_64/bin/cmake"
set "CMAKE_SOURCE_DIR=C:/Users/Administrator/Desktop/cosmocc-cmake"
set "CMAKE_BINARY_DIR=C:/Users/Administrator/Desktop/cosmocc-cmake/build"
%BASH_EXE% -c "%CMAKE_EXE% -G ""MSYS Makefiles"" -B%CMAKE_BINARY_DIR% -S%CMAKE_SOURCE_DIR%"

::###### Build helloWorld ######
%BASH_EXE% -c "%CMAKE_EXE% --build %CMAKE_BINARY_DIR% --verbose"


::###### Execute helloWorld ######
echo:
echo:
%CD%\build\helloWorld.com
 
pause
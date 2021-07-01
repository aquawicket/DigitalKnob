@echo off 

set OS = "win32"

set currentFolder = %cd%
for %%I in (.) do set APP=%%~nxI
echo ****** RUNNING BUILD FOR %APP% ******
pause

git clone https://github.com/aquawicket/DigitalKnob.git C:\Users\%USERNAME%\digitalknob\DK
cd C:\Users\%USERNAME%\digitalknob\DK
git checkout -- .
git pull origin master

mkdir "%cd%\%OS%"
cd "%cd%\%OS%"
del "%cd%\%OS%\CMakeCache.txt"
C:\PROGRA~2\CMake\bin\cmake.exe -G "Visual Studio 16 2019" -A Win32 -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON -S C:\Users\%USERNAME%\digitalknob\DK -B "%cd%\%OS%

cd C:\Users\%USERNAME%\digitalknob\DK\DKApps\%APP%\%OS%
"C:\PROGRA~2\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" %APP%.sln /p:Configuration=Release

set /p DUMMY=Hit ENTER to continue...
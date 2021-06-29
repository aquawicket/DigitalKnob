:: first remove any CMake case file
DEL "C:\Users\%USERNAME%\digitalknob\DK\DKApps\DKBuilder\win32\CMakeCache.txt"

C:\PROGRA~2\CMake\bin\cmake.exe -G "Visual Studio 16 2019" -A Win32 -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON -S C:\Users\%USERNAME%\digitalknob\DK -B C:\Users\%USERNAME%\digitalknob\DK\DKApps\DKBuilder\win32

cd C:\Users\%USERNAME%\digitalknob\DK\DKApps\DKBuilder\win32
"C:\PROGRA~2\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" DKBuilder.sln /p:Configuration=Release

set /p DUMMY=Hit ENTER to continue...
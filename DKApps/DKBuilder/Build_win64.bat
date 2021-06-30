git clone https://github.com/aquawicket/DigitalKnob.git C:\Users\%USERNAME%\digitalknob\DK
cd C:\Users\%USERNAME%\digitalknob\DK
git checkout -- .
git pull origin master

mkdir "C:\Users\%USERNAME%\digitalknob\DK\DKApps\DKBuilder\win64"
cd "C:\Users\%USERNAME%\digitalknob\DK\DKApps\DKBuilder\win64"
del "C:\Users\%USERNAME%\digitalknob\DK\DKApps\DKBuilder\win64\CMakeCache.txt"
C:\PROGRA~2\CMake\bin\cmake.exe -G "Visual Studio 16 2019" -A x64 -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON -S C:\Users\%USERNAME%\digitalknob\DK -B C:\Users\%USERNAME%\digitalknob\DK\DKApps\DKBuilder\win64

cd C:\Users\%USERNAME%\digitalknob\DK\DKApps\DKBuilder\win64
"C:\PROGRA~2\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" DKBuilder.sln /p:Configuration=Release

set /p DUMMY=Hit ENTER to continue...
@echo off
cd ../DKApps/DKBuilder
mkdir win32
cd win32
cmake -G "Visual Studio 16 2019" -A Win32 -DDEBUG=ON -DREBUILD=ON -DSTATIC=ON C:/digitalknob/DK
cd C:/digitalknob/DK/DKApps/DKBuilder/win32
"C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/MSBuild/Current/Bin/MSBuild.exe" DKBuilder.sln /p:Configuration=Debug

set /p DUMMY=Hit ENTER to continue...
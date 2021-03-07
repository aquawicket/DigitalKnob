@echo off
cd C:\digitalknob\DK
cmake -G "Unix Makefiles" -CC:/digitalknob/DK/DKCMake/DKCache.cmake -DCMAKE_C_COMPILER="C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/MSVC/14.28.29333/bin/Hostx64/x64/cl.exe" C:/digitalknob/DK/DKCMake

set /p DUMMY=Hit ENTER to continue...



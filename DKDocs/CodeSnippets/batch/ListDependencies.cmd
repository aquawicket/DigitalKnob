%dkbatch%

set "DUMPBIN=C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.30.30705/bin/Hostx86/x86/dumpbin.exe"
for /r %%a in (*.exe) do set "exe_file=%%a"
echo %exe_file%

"%DUMPBIN%" /dependents %exe_file%

%DKEND% 

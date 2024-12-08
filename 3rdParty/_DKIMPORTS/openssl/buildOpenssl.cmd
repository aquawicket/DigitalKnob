@echo off

::#########  NOT WORKING ######
::cd C:\Users\Administrator\digitalknob\Development\3rdParty\openssl-2f362e9\win_x86_64_clang\Debug && C:\Users\Administrator\digitalknob\DKTools\cmake-3.29.5-windows-x86_64\bin\cmake.exe -E env PATH=C:\Users\Administrator\digitalknob\Development\3rdParty\msys2-x86_64-20240727\clang64\bin;C:\Users\Administrator\digitalknob\Development\3rdParty\msys2-x86_64-20240727\usr\bin C:/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/usr/bin/perl ../../Configure no-shared --debug mingw64 CC=/C/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/clang64/bin/clang


cd C:\Users\Administrator\digitalknob\Development\3rdParty\openssl-2f362e9\win_x86_64_clang\Debug && set PATH=C:\Users\Administrator\digitalknob\Development\3rdParty\msys2-x86_64-20240727\clang64\bin;C:\Users\Administrator\digitalknob\Development\3rdParty\msys2-x86_64-20240727\usr\bin & C:/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/usr/bin/perl ../../Configure no-shared --debug mingw64 CC=/C/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/clang64/bin/clang


::############ CMD review configuration ############
C:\Users\Administrator\digitalknob\Development\3rdParty\msys2-x86_64-20240727\usr\bin\perl configdata.pm --dump

::############ CMD CLANG64 make ############ WORKS
cd C:\Users\Administrator\digitalknob\Development\3rdParty\openssl-2f362e9\win_x86_64_clang\Debug && C:\Users\Administrator\digitalknob\Development\3rdParty\msys2-x86_64-20240727\clang64\bin\mingw32-make.exe -C C:\Users\Administrator\digitalknob\Development\3rdParty\openssl-2f362e9\win_x86_64_clang\Debug

goto:eof

::C:\Users\Administrator\digitalknob\DKTools\cmake-3.29.5-windows-x86_64\bin\cmake.exe -E env ABC=Debug set
::goto:eof

cd C:\Users\Administrator\digitalknob\Development\3rdParty\openssl-2f362e9\win_x86_64_clang\Debug && cmd /V:ON /c C:\Users\Administrator\digitalknob\DKTools\cmake-3.29.5-windows-x86_64\bin\cmake.exe -E env PATH=C:\Users\Administrator\digitalknob\Development\3rdParty\msys2-x86_64-20240727\clang64\bin cmd "/V:ON /c echo PATH = %PATH%"

::############ BASH configure ############
%COMSPEC% /c %MSYS2%\usr\bin\bash.exe -v -c "cd /c/Users/Administrator/digitalknob/Development/3rdParty/openssl-2f362e9/win_x86_64_clang/Debug && export PATH=/c/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/clang64/bin:$PATH && export PATH=/c/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/usr/bin:$PATH && perl ../../Configure no-shared --debug mingw64 CC=clang

::############ BASH review configuration ############
%COMSPEC% /c %MSYS2%\usr\bin\bash.exe -v -c "cd /c/Users/Administrator/digitalknob/Development/3rdParty/openssl-2f362e9/win_x86_64_clang/Debug && export PATH=/c/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/clang64/bin:$PATH && export PATH=/c/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/usr/bin:$PATH && perl configdata.pm --dump"

::############ BASH CLANG64 make ############
%COMSPEC% /c %MSYS2%\usr\bin\bash.exe -v -c "cd /c/Users/Administrator/digitalknob/Development/3rdParty/openssl-2f362e9/win_x86_64_clang/Debug && export PATH=/c/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/clang64/bin:$PATH && export PATH=/c/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/usr/bin:$PATH && /c/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/clang64/bin/mingw32-make" -C /c/Users/Administrator/digitalknob/Development/3rdParty/openssl-2f362e9/win_x86_64_clang/Debug







goto:eof
::############ CMD MSYS make ############
cd %OPENSSL%\win_x86_64_clang\Debug & set "PATH=%MSYS2%\usr\bin;%PATH%" & %MSYS2%\usr\bin\make.exe -C %OPENSSL%\win_x86_64_clang\Debug

::############ configure ############
%COMSPEC% /c C:\Users\Administrator\digitalknob\Development\3rdParty\msys2-x86_64-20240727\usr\bin\bash.exe -v -c "cd /c/Users/Administrator/digitalknob/Development/3rdParty/openssl-2f362e9/win_x86_64_clang/Debug && export PATH=/c/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/clang64/bin:$PATH && export PATH=/c/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/usr/bin:$PATH && perl ../../Configure no-shared --debug mingw64 CC=clang

::############ review configuration ############
%COMSPEC% /c C:\Users\Administrator\digitalknob\Development\3rdParty\msys2-x86_64-20240727\usr\bin\bash.exe -v -c "cd /c/Users/Administrator/digitalknob/Development/3rdParty/openssl-2f362e9/win_x86_64_clang/Debug && export PATH=/c/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/clang64/bin:$PATH && export PATH=/c/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/usr/bin:$PATH && perl configdata.pm --dump"

::############ build ############
%COMSPEC% /c C:\Users\Administrator\digitalknob\Development\3rdParty\msys2-x86_64-20240727\usr\bin\bash.exe -v -c "cd /c/Users/Administrator/digitalknob/Development/3rdParty/openssl-2f362e9/win_x86_64_clang/Debug && export PATH=/c/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/clang64/bin:$PATH && export PATH=/c/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/usr/bin:$PATH && mingw32-make.exe"
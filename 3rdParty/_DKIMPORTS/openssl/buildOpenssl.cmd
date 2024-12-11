@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installOpenSSL()
::#
:dk_installOpenSSL
	call dk_debugFunc 0

	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	
	%dk_call% dk_set OPENSSL_DL "https://github.com/openssl/openssl/archive/2f362e9.zip"
	
	%dk_call% dk_basename %OPENSSL_DL% OPENSSL_DL_FILE
	%dk_call% dk_removeExtension %OPENSSL_DL_FILE% OPENSSL_FOLDER
	
	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
	set "OPENSSL=%DK3RDPARTY_DIR%\%OPENSSL_FOLDER%"
	
	if exist %OPENSSL%\Configure" echo "openssl already installed" && %return%
	%dk_call% dk_download %OPENSSL_DL%
	
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	
	%dk_call% dk_info "Installing %OPENSSL_FOLDER%"
	
	:: TODO
	
	%dk_call% dk_printVar OPENSSL
%endfunction%



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
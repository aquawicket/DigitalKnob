@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# buildOpenSSL()
::#
:buildOpenSSL
	call dk_debugFunc 0
	
	%dk_call% dk_validate OPENSSL "call installOpenSSL.cmd"
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate MSYS2 "call %DKIMPORTS_DIR%\msys2\dk_installMsys2.cmd"
	
	::############ CMD configure ############
	%dk_call% dk_delete %OPENSSL%\win_x86_64_clang
	%dk_call% dk_makeDirectory %OPENSSL%\win_x86_64_clang\Debug 
	cd %OPENSSL%\win_x86_64_clang\Debug && set PATH=%MSYS2%\clang64\bin;%MSYS2%\usr\bin;%MSYS2% & C:/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/usr/bin/perl ../../Configure no-shared --debug mingw64 CC=clang


	::############ CMD review configuration ############
	%MSYS2%\usr\bin\perl configdata.pm --dump


	::############ CMD CLANG64 make ############ WORKS
	%MSYS2%\clang64\bin\mingw32-make -C %OPENSSL%\win_x86_64_clang\Debug
	
%endfunction%

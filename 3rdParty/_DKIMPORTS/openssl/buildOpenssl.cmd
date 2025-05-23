@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# buildOpenSSL()
::#
:buildOpenSSL
	%dk_call% dk_debugFunc 0
	
	::set "TARGET_TRIPLE=win_x86_64_clang"
	set "TARGET_TRIPLE=win_x86_msvc"
	set "TARGET_TYPE=Debug"
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate OPENSSL "%dk_call% %DKIMPORTS_DIR%\openssl\DKINSTALL.cmd"
	%dk_call% dk_validate NASM "%dk_call% %DKIMPORTS_DIR%\nasm\DKINSTALL.cmd"
	%dk_call% dk_delete %OPENSSL%\%TARGET_TRIPLE%
	%dk_call% dk_mkdir %OPENSSL%\%TARGET_TRIPLE%\Debug 
	
	::############ win_x86_64_clang ##########
	if "%TARGET_TRIPLE%"=="win_x86_64_clang" (
		%dk_call% dk_validate MSYS2 "%dk_call% %DKIMPORTS_DIR%\msys2\DKINSTALL.cmd"
		cd %OPENSSL%\%TARGET_TRIPLE%\%TARGET_TYPE% && set PATH=%MSYS2%\clang64\bin;%MSYS2%\usr\bin;%MSYS2% & C:/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/usr/bin/perl ../../Configure no-shared --debug mingw64 CC=clang
		%MSYS2%\usr\bin\perl configdata.pm --dump
		%MSYS2%\clang64\bin\mingw32-make -C %OPENSSL%\win_x86_64_clang\Debug
	)
	if "%TARGET_TRIPLE%"=="win_x86_msvc" (
		cd %OPENSSL%\%TARGET_TRIPLE%\%TARGET_TYPE% && set PATH=%NASM%; & %USERPROFILE%\digitalknob\Development\3rdParty\strawberry-perl-5.40.0.1-64bit-portable\perl\bin\perl.exe ../../Configure no-shared --debug VC-WIN32
		%USERPROFILE%\digitalknob\Development\3rdParty\strawberry-perl-5.40.0.1-64bit-portable\perl\bin\perl.exe configdata.pm --dump
	)

	
%endfunction%

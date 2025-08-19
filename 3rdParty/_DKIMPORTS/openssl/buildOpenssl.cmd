@echo off&::###### DK.cmd #########################################################################################################################
if NOT exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# buildOpenSSL()
::#
:buildOpenSSL
	%dk_call% dk_debugFunc 0
	
	::set "Target_Tuple=Windows_X86_64_Clang"
	set "Target_Tuple=Windows_X86_Msvc"
	set "Target_Type=Debug"
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate OPENSSL "%dk_call% dk_depend openssl"
	%dk_call% dk_validate NASM "%dk_call% dk_depend nasm"
	%dk_call% dk_delete %OPENSSL%\%Target_Tuple%
	%dk_call% dk_mkdir %OPENSSL%\%Target_Tuple%\Debug
	
	::############ Windows_X86_64_Clang ##########
	if "%Target_Tuple%"=="Windows_X86_64_Clang" (
		%dk_call% dk_validate MSYS2 "%dk_call% dk_depend msys2"
		%dk_call% dk_chdir %OPENSSL%\%Target_Tuple%\%Target_Type% && set PATH=%MSYS2%\clang64\bin;%MSYS2%\usr\bin;%MSYS2% & %USERPROFILE:\=/%/DigitalKnob/Development/3rdParty/msys2-x86_64-20240727/usr/bin/perl ../../Configure no-shared --debug mingw64 CC=clang
		%MSYS2%\usr\bin\perl configdata.pm --dump
		%MSYS2%\clang64\bin\mingw32-make -C %OPENSSL%\Windows_X86_64_Clang\Debug
	)
	if "%Target_Tuple%"=="Windows_X86_Msvc" (
		%dk_call% dk_chdir %OPENSSL%\%Target_Tuple%\%Target_Type% && set PATH=%NASM%; & %USERPROFILE%\DigitalKnob\Development\3rdParty\strawberry-perl-5.40.0.1-64bit-portable\perl\bin\perl.exe ../../Configure no-shared --debug VC-WIN32
		%USERPROFILE%\DigitalKnob\Development\3rdParty\strawberry-perl-5.40.0.1-64bit-portable\perl\bin\perl.exe configdata.pm --dump
	)

	
%endfunction%

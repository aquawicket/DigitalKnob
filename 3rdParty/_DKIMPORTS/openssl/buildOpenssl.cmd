rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ####################################################################
rem # buildOpenSSL()
rem #
:buildOpenSSL
	
	rem set "Target_Tuple=Windows_X86_64_Clang"
	set "Target_Tuple=Windows_X86_Msvc"
	set "Target_Type=Debug"
	
	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	%dk_call% dk_validate openssl %dk_call% dk_depend openssl
	%dk_call% dk_validate nasm %dk_call% dk_depend nasm
	%dk_call% dk_delete "%openssl%/%Target_Tuple%"
	%dk_call% dk_mkdir "%openssl%/%Target_Tuple%/Debug"
	
	rem ############ Windows_X86_64_Clang ##########
	if "%Target_Tuple%"=="Windows_X86_64_Clang" (
		%dk_call% dk_validate MSYS2 %dk_call% dk_depend msys2
		%dk_call% dk_chdir %openssl%/%Target_Tuple%/%Target_Type% && set PATH=%msys2%/clang64/bin;%msys2%/usr/bin;%msys2% & %USERPROFILE:\=/%/Digital Knob/Development/3rdParty/msys2-x86_64-20240727/usr/bin/perl ../../Configure no-shared --debug mingw64 CC=clang
		%msys2%/usr/bin/perl configdata.pm --dump
		%msys2%/clang64/bin/mingw32-make -C %openssl%/Windows_X86_64_Clang/Debug
	)
	if "%Target_Tuple%"=="Windows_X86_Msvc" (
		%dk_call% dk_chdir %openssl%/%Target_Tuple%/%Target_Type% && set PATH=%nasm:/=\%; & %USERPROFILE:\=/%/Digital Knob/Development/3rdParty/strawberry-perl-5.40.0.1-64bit-portable/perl/bin/perl.exe ../../Configure no-shared --debug VC-WIN32
		%USERPROFILE"\=/%/Digital Knob/Development/3rdParty/strawberry-perl-5.40.0.1-64bit-portable/perl/bin/perl.exe configdata.pm --dump
	)

	
%endfunction%

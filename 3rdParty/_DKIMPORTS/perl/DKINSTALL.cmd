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


rem ############ pearl ############
rem # https://packages.msys2.org/package/mingw-w64-x86_64-perl
rem #
:DKINSTALL
rem %setlocal%

	if EXIST "%perl_exe%" (
		%return%
	)

rem 	%dk_call% dk_validate MSYSTEM %dk_call% dk_MSYSTEM
rem 	%dk_call% dk_debug "MSYSTEM = %MSYSTEM%"

	if defined Windows_Arm64_Clang (
		%dk_call% dk_validate msys2 %dk_call% dk_depend msys2
		%dk_call% dk_installPackage perl
		set "perl_exe=!msys2!/usr/bin/perl.exe"
		
	) else if defined Windows_X86_Clang (
		%dk_call% dk_validate msys2 %dk_call% dk_depend msys2
		%dk_call% dk_installPackage perl
		set "perl_exe=!msys2!/usr/bin/perl.exe"
		
	) else if defined Windows_X86_64_Clang (
		%dk_call% dk_validate msys2 %dk_call% dk_depend msys2
		%dk_call% dk_installPackage perl
		set "perl_exe=!msys2!/usr/bin/perl.exe"
		
	) else if defined Windows_X86_Gcc (
		%dk_call% dk_validate msys2 %dk_call% dk_depend msys2
		%dk_call% dk_installPackage perl
		set "perl_exe=!msys2!/usr/bin/perl.exe"
		
	) else if defined Windows_X86_64_Gcc (
		%dk_call% dk_validate msys2 %dk_call% dk_depend msys2
		%dk_call% dk_installPackage perl
		set "perl_exe=!msys2!/usr/bin/perl.exe"
		
	) else if defined Windows_X86_64_Ucrt (
		%dk_call% dk_validate msys2 %dk_call% dk_depend msys2
		%dk_call% dk_installPackage perl
		set "perl_exe=!msys2!/usr/bin/perl.exe"
		
	) else if defined Windows_X86_Msvc (
		%dk_call% dk_validate strawberry-perl %dk_call% dk_depend strawberry-perl
		
	) else if defined Windows_X86_64_Msvc (
		%dk_call% dk_validate strawberry-perl %dk_call% dk_depend strawberry-perl
		
	) else (
		%dk_call% dk_validate msys2 %dk_call% dk_depend msys2
		%dk_call% dk_installPackage perl
		set "perl_exe=!msys2!/usr/bin/perl.exe"
	)

	%dk_call% dk_assertPath "%perl_exe%"
	
	endlocal & (
		set "perl_exe=%perl_exe%"
	)
%endfunction%










rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate perl_exe %dk_call% dk_depend perl
	%dk_call% dk_debug "perl_exe = %perl_exe%"
	
	%dk_call% dk_validate perl_exe %dk_call% dk_depend perl
	%dk_call% dk_debug "perl_exe = %perl_exe%"
%endfunction%

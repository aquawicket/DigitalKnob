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
rem # DKINSTALL()
rem #
:DKINSTALL
%setlocal%

	
	%dk_call% dk_installPackage gcc
	
	if defined Linux (
		if exist "/usr/bin/gcc" (
			set "gcc_exe=/usr/bin/gcc"
		) else if exist "/usr/local/bin/gcc" (
			set "gcc_exe=/usr/local/bin/gcc"
		)
	else if defined Windows_Arm64_Clang (
		%dk_call% dk_validate msys2 %dk_call% dk_depend msys2
		set "gcc_exe=!msys2!/clangarm64/bin/gcc.exe"
	
	) else if defined Windows_X86_64_Clang (
		%dk_call% dk_validate msys2 %dk_call% dk_depend msys2
		set "gcc_exe=!msys2!/clang64/bin/gcc.exe"
	
	) else if defined Windows_X86_64_Gcc (
		%dk_call% dk_validate msys2 %dk_call% dk_depend msys2
		set "gcc_exe=!msys2!/mingw64/bin/gcc.exe"
	
	) else if defined Windows_X86_64_Ucrt (
		%dk_call% dk_validate msys2 %dk_call% dk_depend msys2
		set "gcc_exe=!msys2!/ucrt64/bin/gcc.exe"
	
	) else if defined Windows_X86_Clang (
		%dk_call% dk_validate msys2 %dk_call% dk_depend msys2
		set "gcc_exe=!msys2!/clang32/bin/gcc.exe"
	
	) else if defined Windows_X86_Gcc (
		%dk_call% dk_validate msys2 %dk_call% dk_depend msys2
		set "gcc_exe=!msys2!/mingw32/bin/gcc.exe"
	)
	
	
	:return
	rem %dk_call% dk_firewallAllow "%gcc_exe%"
	endlocal & (
		set "gcc_exe=%gcc_exe:\=/%"
	)
	rem %dk_call% dk_debug "gcc_exe = %gcc_exe%"
%endfunction%

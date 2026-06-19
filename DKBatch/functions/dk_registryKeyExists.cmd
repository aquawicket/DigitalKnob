@rem shebang
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


rem #################################################################################
rem dk_registryKeyExists(reg_path)
rem dk_registryKeyExists(reg_path, rtn_var)
rem 
:dk_registryKeyExists
%setlocal%

	set "_reg_path_=%~1"

	%dk_call% dk_validate reg.exe %dk_call% dk_findFile reg.exe

	"%reg.exe:/=\%" query "%_reg_path_:/=\%" 1>nul 2>nul

	if %ERRORLEVEL% equ 0 (
		set "dk_registryKeyExists=0"
	) else (
		set "dk_registryKeyExists=-1"
	)

	endlocal & (
		set "dk_registryKeyExists=%dk_registryKeyExists%"
		if "%~2" neq "" (set "%~2=%dk_registryKeyExists%")
		exit /b %dk_registryKeyExists%
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_registryKeyExists "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.txt" 	&& %dk_call% dk_info "key exists" || %dk_call% dk_info "key NOT FOUND"
	%dk_call% dk_registryKeyExists "HKCU/SOFTWARE/NonExistentKey" 											&& %dk_call% dk_info "key exists" || %dk_call% dk_info "key NOT FOUND"
	%dk_call% dk_registryKeyExists "HKLM/Software/Microsoft/Windows/CurrentVersion/Uninstall/QEMU" 			&& %dk_call% dk_info "qemu is installed" || %dk_call% dk_info "qemu is NOT installed"
%endfunction%

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


::############ wsl-debian ############
::# wsl-debian_Import"https://wslstorestorage.blob.core.windows.net/wslblob/TheDebianProject.DebianGNULinux_1.12.2.0_neutral___76v4gfsz19hv4.AppxBundle"
::#
:DKINSTALL
::%setlocal%
	
	%dk_call% dk_validate wsl.exe %dk_call% dk_depend wsl.exe

	::"%wsl.exe%" --list
	::"%wsl.exe%" --list | %findstr.exe% Debian 1>nul 2>nul && echo Debian Found || echo Debian NOT Found
	%dk_call% dk_validate find.exe %dk_call% dk_depend find.exe
	"%wsl.exe%" --list | "%find.exe:/=\%" "Debian" /v /c 1>nul 2>nul && %return%
	
	%dk_call% dk_set wsl-debian_Import"https://wslstorestorage.blob.core.windows.net/wslblob/TheDebianProject.DebianGNULinux_1.12.2.0_neutral___76v4gfsz19hv4.AppxBundle"
	
	%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
	%dk_call% dk_importVariables %DEBIAN_IMPORT% IMPORT_PATH %DKIMPORTS_DIR%/wsl-debian ROOT %DKTOOLS_DIR%	
	%dk_call% dk_download %DEBIAN_IMPORT%
	
	%dk_call% dk_echo  
    %dk_call% dk_info "Installing WSL-Debian Linux . . ."
	
	%dk_call% dk_validate powershell.exe %dk_call% dk_findFile powershell.exe
	%dk_call% dk_validate DKDOWNLOAD_DIR %dk_call% dk_DKDOWNLOAD_DIR
	%powershell.exe% -Command "Add-AppxPackage %DKDOWNLOAD_DIR%\TheDebianProject.DebianGNULinux_1.12.2.0_neutral___76v4gfsz19hv4.AppxBundle"
	
	:: https://superuser.com/a/1678974/600216
	:: start shell:AppsFolder\TheDebianProject.DebianGNULinux_76v4gfsz19hv4!debian
	:: %dk_call% dk_startPackage "Debian"
	
	::%dk_call% dk_validate wsl.exe %dk_call% dk_depend wsl.exe
	::"%wsl.exe%" -d Debian
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% DKINSTALL
	%dk_call% dk_wslFixNet
	%dk_call% dk_wslFixFileAccess
	%wsl.exe% --shutdown
%endfunction%

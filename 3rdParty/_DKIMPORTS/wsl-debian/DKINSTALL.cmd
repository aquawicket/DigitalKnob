@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_depend wsl
	
	%dk_call% dk_validate WSL_EXE "%dk_call% dk_WSL_EXE"

	::"%WSL_EXE%" --list
	::"%WSL_EXE%" --list | findstr Debian > nul 2>&1 && echo Debian Found || echo Debian NOT Found
	"%WSL_EXE%" --list | find "Debian" /v /c > nul 2>&1 && %return%
	
	%dk_call% dk_set DEBIAN_IMPORT "https://wslstorestorage.blob.core.windows.net/wslblob/TheDebianProject.DebianGNULinux_1.12.2.0_neutral___76v4gfsz19hv4.AppxBundle"
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables %DEBIAN_IMPORT% IMPORT_PATH %DKIMPORTS_DIR%/wsl-debian ROOT %DKTOOLS_DIR%	
	%dk_call% dk_download %DEBIAN_IMPORT%
	
	%dk_call% dk_echo  
    %dk_call% dk_info "Installing WSL-Debian Linux . . ."
	
	%dk_call% dk_validate powershell_exe "%dk_call% dk_depend powershell"
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	%powershell_exe% -Command "Add-AppxPackage %DKDOWNLOAD_DIR%\TheDebianProject.DebianGNULinux_1.12.2.0_neutral___76v4gfsz19hv4.AppxBundle"
	
	:: https://superuser.com/a/1678974/600216
	:: start shell:AppsFolder\TheDebianProject.DebianGNULinux_76v4gfsz19hv4!debian
	:: %dk_call% dk_startPackage "Debian"
	
	::%dk_call% dk_validate WSL_EXE "%dk_call% dk_WSL_EXE"
	::"%WSL_EXE%" -d Debian
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
	%dk_call% dk_wslFixNet
	%dk_call% dk_wslFixFileAccess
	%WSL_EXE% --shutdown
%endfunction%

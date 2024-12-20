@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installWslDebian()
::#
:dk_installWslDebian
	call dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate WSL_EXE "call %DKIMPORTS_DIR%\wsl\dk_installWsl.cmd"
	
	%dk_call% dk_set DEBIAN_DL "https://wslstorestorage.blob.core.windows.net/wslblob/TheDebianProject.DebianGNULinux_1.12.2.0_neutral___76v4gfsz19hv4.AppxBundle"
	%dk_call% dk_download %DEBIAN_DL%
	
	%dk_call% dk_echo   
    %dk_call% dk_info "Installing WSL-Debian Linux . . ."
	
	%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE"
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	%POWERSHELL_EXE% -Command "Add-AppxPackage %DKDOWNLOAD_DIR%\TheDebianProject.DebianGNULinux_1.12.2.0_neutral___76v4gfsz19hv4.AppxBundle"
	
	:: https://superuser.com/a/1678974/600216
	:: start shell:AppsFolder\TheDebianProject.DebianGNULinux_76v4gfsz19hv4!debian
	%dk_call% dk_startPackage "Debian"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_installWslDebian
	%dk_call% dk_wslFixNet
	%dk_call% dk_wslFixFileAccess
	%WSL_EXE% --shutdown
%endfunction%

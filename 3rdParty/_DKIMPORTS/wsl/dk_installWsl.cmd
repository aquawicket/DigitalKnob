@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installWsl()
::#
::#    Troubleshooting: https://learn.microsoft.com/en-us/windows/wsl/troubleshooting
:dk_installWsl
	call dk_debugFunc 0
	
	:: https://learn.microsoft.com/en-us/windows/wsl/install-manual
	
	:: Step 1 - Enable the Windows Subsystem for Linux
	call dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
	call dism.exe /online /enable-feature /featurename:Microsoft-Hyper-V /all /norestart

	
	:: Step 2 - Check requirements for running WSL 2
	:: TODO
	
	:: Step 3 - Enable Virtual Machine feature
	dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
	
	:: Step 4 - Download the Linux kernel update package
	%dk_call% dk_validate HOST_ARCH "%dk_call% dk_HOST_TRIPLE"
	if defined WIN_X86_64_HOST  set "WSL_DL=https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
	%dk_call% dk_basename %WSL_DL% WSL_DL_FILE
	%dk_call% dk_echo   
    %dk_call% dk_info "Installing Wsl Update . . ."
    %dk_call% dk_download %WSL_DL%
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	"%DKDOWNLOAD_DIR%\%WSL_DL_FILE%"
	
	:: Step 5 - Set WSL 2 as your default version
	wsl --set-default-version 2
	
	
	goto:eof
	:: Install your Linux distribution of choice
	%dk_call% dk_set LAUNCHER_DL "https://github.com/agowa/WSL-DistroLauncher-Alpine/releases/download/1.3.2/launcher.exe"
	%dk_call% dk_echo   
    %dk_call% dk_info "Installing WSL-Alpine Linux . . ."
	%dk_call% dk_download %LAUNCHER_DL%
	%dk_call% dk_makeDirectory %DKTOOLS_DIR%\AlpineLinux
	%dk_call% dk_basename %LAUNCHER_DL% LAUNCHER_DL_FILE
	%dk_call% dk_copy %DKDOWNLOAD_DIR%\%LAUNCHER_DL_FILE% %DKTOOLS_DIR%\AlpineLinux\%LAUNCHER_DL_FILE% OVERWRITE
	%DKTOOLS_DIR%\AlpineLinux\%LAUNCHER_DL_FILE%
	
	::wsl --install --distribution Debian
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installWsl
%endfunction%

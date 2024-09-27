@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

call dk_source dk_powershell
::####################################################################
::# dk_installWsl()
::#
:dk_installWsl
	call dk_debugFunc 0
	
	:: https://learn.microsoft.com/en-us/windows/wsl/install-manual
	
	:: Step 1 - Enable the Windows Subsystem for Linux
	%dk_call% dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
	%dk_call% dk_powershell "Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux"
	
	:: Step 2 - Check requirements for running WSL 2
	:: TODO
	
	:: Step 3 - Enable Virtual Machine feature
	dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
	
	:: Step 4 - Download the Linux kernel update package
	%dk_call% dk_validate HOST_ARCH "%dk_call% dk_HOST_TRIPLE"
	if "%HOST_OS%_%HOST_ARCH%"=="WIN_X86_64" %dk_call% dk_set WSL_DL "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
	%dk_call% dk_basename %WSL_DL% WSL_DL_FILE
	%dk_call% dk_echo   
    %dk_call% dk_info "Installing Wsl Update . . ."
    %dk_call% dk_download %WSL_DL%
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	"%DKDOWNLOAD_DIR%\%WSL_DL_FILE%"
	
	:: Step 5 - Set WSL 2 as your default version
	wsl --set-default-version 2
	
	:: Step 6 - Install your Linux distribution of choice
	::%dk_call% dk_set UBUNTU_DL "https://aka.ms/wslubuntu"
	::%dk_call% dk_set UBUNTU_DL_FILE "Ubuntu2204-221101.AppxBundle"
	::%dk_call% dk_echo   
    ::%dk_call% dk_info "Installing Wsl_Ubuntu . . ."
    ::%dk_call% dk_download %UBUNTU_DL%
	::%dk_call% dk_powershell "Add-AppxPackage %DKDOWNLOAD_DIR%\%UBUNTU_DL_FILE%"
	
	::wsl --install --distribution Debian
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_installWsl
%endfunction%


@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
::#    Troubleshooting: https://learn.microsoft.com/en-us/windows/wsl/troubleshooting
::#    Custom Distro:   https://learn.microsoft.com/en-us/windows/wsl/use-custom-distro
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate WSL_EXE "%dk_call% dk_WSL_EXE"
	
	if EXIST "%WSL_EXE%" (
		%dk_call% dk_info "WSL already installed"
		goto:step4
	) else (
		%dk_call% dk_notice "WSL NOT found"
	)
	::%WSL_EXE% --status

	:: https://learn.microsoft.com/en-us/windows/wsl/install-manual
	
	:: Step 1 - Enable the Windows Subsystem for Linux
	call dism.exe /online /Get-FeatureInfo /featurename:Microsoft-Windows-Subsystem-Linux | find "Disabled" && (
		echo(
		echo enabling Microsoft-Windows-Subsystem-Linux . . .
		call dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
	)
	call dism.exe /online /Get-FeatureInfo /featurename:Microsoft-Hyper-V | find "Disabled" && (
		echo(
		echo enabling Microsoft-Hyper-V . . .
		call dism.exe /online /enable-feature /featurename:Microsoft-Hyper-V /all /norestart
	)

	
	:: Step 2 - Check requirements for running WSL 2
	:: TODO
	
	:: Step 3 - Enable Virtual Machine feature
	call dism.exe /online /Get-FeatureInfo /featurename:VirtualMachinePlatform | find "Disabled" && (
		echo(
		echo enabling VirtualMachinePlatform . . .
		call dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
		shutdown /r /t 3
	)
	
	:step4
	:: Step 4 - Download the Linux kernel update package
	reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | findstr /I /C:"{36EF257E-21D5-44F7-8451-07923A8C465E}" 1>nul && goto end_step4
		
		%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
		if defined Windows_X86_64_Host (set "WSL_DL=https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi")
		%dk_call% dk_basename %WSL_DL% WSL_IMPORT_FILE
		%dk_call% dk_echo  
		%dk_call% dk_info "Installing Wsl Update . . ."
		%dk_call% dk_download %WSL_DL%
		::%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
		::"%DKDOWNLOAD_DIR%\%WSL_IMPORT_FILE%"
		"%dk_download%"
	:end_step4
	
	
	:: Step 5 - Set WSL 2 as your default version
	wsl --set-default-version 2
	
	::wsl --install --web-download --distribution Ubuntu                         
	::wsl --install --web-download --distribution Debian
	::wsl --install --web-download --distribution kali-linux
	::wsl --install --web-download --distribution Ubuntu-18.04
	::wsl --install --web-download --distribution Ubuntu-20.04
	::wsl --install --web-download --distribution Ubuntu-22.04
	::wsl --install --web-download --distribution Ubuntu-24.04
	::wsl --install --web-download --distribution OracleLinux_7_9
	::wsl --install --web-download --distribution OracleLinux_8_7
	::wsl --install --web-download --distribution OracleLinux_9_1
	::wsl --install --web-download --distribution openSUSE-Leap-15.6
	::wsl --install --web-download --distribution SUSE-Linux-Enterprise-15-SP5
	::wsl --install --web-download --distribution SUSE-Linux-Enterprise-15-SP6
	::wsl --install --web-download --distribution openSUSE-Tumbleweed
%endfunction%

@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_uninstallWsl()
::#
:dk_uninstallWsl
	call dk_debugFunc 0
	
	%dk_call% dk_findProgram WSL_EXE wsl.exe
	::%WSL_EXE% --uninstall
	
	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
	if defined win_x86_64_host  set "WSL_DL=https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
	%dk_call% dk_basename %WSL_DL% WSL_DL_FILE
	%dk_call% dk_echo   
    %dk_call% dk_info "Un-installing Wsl Update . . ."
    %dk_call% dk_download %WSL_DL%
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	"%DKDOWNLOAD_DIR%\%WSL_DL_FILE%" /uninstall
	
	
	call dism.exe /online /Get-FeatureInfo /featurename:VirtualMachinePlatform | find "Enabled" && (
		echo:
		echo disabling VirtualMachinePlatform . . .
		call dism.exe /online /disable-feature /featurename:VirtualMachinePlatform /norestart
	)
	
	call dism.exe /online /Get-FeatureInfo /featurename:Microsoft-Hyper-V | find "Enabled" && (
		echo:
		echo disabling Microsoft-Hyper-V . . .
		call dism.exe /online /disable-feature /featurename:Microsoft-Hyper-V /norestart
	)
	
	call dism.exe /online /Get-FeatureInfo /featurename:Microsoft-Windows-Subsystem-Linux | find "Enabled" && (
		echo:
		echo disabling Microsoft-Windows-Subsystem-Linux . . .
		call dism.exe /online /disable-feature /featurename:Microsoft-Windows-Subsystem-Linux /norestart
	)
	
	shutdown /r /t 0
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_uninstallWsl
%endfunction%


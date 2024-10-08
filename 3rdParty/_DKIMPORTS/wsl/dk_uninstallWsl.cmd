@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_uninstallWsl()
::#
:dk_uninstallWsl
	call dk_debugFunc 0
	
	%dk_call% dk_findProgram WSL_EXE wsl.exe
	::%WSL_EXE% --uninstall
	
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
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_uninstallWsl
%endfunction%


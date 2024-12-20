@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_uninstallWsl()
::#
:dk_uninstallWsl
	call dk_debugFunc 0
	
	%dk_call% dk_findProgram WSL_EXE wsl.exe
	::%WSL_EXE% --uninstall
	
	:: Uninstall Windows-Subsystem-Linux-Update
	reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | findstr /I /C:"{36EF257E-21D5-44F7-8451-07923A8C465E}" 1>nul && (
		msiexec.exe /X{36EF257E-21D5-44F7-8451-07923A8C465E}
	)
	
	:: Uninstall VirtualMachinePlatform
	call dism.exe /online /Get-FeatureInfo /featurename:VirtualMachinePlatform | find "Enabled" && (
		echo:
		echo disabling VirtualMachinePlatform . . .
		call dism.exe /online /disable-feature /featurename:VirtualMachinePlatform /norestart
	)
	
	:: Uninstall Microsoft-Hyper-V 
	call dism.exe /online /Get-FeatureInfo /featurename:Microsoft-Hyper-V | find "Enabled" && (
		echo:
		echo disabling Microsoft-Hyper-V . . .
		call dism.exe /online /disable-feature /featurename:Microsoft-Hyper-V /norestart
	)
	
	:: Uninstall Microsoft-Windows-Subsystem-Linux
	call dism.exe /online /Get-FeatureInfo /featurename:Microsoft-Windows-Subsystem-Linux | find "Enabled" && (
		echo:
		echo disabling Microsoft-Windows-Subsystem-Linux . . .
		call dism.exe /online /disable-feature /featurename:Microsoft-Windows-Subsystem-Linux /norestart
	)
	
	:: restart
	shutdown /r /t 3
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_uninstallWsl
%endfunction%


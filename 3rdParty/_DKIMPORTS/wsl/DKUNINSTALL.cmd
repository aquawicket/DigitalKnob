@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# DKUNINSTALL()
::#
:DKUNINSTALL
::setlocal
	%dk_call% dk_debugFunc 0
	
	echo:
	echo ### Uninstalling wsl ###
	%dk_call% dk_findProgram WSL_EXE wsl.exe
	::%WSL_EXE% --uninstall
	
	:: Uninstall Windows-Subsystem-Linux-Update
	reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | findstr /I /C:"{36EF257E-21D5-44F7-8451-07923A8C465E}" 1>nul && (
		msiexec.exe /X{36EF257E-21D5-44F7-8451-07923A8C465E}
	)
	
	:: Uninstall VirtualMachinePlatform
	%dk_call% dism.exe /online /Get-FeatureInfo /featurename:VirtualMachinePlatform | find "Enabled" && (
		echo:
		echo disabling VirtualMachinePlatform . . .
		%dk_call% dism.exe /online /disable-feature /featurename:VirtualMachinePlatform /norestart
	)
	
	:: Uninstall Microsoft-Hyper-V 
	%dk_call% dism.exe /online /Get-FeatureInfo /featurename:Microsoft-Hyper-V | find "Enabled" && (
		echo:
		echo disabling Microsoft-Hyper-V . . .
		%dk_call% dism.exe /online /disable-feature /featurename:Microsoft-Hyper-V /norestart
	)
	
	:: Uninstall Microsoft-Windows-Subsystem-Linux
	%dk_call% dism.exe /online /Get-FeatureInfo /featurename:Microsoft-Windows-Subsystem-Linux | find "Enabled" && (
		echo:
		echo disabling Microsoft-Windows-Subsystem-Linux . . .
		%dk_call% dism.exe /online /disable-feature /featurename:Microsoft-Windows-Subsystem-Linux /norestart
	)
	
	:: FIXME - is this needed
	echo ### Uninstalling Windows Subsystem for Linux ###
	MsiExec.exe /uninstall {AAAA4669-FCEF-4B2A-8355-1E0FA411A269} /quiet
	
	:: restart
	shutdown /r /t 3
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKUNINSTALL
%endfunction%


@echo off
call ../../../DKBatch/functions/DK.cmd

::####################################################################
::# dk_installWsl()
::#
:dk_installWsl () {
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	:: https://learn.microsoft.com/en-us/windows/wsl/install-manual
	
	:: Step 1 - Enable the Windows Subsystem for Linux
	call dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
	call dk_powershellEval "Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux"
	
	:: Step 2 - Check requirements for running WSL 2
	:: TODO
	
	:: Step 3 - Enable Virtual Machine feature
	dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
	
	:: Step 4 - Download the Linux kernel update package
	call dk_validate HOST_ARCH "call dk_getHostTriple"
	if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64" call dk_set WSL_DL "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
	call dk_getFilename %WSL_DL% WSL_DL_FILE
	call dk_echo   
    call dk_info "Installing Wsl Update . . ."
    call dk_download %WSL_DL% "%DKDOWNLOAD_DIR%\%WSL_DL_FILE%"
	"%DKDOWNLOAD_DIR%\%WSL_DL_FILE%"
	
	
goto:eof



:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	call dk_installWsl

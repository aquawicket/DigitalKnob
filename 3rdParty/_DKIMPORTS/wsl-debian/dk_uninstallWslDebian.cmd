@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_uninstallWslDebian()
::#
:dk_uninstallWslDebian
	call dk_debugFunc 0
	
	::%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	::%dk_call% dk_validate WSL_EXE "%dk_call% %DKIMPORTS_DIR%\wsl\dk_installWsl.cmd"
	
	%dk_call% dk_echo   
    %dk_call% dk_info "UnInstalling WSL-Debian Linux . . ."

	wsl --terminate Debian
	wsl --unregister Debian
	taskkill /f /im wslservice.exe
	
	%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE"
	%POWERSHELL_EXE% -Command "Remove-AppxPackage -Package TheDebianProject.DebianGNULinux_1.12.2.0_x64__76v4gfsz19hv4"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_uninstallWslDebian
%endfunction%

@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_uninstallWslDebian()
::#
:dk_uninstallWslDebian
	call dk_debugFunc 0
	
	%dk_call% dk_echo   
    call dk_info "UnInstalling WSL-Debian Linux . . ."

	wsl --terminate Debian
	wsl --unregister Debian
	taskkill /f /im wslservice.exe
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_uninstallWslDebian
%endfunction%

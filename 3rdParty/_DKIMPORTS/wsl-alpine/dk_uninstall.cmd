@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_uninstall()
::#
:dk_uninstall
	call dk_debugFunc 0
	
	%dk_call% dk_set LAUNCHER_DL "https://github.com/agowa/WSL-DistroLauncher-Alpine/releases/download/1.3.2/launcher.exe"
	%dk_call% dk_echo   
    %dk_call% dk_info "UnInstalling WSL-Alpine Linux . . ."

	wslconfig /t Alpine
	wslconfig /u Alpine
	taskkill /f /im wslservice.exe
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_delete %DKTOOLS_DIR%\AlpineLinux
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_uninstall
%endfunction%
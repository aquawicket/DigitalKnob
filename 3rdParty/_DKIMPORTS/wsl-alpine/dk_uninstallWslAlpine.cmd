@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_uninstallWslAlpine()
::#
:dk_uninstallWslAlpine
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	call dk_set LAUNCHER_DL "https://github.com/agowa/WSL-DistroLauncher-Alpine/releases/download/1.3.2/launcher.exe"
	call dk_echo   
    call dk_info "UnInstalling WSL-Alpine Linux . . ."

	wslconfig /t Alpine
	wslconfig /u Alpine
	taskkill /f /im wslservice.exe
	call dk_validate DKTOOLS_DIR "call dk_setDKTOOLS_DIR"
	call dk_delete %DKTOOLS_DIR%\AlpineLinux
goto:eof



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_uninstallWslAlpine
goto:eof

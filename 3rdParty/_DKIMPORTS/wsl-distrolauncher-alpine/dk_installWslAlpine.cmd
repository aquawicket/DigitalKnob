@echo off
call ../../../DKBatch/functions/DK.cmd

::####################################################################
::# dk_installWslAlpine()
::#
:dk_installWslAlpine () {
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_set LAUNCHER_DL "https://github.com/agowa/WSL-DistroLauncher-Alpine/releases/download/1.3.2/launcher.exe"
	call dk_echo   
    call dk_info "Installing WSL-Alpine Linux . . ."
	call dk_download %LAUNCHER_DL%
	call dk_makeDirectory %DKTOOLS_DIR%\AlpineLinux
	call dk_getFilename %LAUNCHER_DL% LAUNCHER_DL_FILE
	call dk_copy %DKDOWNLOAD_DIR%\%LAUNCHER_DL_FILE% %DKTOOLS_DIR%\AlpineLinux\%LAUNCHER_DL_FILE% OVERWRITE
	%DKTOOLS_DIR%\AlpineLinux\%LAUNCHER_DL_FILE%
goto:eof



:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	call dk_installWslAlpine

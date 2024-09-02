@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0

::####################################################################
::# dk_installWslAlpine()
::#
:dk_installWslAlpine
	call dk_debugFunc 0
	
	call dk_set LAUNCHER_DL "https://github.com/agowa/WSL-DistroLauncher-Alpine/releases/download/1.3.2/launcher.exe"
	
	call dk_echo   
    call dk_info "Installing WSL-Alpine Linux . . ."
	
	call dk_validate DKTOOLS_DIR "call dk_setDKTOOLS_DIR"
	call dk_set ALPINE_DIR "%DKTOOLS_DIR%\AlpineLinux"
	
	if exist "%LAUNCHER_DL_FILE%" goto:alpine_installed
	call dk_echo   
    call dk_info "Installing Alpine Linux . . ."
	call dk_download %LAUNCHER_DL%
	call dk_makeDirectory %DKTOOLS_DIR%\AlpineLinux
	call dk_basename %LAUNCHER_DL% LAUNCHER_DL_FILE
	call dk_copy %DKDOWNLOAD_DIR%\%LAUNCHER_DL_FILE% %ALPINE_DIR%\%LAUNCHER_DL_FILE% OVERWRITE
	%ALPINE_DIR%\%LAUNCHER_DL_FILE% config --default-user root
	%ALPINE_DIR%\%LAUNCHER_DL_FILE%
	if NOT exist "%ALPINE_DIR%\%LAUNCHER_DL_FILE%" call dk_error "cannot find ALPINE_DIR\LAUNCHER_DL_FILE:%ALPINE%\%LAUNCHER_DL_FILE%"
	:alpine_installed

goto:eof



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installWslAlpine
goto:eof

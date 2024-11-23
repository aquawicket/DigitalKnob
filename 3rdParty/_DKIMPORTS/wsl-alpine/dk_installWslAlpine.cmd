@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installWslAlpine()
::#
:dk_installWslAlpine
	call dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate WSL_EXE "call %DKIMPORTS_DIR%\wsl\dk_installWsl.cmd"
	
	
	
	%dk_call% dk_set LAUNCHER_DL "https://github.com/agowa/WSL-DistroLauncher-Alpine/releases/download/1.3.2/launcher.exe"
	
	%dk_call% dk_echo   
    %dk_call% dk_info "Installing WSL-Alpine Linux . . ."
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_set ALPINE_DIR "%DKTOOLS_DIR%\AlpineLinux"
	
	if exist "%LAUNCHER_DL_FILE%" goto alpine_installed
	%dk_call% dk_echo   
    %dk_call% dk_info "Installing Alpine Linux . . ."
	%dk_call% dk_download %LAUNCHER_DL%
	%dk_call% dk_makeDirectory %DKTOOLS_DIR%\AlpineLinux
	%dk_call% dk_basename %LAUNCHER_DL% LAUNCHER_DL_FILE
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	%dk_call% dk_copy %DKDOWNLOAD_DIR%\%LAUNCHER_DL_FILE% %ALPINE_DIR%\%LAUNCHER_DL_FILE% OVERWRITE
	%ALPINE_DIR%\%LAUNCHER_DL_FILE% config --default-user root
	%ALPINE_DIR%\%LAUNCHER_DL_FILE%
	if NOT exist "%ALPINE_DIR%\%LAUNCHER_DL_FILE%" %dk_call% dk_error "cannot find ALPINE_DIR\LAUNCHER_DL_FILE:%ALPINE%\%LAUNCHER_DL_FILE%"
	:alpine_installed

%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_installWslAlpine
%endfunction%

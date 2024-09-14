@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installMsys2()
::#
:dk_installMsys2
	call dk_debugFunc 0
	
	call dk_set MSYS2_DL "https://github.com/msys2/msys2-installer/releases/download/2024-07-27/msys2-x86_64-20240727.exe"
	
	
	call dk_basename %MSYS2_DL% MSYS2_DL_FILE
	call dk_removeExtension %MSYS2_DL_FILE% MSYS2_FOLDER
	
	call dk_validate DK3RDPARTY_DIR "call dk_validateBranch"
	call dk_set MSYS2 "%DK3RDPARTY_DIR%/%MSYS2_FOLDER%"
	
	
	if exist %MSYS2%\msys2.exe" echo "msys2 already installed" && goto:eof
	
	call dk_info "Installing %MSYS2_FOLDER%"
	call dk_download %MSYS2_DL%
	%DKDOWNLOAD_DIR%\%MSYS2_DL_FILE%" install --root "%MSYS2%" --confirm-command
	
	call dk_printVar MSYS2
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installMsys2
%endfunction%

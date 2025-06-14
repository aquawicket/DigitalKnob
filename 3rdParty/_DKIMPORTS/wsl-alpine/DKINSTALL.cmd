@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"

	::%dk_call% dk_validate WSL_EXE "%dk_call% %DKIMPORTS_DIR%/wsl/DKINSTALL.cmd"
	%dk_call% dk_depend wsl
	
	%dk_call% dk_echo  
    %dk_call% dk_info "Installing WSL-Alpine Linux . . ."
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	set "ALPINE_DIR=%DKTOOLS_DIR%/AlpineLinux"
	
	if exist "%LAUNCHER_IMPORT_FILE%" (goto alpine_installed)
	%dk_call% dk_echo  
    %dk_call% dk_info "Installing Alpine Linux . . ."
	%dk_call% dk_download "%WSL_ALPINE_IMPORT%"
	%dk_call% dk_mkdir "%ALPINE_DIR%"
	%dk_call% dk_basename "%WSL_ALPINE_IMPORT%"
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	%dk_call% dk_copy "%DKDOWNLOAD_DIR%/%dk_basename%" "%ALPINE_DIR%/%dk_basename%" OVERWRITE
	%dk_call% dk_firewallAllow AlpineLinux "%ALPINE_DIR%/%dk_basename%"

	echo %ALPINE_DIR%/%dk_basename% config --default-user root
	%ALPINE_DIR:/=\%\%dk_basename% config --default-user root
pause
	"%ALPINE_DIR%/%dk_basename%"
pause
	%dk_call% dk_assertPath "%ALPINE_DIR%/%dk_basename%"

%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%

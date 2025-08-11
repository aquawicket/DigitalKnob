@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

:: https://stackoverflow.com/a/67714373
%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
if not defined GIT_CONFIG_SYSTEM (set "GIT_CONFIG_SYSTEM=%DKCACHE_DIR%/.gitSystem")
if not defined GIT_CONFIG_GLOBAL (set "GIT_CONFIG_GLOBAL=%DKCACHE_DIR%/.gitGlobal")



::####################################################################
::# DKINSTALL
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0	
	
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	set "git_Import=!git_%Host_Tuple%_Import!"
    %dk_call% dk_assertVar git_Import
  
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	if not defined GIT (%dk_call% dk_importVariables %git_Import% Install.Dirname "%DKTOOLS_DIR%")
	%dk_call% dk_assertVar GIT
	
	:: https://stackoverflow.com/questions/15769263/how-does-git-dir-work-exactly
	::############ DO NOT USE GIT_DIR ############
	if defined GIT_DIR (%dk_call% dk_fatal "ERROR: GIT_DIR should not be set.")   &:: https://stackoverflow.com/questions/15769263/how-does-git-dir-work-exactly
	::############ DO NOT USE GIT_DIR ############
	
    set "GIT_EXE=%GIT%/bin/git.exe"
	set "GIT_BASH_EXE=%GIT%/bin/bash.exe"
    ::set "GIT-BASH_EXE=%GIT%/git-bash.exe"
	::set "GIT_PATCH_EXE=%GIT%/usr/bin/patch.exe"
    if exist "%GIT_EXE%" (%return%)
	
	::###### INSTALL ######
    %dk_call% dk_echo 
    %dk_call% dk_info "Installing git . . ."
    %dk_call% dk_download %git_Import%
	"%dk_download%" -y -o "%GIT%"
	
    ::###### Install Git Context Menu ######
    %dk_call% dk_depend git/contextMenu
	%dk_call% dk_assertPath "%GIT_EXE%"

%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% DKINSTALL
	%dk_call% dk_echo "GIT = %GIT%"
	%dk_call% dk_echo "GIT_EXE = %GIT_EXE%"
	pause
%endfunction%

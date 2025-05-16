@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"


:: https://stackoverflow.com/a/67714373
%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
if not defined GIT_CONFIG_SYSTEM (set "GIT_CONFIG_SYSTEM=!DKCACHE_DIR!\.gitSystem")
if not defined GIT_CONFIG_GLOBAL (set "GIT_CONFIG_GLOBAL=!DKCACHE_DIR!\.gitGlobal")

::####################################################################
::# DKINSTALL
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0	
	
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
    if defined Windows_Arm64_Host  (set "GIT_DL=%GIT_DL_WIN_ARM64%")
    if defined Windows_X86_Host    (set "GIT_DL=%GIT_DL_WIN_X86%")
    if defined Windows_X86_64_Host (set "GIT_DL=%GIT_DL_WIN_X86_64%")
    %dk_call% dk_assertVar GIT_DL
    
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	if not defined GIT (%dk_call% dk_importVariables %GIT_DL% NAME git ROOT %DKTOOLS_DIR%)
	
	::############ DO NOT USE GIT_DIR ############
	if defined GIT_DIR (%dk_call% dk_fatal "ERROR: GIT_DIR should not be set.")   &:: https://stackoverflow.com/questions/15769263/how-does-git-dir-work-exactly
	::############ DO NOT USE GIT_DIR ############
	
    set "GIT_EXE=%GIT%\bin\git.exe"
	set "BASH_EXE=%GIT%\bin\bash.exe"
    set "GITBASH_EXE=%GIT%\git-bash.exe"
	set "PATCH_EXE=%GIT%\usr\bin\patch.exe"
     
    if exist "%GIT_EXE%" (%return%)
    %dk_call% dk_echo   
    %dk_call% dk_info "Installing git . . ."
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
    %dk_call% dk_download %GIT_DL%
    "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" -y -o "%GIT%"
	
	::###### Install Git Context Menu ######
	"contextMenu/DKINSTALL.cmd"
       
    if NOT exist "%GIT_EXE%" (%dk_call% dk_error "cannot find git")
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    %dk_call% DKINSTALL
%endfunction%

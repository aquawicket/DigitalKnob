@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::call dk_source dk_convertToCIdentifier
::call dk_source dk_basename
::call dk_source dk_removeExtension
::call dk_source dk_toLower
::call dk_source dk_validate
::####################################################################
::# dk_uninstallGit()
::#
::#
:dk_uninstallGit
    call dk_debugFunc 0
 ::setlocal	
 
    %dk_call% dk_validate host_triple  "%dk_call% dk_host_triple"
    ::if defined win_arm32_host        set "GIT_DL="
    ::if defined win_arm64_host        set "GIT_DL="
    if defined win_x86_host            set "GIT_DL=https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-32-bit.7z.exe"
    if defined win_x86_64_host         set "GIT_DL=https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe"
    if not defined GIT_DL              %dk_call% dk_error "GIT_DL is invalid"
	
    %dk_call% dk_basename %GIT_DL% GIT_DL_FILE
    %dk_call% dk_removeExtension %GIT_DL_FILE% GIT_FOLDER
	%dk_call% dk_removeExtension %GIT_FOLDER% GIT_FOLDER
    ::%dk_call% dk_convertToCIdentifier %GIT_FOLDER% GIT_FOLDER
    %dk_call% dk_toLower %GIT_FOLDER% GIT_FOLDER
    %dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	::### DO NOT USE GIT_DIR ###
	set "GIT=%DKTOOLS_DIR%\%GIT_FOLDER%"

	::FIXME: kill git.exe process
    %dk_call% dk_delete "%GIT%"
        
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKBRANCH_DIR"
	
	::### Uninstall Context Menu ###
	call %DKIMPORTS_DIR%\git\dk_uninstallGitContextMenu.cmd

	::### Uninstall File Associations ###
	call %DKIMPORTS_DIR%\git\dk_uninstallGitFileAssociations.cmd
	
	::### Remove PATH variable
	:: TODO
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
 setlocal
	
    call dk_uninstallGit
%endfunction%

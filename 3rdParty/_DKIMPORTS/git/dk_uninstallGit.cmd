@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

call dk_source dk_convertToCIdentifier
call dk_source dk_basename
call dk_source dk_removeExtension
call dk_source dk_toLower
call dk_source dk_validate
::####################################################################
::# dk_uninstallGit()
::#
::#
:dk_uninstallGit
    call dk_debugFunc 0
	
    call dk_validate DK_HOST_ARCH "call dk_getHostTriple"
    ::if "%DK_HOST_ARCH%"=="arm32"  call dk_set GIT_DL ""
    ::if "%DK_HOST_ARCH%"=="arm64"  call dk_set GIT_DL ""
    if "%DK_HOST_ARCH%"=="x86"    call dk_set GIT_DL "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-32-bit.7z.exe"
    if "%DK_HOST_ARCH%"=="x86_64" call dk_set GIT_DL "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe"
    if not defined GIT_DL call dk_error "GIT_DL is invalid"
	
    call dk_basename %GIT_DL% GIT_DL_FILE
    call dk_removeExtension %GIT_DL_FILE% GIT_FOLDER
    ::call dk_convertToCIdentifier %GIT_FOLDER% GIT_FOLDER
    call dk_toLower %GIT_FOLDER% GIT_FOLDER
	call dk_validate DKTOOLS_DIR "call dk_setDKTOOLS_DIR"
	call dk_set GIT_DIR "%DKTOOLS_DIR%\%GIT_FOLDER%"

	::FIXME: kill git.exe process
    call dk_delete "%GIT_DIR%"
        
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	
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
	
    call dk_uninstallGit
%endfunction%

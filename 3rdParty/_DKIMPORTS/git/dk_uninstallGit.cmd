@echo off
call ..\..\..\DKBatch\functions\DK.cmd

call dk_source dk_convertToCIdentifier
call dk_source dk_getBasename
call dk_source dk_removeExtension
call dk_source dk_toLower
call dk_source dk_validate
::####################################################################
::# dk_uninstallGit()
::#
::#
:dk_uninstallGit
    call dk_debugFunc
    if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
    call dk_validate HOST_ARCH "call dk_getHostTriple"
    ::if "%HOST_ARCH%"=="arm32"  call dk_set GIT_DL ""
    ::if "%HOST_ARCH%"=="arm64"  call dk_set GIT_DL ""
    if "%HOST_ARCH%"=="x86"    call dk_set GIT_DL "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-32-bit.7z.exe"
    if "%HOST_ARCH%"=="x86_64" call dk_set GIT_DL "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe"
    if not defined GIT_DL goto:eof
	
    call dk_getBasename %GIT_DL% GIT_DL_FILE
    call dk_removeExtension %GIT_DL_FILE% GIT_DL_NAME
    call dk_convertToCIdentifier %GIT_DL_NAME% GIT_FOLDER
    call dk_toLower %GIT_FOLDER% GIT_FOLDER
    
	call dk_validate DKTOOLS_DIR "call dk_getDKPaths"
	call dk_set GIT "%DKTOOLS_DIR%\%FIT_FOLDER%"

	::FIXME: kill git.exe process
    call dk_remove "%GIT%"
        
	::### Uninstall Context Menu ###
	call %DKIMPORTS_DIR%\git\dk_uninstallGitContextMenu.cmd

	::### Uninstall File Associations ###
	call %DKIMPORTS_DIR%\git\dk_uninstallGitFileAssociations.cmd
goto:eof






::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
    call dk_uninstallGit
goto:eof
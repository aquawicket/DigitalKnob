@echo off
call ..\..\..\DKBatch\functions\DK.cmd

call dk_source dk_validate
call dk_source dk_getBasename
call dk_source dk_removeExtension
call dk_source dk_convertToCIdentifier
call dk_source dk_toLower
::####################################################################
::# dk_installGit()
::#
::#
:dk_installGit
    call dk_debugFunc
    if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
    call dk_validate HOST_ARCH "call dk_getHostTriple"
    ::if "%HOST_OS%_%HOST_ARCH%"=="win_arm64"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86"    call dk_set GIT_DL "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-32-bit.7z.exe"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64" call dk_set GIT_DL "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe"
    if not defined GIT_DL call dk_error "GIT_DL is invalid"
        
    call dk_getBasename %GIT_DL% GIT_DL_FILE
    call dk_removeExtension %GIT_DL_FILE% GIT_DL_NAME
    call dk_convertToCIdentifier %GIT_DL_NAME% GIT_FOLDER
    call dk_toLower %GIT_FOLDER% GIT_FOLDER
	
    call dk_validate DKTOOLS_DIR "call dk_getDKPaths"
	call dk_set GIT "%DKTOOLS_DIR%\%FIT_FOLDER%"
    call dk_set GIT_EXE %GIT%\bin\git.exe
	call dk_set GITBASH_EXE %GIT%\git-bash.exe
        
    if exist "%GIT_EXE%" goto:eof
        
    call dk_echo   
    call dk_info "Installing git . . ."
    call dk_download %GIT_DL%
    call dk_info "%DKDOWNLOAD_DIR%\%GIT_DL_FILE% -y -o %GIT%"
    "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" -y -o "%GIT%"
	   
    if NOT exist "%GIT_EXE%" call dk_error "cannot find git"
goto:eof






::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
    call dk_installGit
goto:eof
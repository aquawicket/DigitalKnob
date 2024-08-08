@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

call dk_source dk_validate
call dk_source dk_basename
call dk_source dk_removeExtension
call dk_source dk_convertToCIdentifier
call dk_source dk_toLower
call dk_source dk_download

call dk_set GIT_DL_WIN_X86 https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-32-bit.7z.exe
call dk_set GIT_DL_WIN_X86_64 https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe

::####################################################################
::# dk_installGit()
::#
::#
:dk_installGit
    call dk_debugFunc 0
	
    call dk_validate HOST_ARCH "call dk_getHostTriple"
    if "%HOST_ARCH%"=="arm32"  set "GIT_DL="
    if "%HOST_ARCH%"=="arm64"  set "GIT_DL=%GIT_DL_WIN_ARM64%"
    if "%HOST_ARCH%"=="x86"    set "GIT_DL=%GIT_DL_WIN_X86%"
    if "%HOST_ARCH%"=="x86_64" set "GIT_DL=%GIT_DL_WIN_X86_64%"
    if not defined GIT_DL call dk_error "GIT_DL is invalid"
	
    call dk_basename %GIT_DL% GIT_DL_FILE
    call dk_removeExtension %GIT_DL_FILE% GIT_DL_NAME
    call dk_convertToCIdentifier %GIT_DL_NAME% GIT_FOLDER
    call dk_toLower %GIT_FOLDER% GIT_FOLDER
	
    call dk_validate DKTOOLS_DIR "call dk_setDKTOOLS_DIR"
	call dk_set GIT_DIR "%DKTOOLS_DIR%\%GIT_FOLDER%"
    call dk_set GIT_EXE %GIT_DIR%\bin\git.exe
	call dk_set GITBASH_EXE %GIT_DIR%\git-bash.exe
     
    if exist "%GIT_EXE%" goto:eof
    call dk_echo   
    call dk_info "Installing git . . ."
    call dk_download %GIT_DL%
    call dk_info "%DKDOWNLOAD_DIR%\%GIT_DL_FILE% -y -o %GIT_DIR%"
    "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" -y -o "%GIT_DIR%"
	call dk_appendEvnPath %GIT_DIR%\bin
	   
    if NOT exist "%GIT_EXE%" call dk_error "cannot find git")
goto:eof



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
    call dk_installGit
goto:eof
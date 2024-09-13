@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

set "GIT_DL_WIN_X86=https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-32-bit.7z.exe"
set "GIT_DL_WIN_X86_64=https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe"
::####################################################################
::# dk_installGit()
::#
::#
:dk_installGit
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_validate DK_HOST_ARCH "%dk_call% dk_getHostTriple"
    if "%DK_HOST_ARCH%"=="arm32"  set "GIT_DL="
    if "%DK_HOST_ARCH%"=="arm64"  set "GIT_DL=%GIT_DL_WIN_ARM64%"
    if "%DK_HOST_ARCH%"=="x86"    set "GIT_DL=%GIT_DL_WIN_X86%"
    if "%DK_HOST_ARCH%"=="x86_64" set "GIT_DL=%GIT_DL_WIN_X86_64%"
    if not defined GIT_DL %dk_call% dk_error "GIT_DL is invalid"
    
    %dk_call% dk_basename %GIT_DL% GIT_DL_FILE
    %dk_call% dk_removeExtension %GIT_DL_FILE% GIT_DL_NAME
    %dk_call% dk_convertToCIdentifier %GIT_DL_NAME% GIT_FOLDER
    %dk_call% dk_toLower %GIT_FOLDER% GIT_FOLDER
    %dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_setDKTOOLS_DIR"
	set "GIT=%DKTOOLS_DIR%\%GIT_FOLDER%"
    set "GIT_EXE=%DKTOOLS_DIR%\%GIT_FOLDER%\bin\git.exe"
    set "GITBASH_EXE=%DKTOOLS_DIR%\%GIT_FOLDER%\git-bash.exe"
	set "PATCH_EXE=%DKTOOLS_DIR%\%GIT_FOLDER%\usr\bin\patch.exe"
     
    if exist "%GIT_EXE%" goto:eof
    %dk_call% dk_echo   
    %dk_call% dk_info "Installing git . . ."
    %dk_call% dk_download %GIT_DL%
    "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" -y -o "%DKTOOLS_DIR%\%GIT_FOLDER%"
       
    if NOT exist "%GIT_EXE%" %dk_call% dk_error "cannot find git")
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_installGit
%endfunction%
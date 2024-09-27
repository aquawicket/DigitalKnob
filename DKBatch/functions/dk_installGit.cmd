@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

set "GIT_DL_WIN_X86=https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-32-bit.7z.exe"
set "GIT_DL_WIN_X86_64=https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe"

:: https://stackoverflow.com/a/67714373
if not defined GIT_CONFIG_SYSTEM  set "GIT_CONFIG_SYSTEM=%DKCACHE_DIR%\.gitSystem" && setx GIT_CONFIG_SYSTEM "%GIT_CONFIG_SYSTEM%"
if not defined GIT_CONFIG_GLOBAL  set "GIT_CONFIG_GLOBAL=%DKCACHE_DIR%\.gitGlobal" && setx GIT_CONFIG_GLOBAL "%GIT_CONFIG_GLOBAL%"

::####################################################################
::# dk_installGit()
::#
::#
:dk_installGit
    call dk_debugFunc 0
:: setlocal
 
    %dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
    if defined win_arm32_host  set "GIT_DL="
    if defined win_arm64_host  set "GIT_DL=%GIT_DL_WIN_ARM64%"
    if defined win_x86_host    set "GIT_DL=%GIT_DL_WIN_X86%"
    if defined win_x86_64_host set "GIT_DL=%GIT_DL_WIN_X86_64%"
    if not defined GIT_DL %dk_call% dk_error "GIT_DL is invalid"
    
    %dk_call% dk_basename %GIT_DL% GIT_DL_FILE
    %dk_call% dk_removeExtension %GIT_DL_FILE% GIT_FOLDER
	%dk_call% dk_removeExtension %GIT_FOLDER% GIT_FOLDER
    ::%dk_call% dk_convertToCIdentifier %GIT_FOLDER% GIT_FOLDER
    %dk_call% dk_toLower %GIT_FOLDER% GIT_FOLDER
    %dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	::set "GIT_DIR=%DKTOOLS_DIR%\%GIT_FOLDER%"
	set "GIT=%DKTOOLS_DIR%\%GIT_FOLDER%"
	
    set "GIT_EXE=%DKTOOLS_DIR%\%GIT_FOLDER%\bin\git.exe"
    set "GITBASH_EXE=%DKTOOLS_DIR%\%GIT_FOLDER%\git-bash.exe"
	set "PATCH_EXE=%DKTOOLS_DIR%\%GIT_FOLDER%\usr\bin\patch.exe"
     
    if exist "%GIT_EXE%" %return%
    %dk_call% dk_echo   
    %dk_call% dk_info "Installing git . . ."
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
    %dk_call% dk_download %GIT_DL%
    "%DKDOWNLOAD_DIR%\%GIT_DL_FILE%" -y -o "%DKTOOLS_DIR%\%GIT_FOLDER%"
       
    if NOT exist "%GIT_EXE%" %dk_call% dk_error "cannot find git")
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_installGit
%endfunction%
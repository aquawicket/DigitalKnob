@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


if not exist "%DKIMPORTS_DIR%/git/DKINSTALL.cmd" (
	%dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/3rdParty/_DKIMPORTS/git/DKINSTALL.cmd"  "%DKIMPORTS_DIR%/git/DKINSTALL.cmd"
)
%dk_call% dk_depend git
exit /b 0
::#################################################################################################################















%dk_call% dk_validate DKIMPORTS_DIR	"%dk_call% dk_DKIMPORTS_DIR"
if not exist "%DKIMPORTS_DIR%/git/dkconfig.txt" (
	%dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/3rdParty/_DKIMPORTS/git/dkconfig.txt"  "%DKIMPORTS_DIR%/git/dkconfig.txt"
)
if not exist "%DKIMPORTS_DIR%/git/DKINSTALL.cmd" (
	%dk_call% dk_download "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/3rdParty/_DKIMPORTS/git/dkconfig.txt"  "%DKIMPORTS_DIR%/git/DKINSTALL.cmd"
)

%dk_call% dk_getFileParams "%DKIMPORTS_DIR%/git/dkconfig.txt"

:: https://stackoverflow.com/a/67714373
%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
if not defined GIT_CONFIG_SYSTEM  (set GIT_CONFIG_SYSTEM=%DKCACHE_DIR%/.gitSystem)
if not defined GIT_CONFIG_GLOBAL  (set GIT_CONFIG_GLOBAL=%DKCACHE_DIR%/.gitGlobal)

::####################################################################
::# dk_installGit()
::#
::#
:dk_installGit
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
    if defined Windows_Arm64_Host	(set "GIT_IMPORT=%GIT_WIN_ARM64_IMPORT%")
    if defined Windows_X86_Host		(set "GIT_IMPORT=%GIT_WIN_X86_IMPORT%")
    if defined Windows_X86_64_Host	(set "GIT_IMPORT=%GIT_WIN_X86_64_IMPORT%")
    if defined Windows_Host			(%dk_call% dk_assertVar GIT_IMPORT)
   
	::if defined GIT_IMPORT (
		%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
		%dk_call% dk_importVariables %GIT_IMPORT% NAME git ROOT %DKTOOLS_DIR%
	::)

	:: https://stackoverflow.com/questions/15769263/how-does-git-dir-work-exactly
	::###!!! DO NOT USE GIT_DIR !!!###
	if defined GIT_DIR  %dk_call% dk_fatal "ERROR: GIT_DIR should not be set."
	::###!!! DO NOT USE GIT_DIR !!!###
	
    set "GIT_EXE=%GIT%/bin/git.exe"
	::set "GIT_BASH_EXE=%GIT%/bin/bash.exe"
    ::set "GIT-BASH_EXE=%GIT%/git-bash.exe"
	::set "GIT_PATCH_EXE=%GIT%/usr/bin/patch.exe"
    %dk_call% dk_firewallAllow "git-remote-https" "%GIT%/mingw64/libexec/git-core/git-remote-https.exe"
	%dk_call% dk_firewallAllow "lsass" "%windir:\=/%/System32/lsass.exe"
	
    if exist "%GIT_EXE%" (
		%return%
	)
	
	::###### INSTALL ######
    %dk_call% dk_echo  
    %dk_call% dk_echo "Installing git . . ."
    %dk_call% dk_download %GIT_IMPORT%
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
    "%DKDOWNLOAD_DIR%/%GIT_IMPORT_FILE%" -y -o "%GIT%"

    if NOT exist "%GIT_EXE%" (
		%dk_call% dk_error "cannot find git"
	)
	
	::endlocal & (
	::	set "GIT=%GIT%"
	::	set "GIT_EXE=%GIT_EXE%"
	::)
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    %dk_call% dk_installGit
%endfunction%

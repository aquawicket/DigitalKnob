@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::# https://docs.microsoft.com/en-US/cpp/windows/latest-supported-vc-redist?view=msvc-160#visual-studio-2015-2017-2019-and-2022
::#
::# https://aka.ms/vs/16/release/vc_redist.x86.exe
::# https://softmany.com/microsoft-visual-c-redistributable-package/download/
::#
::# VCRUNTIME140.dll


::####################################################################
::# dk_installVC_Redist
::#
:dk_installVC_Redist
    call dk_debugFunc 0
	
	%dk_call% dk_validate HOST_TRIPLE "%dk_call% dk_HOST_TRIPLE"
	if "%HOST_OS%_%HOST_ARCH%"=="WIN_X86"    set "VC_REDIST_DL=https://aka.ms/vs/16/release/vc_redist.x86.exe"
	if "%HOST_OS%_%HOST_ARCH%"=="WIN_X86_64" set "VC_REDIST_DL=https://aka.ms/vs/16/release/vc_redist.x64.exe"
	if not defined VC_REDIST_DL %dk_call% dk_error "VC_REDIST_DL is invalid"

	if "%HOST_OS%_%HOST_ARCH%"=="WIN_X86"    set "VCCOMP140_DLL=C:/Windows/SysWOW64/vcomp140.dll"
	if "%HOST_OS%_%HOST_ARCH%"=="WIN_X86_64" set "VCCOMP140_DLL=C:/Windows/System32/vcomp140.dll"
	if not defined VCCOMP140_DLL %dk_call% dk_error "VCCOMP140_DLL is invalid"
pause
	if exist "%VCCOMP140_DLL%" goto:eof
pause
	::### INSTALL ###
	%dk_call% dk_basename %VC_REDIST_DL% VC_REDIST_DL_FILE
	%dk_call% dk_info "Installing Visual C Redistributable - %VC_REDIST_DL_FILE%"
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_getDKPaths"
	%dk_call% dk_download %VC_REDIST_DL% %DKDOWNLOAD_DIR%/%VC_REDIST_DL_FILE%
	%dk_call% dk_command %DKDOWNLOAD_DIR%/%VC_REDIST_DL_FILE% /install /quiet /norestart 
	
	if not exist %VCCOMP140_DLL% dk_error "Unable to locate VCCOMP140_DLL:%VCCOMP140_DLL%"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_installVC_Redist
%endfunction%
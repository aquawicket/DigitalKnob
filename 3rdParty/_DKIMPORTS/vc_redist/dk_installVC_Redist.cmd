@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

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
    call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	call dk_validate HOST_OS "call dk_getHostTriple"
	if "%HOST_OS%_%HOST_ARCH%"=="win_x86"    set="VC_REDIST_DL=https://aka.ms/vs/16/release/vc_redist.x86.exe"
	if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64" set="VC_REDIST_DL=https://aka.ms/vs/16/release/vc_redist.x64.exe"
	if not defined VC_REDIST_DL call dk_error "VC_REDIST_DL is invalid"


	if "%HOST_OS%_%HOST_ARCH%"=="win_x86"    set="VCCOMP140_DLL="C:/Windows/SysWOW64/vcomp140.dll"
	if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64" set="VCCOMP140_DLL "C:/Windows/System32/vcomp140.dll"
	if not defined VCCOMP140_DLL call dk_error "VCCOMP140_DLL is invalid"

	if exist "%VCCOMP140_DLL%" goto:eof
	
	::### INSTALL ###
	call dk_getBasename %VC_REDIST_DL% VC_REDIST_DL_FILE
	call dk_info "Installing Visual C Redistributable - %VC_REDIST_DL_FILE%"
	if not defined DKDOWNLOAD_DIR call dk_getDKPaths
	call dk_download %VC_REDIST_DL% %DKDOWNLOAD_DIR%/%VC_REDIST_DL_FILE%
	call dk_command %DKDOWNLOAD_DIR%/%VC_REDIST_DL_FILE% /install /quiet /norestart 
	
	if not exist %VCCOMP140_DLL% dk_error "Unable to locate VCCOMP140_DLL:%VCCOMP140_DLL%"
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_installVC_Redist
goto:eof
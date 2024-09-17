@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installPowershell()
::#
:dk_installPowershell
	call dk_debugFunc 0
::setlocal
	
	call dk_validate DK_HOST_OS "call dk_getHostTriple"
	if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_arm64"   call dk_set POWERSHELL_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-arm64.zip"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_x86"     call dk_set POWERSHELL_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x86.zip"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_x86_64"  call dk_set POWERSHELL_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x64.zip"
	if not defined POWERSHELL_DL call dk_error "POWERSHELL_DL is invalid"
	
	::::::::: POWERSHELL_DL -> TO -> POWERSHELL_DIR :::::::::::::
	call dk_basename %POWERSHELL_DL% POWERSHELL_DL_FILE
	call dk_removeExtension %POWERSHELL_DL_FILE% POWERSHELL_FOLDER
	::call dk_convertToCIdentifier %POWERSHELL_FOLDER% POWERSHELL_FOLDER
	call dk_toLower %POWERSHELL_FOLDER% POWERSHELL_FOLDER
	call dk_validate DKTOOLS_DIR "call dk_setDKTOOLS_DIR"
	call dk_set POWERSHELL_DIR "%DKTOOLS_DIR%\%POWERSHELL_FOLDER%"
	:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	call dk_set POWERSHELL_EXE "%POWERSHELL_DIR%\pwsh.exe"
	
	if exist "%POWERSHELL_EXE%" goto:powershell_installed
		call dk_echo   
		call dk_info "Installing powershell . . ."
		call dk_download %POWERSHELL_DL%
		call dk_smartExtract "%DKDOWNLOAD_DIR%\%POWERSHELL_DL_FILE%" "%POWERSHELL_DIR%"
		if NOT exist "%POWERSHELL_EXE%" call dk_error "cannot find pwsh.exe"
	:powershell_installed
	
	
	::### Add File Associations ###
	::call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	::call "%DKIMPORTS_DIR%\powershell\dk_installPowershellFileAssociations.cmd"
	
:: install via CMake
::	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
::	call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/powershell/DKMAKE.cmake')" "POWERSHELL_EXE"
::	call dk_printVar POWERSHELL_EXE

	::call dk_checkError
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0

	call dk_installPowershell
%endfunction%


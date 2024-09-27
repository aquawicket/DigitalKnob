@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installPowershell()
::#
:dk_installPowershell
	call dk_debugFunc 0
::setlocal
	
	%dk_call% dk_validate HOST_TRIPLE "%dk_call% dk_HOST_TRIPLE"
	if "%HOST_OS%_%HOST_ARCH%"=="WIN_ARM64"   %dk_call% dk_set POWERSHELL_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-arm64.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="WIN_X86"     %dk_call% dk_set POWERSHELL_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x86.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="WIN_X86_64"  %dk_call% dk_set POWERSHELL_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x64.zip"
	if not defined POWERSHELL_DL %dk_call% dk_error "POWERSHELL_DL is invalid"
	
	::::::::: POWERSHELL_DL -> TO -> POWERSHELL_DIR :::::::::::::
	%dk_call% dk_basename %POWERSHELL_DL% POWERSHELL_DL_FILE
	%dk_call% dk_removeExtension %POWERSHELL_DL_FILE% POWERSHELL_FOLDER
	::%dk_call% dk_convertToCIdentifier %POWERSHELL_FOLDER% POWERSHELL_FOLDER
	%dk_call% dk_toLower %POWERSHELL_FOLDER% POWERSHELL_FOLDER
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_set POWERSHELL_DIR "%DKTOOLS_DIR%\%POWERSHELL_FOLDER%"
	:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	%dk_call% dk_set POWERSHELL_EXE "%POWERSHELL_DIR%\pwsh.exe"
	
	if exist "%POWERSHELL_EXE%" goto:powershell_installed
		%dk_call% dk_echo   
		%dk_call% dk_info "Installing powershell . . ."
		%dk_call% dk_download %POWERSHELL_DL%
		%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
		%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
		%dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%\%POWERSHELL_DL_FILE%" "%POWERSHELL_DIR%"
		if NOT exist "%POWERSHELL_EXE%" %dk_call% dk_error "cannot find pwsh.exe"
	:powershell_installed
	
	
	::### Add File Associations ###
	::%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_validateBranch"
	::%dk_call% "%DKIMPORTS_DIR%\powershell\dk_installPowershellFileAssociations.cmd"
	
:: install via CMake
::	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_validateBranch"
::	%dk_call% dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/powershell/DKMAKE.cmake')" "POWERSHELL_EXE"
::	%dk_call% dk_printVar POWERSHELL_EXE

	::%dk_call% dk_checkError
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	%dk_call% dk_debugFunc 0

	call dk_installPowershell
%endfunction%


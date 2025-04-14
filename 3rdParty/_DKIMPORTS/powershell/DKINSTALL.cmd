@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%../../../DKBatch/functions/")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
	%dk_call% dk_debugFunc 0
::setlocal
	
	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
	if defined win_arm64_host   	(set "POWERSHELL_DL=https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-arm64.zip")
    if defined win_x86_host    	 	(set "POWERSHELL_DL=https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x86.zip")
    if defined win_x86_64_host		(set "POWERSHELL_DL=https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x64.zip")
	if not defined POWERSHELL_DL 	(%dk_call% dk_error "POWERSHELL_DL is invalid")
	
	::###### POWERSHELL_DL -> TO -> POWERSHELL_DIR ######
	%dk_call% dk_basename %POWERSHELL_DL% POWERSHELL_DL_FILE
	%dk_call% dk_removeExtension %POWERSHELL_DL_FILE% POWERSHELL_FOLDER
	::%dk_call% dk_convertToCIdentifier %POWERSHELL_FOLDER% POWERSHELL_FOLDER
	%dk_call% dk_toLower %POWERSHELL_FOLDER% POWERSHELL_FOLDER
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_set POWERSHELL_DIR "%DKTOOLS_DIR%/%POWERSHELL_FOLDER%"
	::###################################################
	%dk_call% dk_set POWERSHELL_EXE "%POWERSHELL_DIR%\/pwsh.exe"
	
	if exist "%POWERSHELL_EXE%" (goto powershell_installed)
		%dk_call% dk_echo   
		%dk_call% dk_info "Installing powershell . . ."
		%dk_call% dk_download %POWERSHELL_DL%
		%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
		%dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%/%POWERSHELL_DL_FILE%" "%POWERSHELL_DIR%"
		if NOT exist "%POWERSHELL_EXE%" (%dk_call% dk_error "cannot find pwsh.exe")
	:powershell_installed
	
	::### Add File Associations ###
	::%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	::%dk_call% "%DKIMPORTS_DIR%/powershell/fileAssoc/DKINSTALL.cmd"
	
:: install via CMake
::	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
::	%dk_call% dk_cmakeEval "dk_load(%DKIMPORTS_DIR%/powershell/DKINSTALL.cmake)" "POWERSHELL_EXE"

	::%dk_call% dk_checkError
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% DKINSTALL
%endfunction%


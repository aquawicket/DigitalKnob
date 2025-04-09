@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../../../DKBatch/functions/")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
	%dk_call% dk_debugFunc 0
 ::setlocal

	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
    if defined linux_arm64_host       (set "NODEJS_DL=https://nodejs.org/dist/v19.8.1/node-v19.8.1-linux-arm64.tar.gz")
    if defined linux_x86_64_host      (set "NODEJS_DL=https://nodejs.org/dist/v19.8.1/node-v19.8.1-linux-x64.tar.gz")
    if defined mac_arm64_host         (set "NODEJS_DL=https://nodejs.org/dist/v19.8.1/node-v19.8.1-darwin-arm64.tar.gz")
	if defined mac_x86_64_host        (set "NODEJS_DL=https://nodejs.org/dist/v19.8.1/node-v19.8.1-darwin-x64.tar.gz")
    if defined win_x86_host           (set "NODEJS_DL=https://nodejs.org/dist/v19.8.1/node-v19.8.1-win-x86.zip")
    if defined win_x86_64_host        (set "NODEJS_DL=https://nodejs.org/dist/v19.8.1/node-v19.8.1-win-x64.zip")
    if not defined NODEJS_DL          (%dk_call% dk_error "NODEJS_DL is invalid")
	
    %dk_call% dk_basename %NODEJS_DL% NODEJS_DL_FILE
	%dk_call% dk_removeExtension %NODEJS_DL_FILE% NODEJS_FOLDER
    ::%dk_call% dk_convertToCIdentifier %NODEJS_FOLDER% NODEJS_FOLDER
    %dk_call% dk_toLower %NODEJS_FOLDER% NODEJS_FOLDER
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_set NODEJS_DIR %DKTOOLS_DIR%\%NODEJS_FOLDER%
	
    %dk_call% dk_set NODEJS_EXE "%NODEJS_DIR%\node.exe"
        
    if exist "%NODEJS_EXE%" (goto installed)
        %dk_call% dk_info " "
        %dk_call% dk_info "Installing NodeJS . . ."
        %dk_call% dk_download "%NODEJS_DL%"
	    %dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	    %dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%\%NODEJS_DL_FILE%" "%NODEJS_DIR%"
        if NOT exist "%NODEJS_EXE%" (%dk_call% dk_error "cannot find NODEJS_EXE:%NODEJS_EXE%")
	:installed		
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
 
	%dk_call% DKINSTALL
%endfunction%

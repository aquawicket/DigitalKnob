@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_install
::#
:dk_install
    %dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
	if defined win_x86_host           set "PYTHON3_DL=https://www.python.org/ftp/python/3.11.8/python-3.11.8-embed-win32.zip"
	if defined win_x86_64_host        set "PYTHON3_DL=https://www.python.org/ftp/python/3.11.8/python-3.11.8-embed-win32.zip"
	if not defined PYTHON3_DL         %dk_call% dk_error "PYTHON3_DL is invalid"
	
	::%dk_call% dk_basename %PYTHON3_DL% PYTHON3_DL_FILE
    ::%dk_call% dk_removeExtension %PYTHON3_DL_FILE% PYTHON3_FOLDER
    ::%dk_call% dk_toLower %PYTHON3_FOLDER% PYTHON3_FOLDER
	%dk_call% dk_importVariables %PYTHON3_DL% rtn_var
	
	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
	%dk_call% dk_set PYTHON3 "%DK3RDPARTY_DIR%\%PYTHON3_FOLDER%"
	%dk_call% dk_set PYTHON3_EXE "%PYTHON3%\python3.exe"

	if exist "%PYTHON3_EXE%" %return%
	
	%dk_call% dk_download "%PYTHON3_DL%"
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	%dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%\%PYTHON3_DL_FILE%" "%PYTHON3%"
	
	if NOT exist "%PYTHON3_EXE%"  %dk_call% dk_error "cannot find PYTHON3_EXE:%PYTHON3_EXE%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_install
%endfunction%
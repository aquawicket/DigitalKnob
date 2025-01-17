@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_install
::#
:dk_install
    %dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
	if defined ANDROID_HOST           set "PYTHON3_IMPORT=python"
	if defined WIN_X86_HOST           set "PYTHON3_IMPORT=https://www.python.org/ftp/python/3.11.8/python-3.11.8-embed-win32.zip"
	if defined WIN_X86_64_HOST        set "PYTHON3_IMPORT=https://www.python.org/ftp/python/3.11.8/python-3.11.8-embed-win32.zip"
	if not defined PYTHON3_IMPORT     set "PYTHON3_IMPORT=python3"
	
	%dk_call% dk_isUrl %PYTHON3_IMPORT% && (
		%dk_call% dk_importVariables %PYTHON3_IMPORT% rtn_var
	)
	
	%dk_call% dk_set PYTHON3_EXE "%PYTHON3%\python3.exe"
	if exist "%PYTHON3_EXE%" %return%
	
	::install
	%dk_call% dk_download "%PYTHON3_IMPORT%"
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	%dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%\%PYTHON3_IMPORT_FILE%" "%PYTHON3%"
	
	if NOT exist "%PYTHON3_EXE%"  %dk_call% dk_error "cannot find PYTHON3_EXE:%PYTHON3_EXE%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_install
%endfunction%
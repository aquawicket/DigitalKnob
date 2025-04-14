@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%../../../DKBatch/functions/")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# DKINSTALL
::#
:DKINSTALL
::setlocal
    %dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_getFileParam "%~dp0/dkconfig.txt" PYTHON3_MAC_X86_64_IMPORT
	%dk_call% dk_getFileParam "%~dp0/dkconfig.txt" PYTHON3_WIN_ARM64_IMPORT
	%dk_call% dk_getFileParam "%~dp0/dkconfig.txt" PYTHON3_WIN_X86_64_IMPORT
	%dk_call% dk_getFileParam "%~dp0/dkconfig.txt" PYTHON3_WIN_X86_IMPORT
	
	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
	if defined MAC_X86_HOST           (set "PYTHON3_IMPORT=%PYTHON3_MAC_X86_64_IMPORT%")
	if defined WIN_ARM64_HOST         (set "PYTHON3_IMPORT=%PYTHON3_WIN_ARM64_IMPORT%")
	if defined WIN_X86_HOST           (set "PYTHON3_IMPORT=%PYTHON3_WIN_X86_IMPORT%")
	if defined WIN_X86_64_HOST        (set "PYTHON3_IMPORT=%PYTHON3_WIN_X86_64_IMPORT%")
::	if not defined PYTHON3_IMPORT     (set "PYTHON3_IMPORT=python3")
	
	::%dk_call% dk_isUrl %PYTHON3_IMPORT% && (
		%dk_call% dk_importVariables "%PYTHON3_IMPORT%" IMPORT_PATH %~dp0
	::)
	set "PYTHON3_EXE=%PYTHON3%/python.exe"
	if exist "%PYTHON3_EXE%" (%return%)
	
	::install
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	%dk_call% dk_basename "%PYTHON3_IMPORT%" PYTHON3_IMPORT_FILE
	%dk_call% dk_download "%PYTHON3_IMPORT%" "%DKDOWNLOAD_DIR%/%PYTHON3_IMPORT_FILE%"
	%dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%/%PYTHON3_IMPORT_FILE%" "%PYTHON3%"
	
	%dk_call% dk_assertPath "%PYTHON3_EXE%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	setlocal
	%dk_call% dk_debugFunc 0
	
	call :DKINSTALL
%endfunction%
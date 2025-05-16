@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# DKINSTALL
::#
:DKINSTALL
::%setlocal%
    %dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"
	
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	if defined Mac_X86_Host           (set "PYTHON3_IMPORT=%PYTHON3_MAC_X86_64_IMPORT%")
	if defined Win_Arm64_Host         (set "PYTHON3_IMPORT=%PYTHON3_WIN_ARM64_IMPORT%")
	if defined Win_X86_Host           (set "PYTHON3_IMPORT=%PYTHON3_WIN_X86_IMPORT%")
	if defined Win_X86_64_Host        (set "PYTHON3_IMPORT=%PYTHON3_WIN_X86_64_IMPORT%")
	if defined Linux_X86_64_Host      (set "PYTHON3_IMPORT=%PYTHON3_LINUX_X86_64_IMPORT%")
::	if not defined PYTHON3_IMPORT     (set "PYTHON3_IMPORT=python3")
	
	::%dk_call% dk_isUrl %PYTHON3_IMPORT% && (
		%dk_call% dk_importVariables "%PYTHON3_IMPORT%" IMPORT_PATH %~dp0
	::)
	set "PYTHON3_EXE=%PYTHON3%/python.exe"
	if exist "%PYTHON3_EXE%" (%return%)
	
	::INSTALL
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	%dk_call% dk_basename "%PYTHON3_IMPORT%" PYTHON3_IMPORT_FILE
	%dk_call% dk_download "%PYTHON3_IMPORT%" "%DKDOWNLOAD_DIR%/%PYTHON3_IMPORT_FILE%"
	%dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%/%PYTHON3_IMPORT_FILE%" "%PYTHON3%"
	
	%dk_call% dk_assertPath "%PYTHON3_EXE%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%
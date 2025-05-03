@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# DKUNINSTALL
::#
:DKUNINSTALL
%setlocal%
    %dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"
	
	%dk_call% dk_validate Host_Triple "%dk_call% dk_Host_Triple"
	if defined MAC_X86_HOST           (set "PYTHON3_IMPORT=%PYTHON3_MAC_X86_64_IMPORT%")
	if defined WIN_ARM64_HOST         (set "PYTHON3_IMPORT=%PYTHON3_WIN_ARM64_IMPORT%")
	if defined WIN_X86_HOST           (set "PYTHON3_IMPORT=%PYTHON3_WIN_X86_IMPORT%")
	if defined WIN_X86_64_HOST        (set "PYTHON3_IMPORT=%PYTHON3_WIN_X86_64_IMPORT%")
	if defined LINUX_X86_64_HOST      (set "PYTHON3_IMPORT=%PYTHON3_LINUX_X86_64_IMPORT%")
::	if not defined PYTHON3_IMPORT     (set "PYTHON3_IMPORT=python3")
	
	::%dk_call% dk_isUrl %PYTHON3_IMPORT% && (
		%dk_call% dk_importVariables "%PYTHON3_IMPORT%" IMPORT_PATH %~dp0
	::)

	:: UNINSTALL
	%dk_call% dk_delete "%PYTHON3%"
	
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKUNINSTALL
%endfunction%
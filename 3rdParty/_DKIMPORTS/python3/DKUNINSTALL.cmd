@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKUNINSTALL
::#
:DKUNINSTALL
%setlocal%
    %dk_call% dk_debugFunc 0
	
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	
	set "PYTHON3_IMPORT=!Python3_%Host_Tuple%_Import!"
::	if NOT defined PYTHON3_IMPORT	(set "PYTHON3_IMPORT=python3")
	
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
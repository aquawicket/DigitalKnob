@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL
::#
:DKINSTALL
::%setlocal%
    %dk_call% dk_debugFunc 0
	
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"

	::%dk_call% dk_isUrl %PYTHON3_IMPORT% && (
		%dk_call% dk_importVariables "!Python3_%Host_Tuple%_Import!"
		%dk_call% dk_assertVar PYTHON3
	::)
	
	set "PYTHON3_EXE=%PYTHON3%/python.exe"
	if exist "%PYTHON3_EXE%" (%return%)
	
	::### INSTALL ###
	%dk_call% dk_download "%PYTHON3.URL%"
	%dk_call% dk_smartExtract "%dk_download%" "%PYTHON3%"
	%dk_call% dk_assertPath "%PYTHON3_EXE%"
%endfunction%

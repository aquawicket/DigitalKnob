@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_getFileParam(file, var_name) value
::#
::# todo: add optional 3rd parameter for output value
:dk_getFileParamB
setlocal
    %dk_call% dk_debugFunc 2
	
    
	set "_file_=%~1"
	set "_file_=%_file_:/=\%"
	for /f "delims== tokens=1,2" %%A in (%_file_%) do (
		rem echo %%A = %%B
		if "%%A" == "%~2" endlocal & set %~2=%%B
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0


	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
    %dk_call% dk_getFileParam %DKIMPORTS_DIR%/git/dkconfig.txt VERSION
	%dk_call% dk_printVar VERSION
	
%endfunction%

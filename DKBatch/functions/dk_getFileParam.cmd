@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_getFileParam(file, var_name) value
::#
::# todo: add optional 3rd parameter for output value
:dk_getFileParam
    call dk_debugFunc 2
 setlocal
    
	for /f "delims== tokens=1,2" %%A in (%~1) do (
		rem echo %%A = %%B
		if "%%A" == "%~2" endlocal & set %~2=%%B
	)
	
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKBRANCH_DIR"
    %dk_call% dk_getFileParam %DKIMPORTS_DIR%\git\git.txt VERSION
	%dk_call% dk_printVar VERSION
	
%endfunction%

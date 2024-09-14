@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*

::####################################################################
::# dk_setDKTEMP_DIR()
::#
::#
:dk_setDKTEMP_DIR
    call dk_debugFunc 0
:: setlocal

	if defined DKTEMP_DIR %return%
	
    ::if defined DKTEMP_DIR %dk_call% dk_warning "DKTEMP_DIR already set to %DKTEMP_DIR%" && goto:eof
    ::%dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_setDIGITALKNOB_DIR"
    ::set "DKTEMP_DIR=%DIGITALKNOB_DIR%\temp"
    ::if not exist "%DKTEMP_DIR%" %dk_call% dk_makeDirectory "%DKTEMP_DIR%"
	
	if not defined TMP %dk_call% dk_fatal "Windows TMP variable is not set"
	if not exist %TMP% %dk_call% dk_fatal "TMP:%TMP% does not exist"
	set "DKTEMP_DIR=%TMP%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_setDKTEMP_DIR
    %dk_call% dk_printVar DKTEMP_DIR
%endfunction%

@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_setDKTEMP_DIR()
::#
::#
:dk_setDKTEMP_DIR
    call dk_debugFunc 0
:: setlocal

	if defined DKTEMP_DIR %return%
	
    if NOT exist "%DKTEMP_DIR%"    %dk_call% dk_set DKTEMP_DIR "%TMP%"
	if NOT exist "%DKTEMP_DIR%"    %dk_call% dk_set DKTEMP_DIR "%TMPDIR%"
	if NOT exist "%DKTEMP_DIR%"    %dk_call% dk_set DKTEMP_DIR "%TMP_DIR%"
	if NOT exist "%DKTEMP_DIR%"    %dk_call% dk_validate DIGITALKNOB_DIR "dk_setDIGITALKNOB_DIR" & %dk_call% dk_set DKTEMP_DIR "%DIGITALKNOB_DIR%"
	if NOT exist "%DKTEMP_DIR%"    %dk_call% dk_fatal "unable to set .dk directory"
	
	dk_set DKTEMP_DIR "%DKTEMP_DIR%\.dk"
	dk_makeDirectory "%DKTEMP_DIR%"
	
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_setDKTEMP_DIR
    %dk_call% dk_printVar DKTEMP_DIR
%endfunction%

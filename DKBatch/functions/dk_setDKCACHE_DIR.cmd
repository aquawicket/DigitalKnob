@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_setDKCACHE_DIR()
::#
::#
:dk_setDKCACHE_DIR
    call dk_debugFunc 0
:: setlocal

	if defined DKCACHE_DIR %return%
	
	%dk_call% dk_validate DKHOME_DIR "dk_setDKHOME_DIR"
	%dk_call% dk_set DKCACHE_DIR "%DKHOME_DIR%\.dk"
	%dk_call% dk_makeDirectory "%DKCACHE_DIR%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_setDKCACHE_DIR
    %dk_call% dk_printVar DKCACHE_DIR
%endfunction%

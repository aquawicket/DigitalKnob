@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_DKBASH_DIR()
::#
::#
:dk_DKBASH_DIR
    call dk_debugFunc 0
 ::setlocal
   
    if defined DKBASH_DIR %return%
    
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    set "DKBASH_DIR=%DKBRANCH_DIR%\DKBash"
	set "DKBASH_FUNCTIONS_DIR=%DKBASH_DIR%\functions"
	set "DKBASH_FUNCTIONS_DIR_=%DKBASH_DIR%\functions\"
    ::if not exist "%DKBASH_DIR%" %dk_call% dk_makeDirectory "%DKBASH_DIR%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_DKBASH_DIR
    %dk_call% dk_printVar DKBASH_DIR
%endfunction%

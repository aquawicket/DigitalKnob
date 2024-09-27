@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_DKC_DIR()
::#
::#
:dk_DKC_DIR
    call dk_debugFunc 0
 ::setlocal
   
    if defined DKC_DIR %return%
    
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    set "DKC_DIR=%DKBRANCH_DIR%\DKC"
	set "DKC_FUNCTIONS_DIR=%DKC_DIR%\functions"
	set "DKC_FUNCTIONS_DIR_=%DKC_DIR%\functions\"
    ::if not exist "%DKC_DIR%" %dk_call% dk_makeDirectory "%DKC_DIR%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_DKC_DIR
    %dk_call% dk_printVar DKC_DIR
%endfunction%

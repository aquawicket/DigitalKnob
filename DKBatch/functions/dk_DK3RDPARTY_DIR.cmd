@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_DK3RDPARTY_DIR()
::#
::#
:dk_DK3RDPARTY_DIR
    call dk_debugFunc 0
:: setlocal
   
    if defined DK3RDPARTY_DIR %return%
    
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    set "DK3RDPARTY_DIR=%DKBRANCH_DIR%\3rdParty"
    ::if not exist "%DK3RDPARTY_DIR%" %dk_call% dk_makeDirectory "%DK3RDPARTY_DIR%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_DK3RDPARTY_DIR
    %dk_call% dk_printVar DK3RDPARTY_DIR
%endfunction%

@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_DKIMPORTS_DIR()
::#
::#
:dk_DKIMPORTS_DIR
    call dk_debugFunc 0
:: setlocal
   
    if defined DKIMPORTS_DIR %return%
    
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    set "DKIMPORTS_DIR=%DKBRANCH_DIR%\3rdParty\_DKIMPORTS"
    ::if not exist "%DKIMPORTS_DIR%" %dk_call% dk_makeDirectory "%DKIMPORTS_DIR%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_DKIMPORTS_DIR
    %dk_call% dk_printVar DKIMPORTS_DIR
%endfunction%

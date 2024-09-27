@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_DKPOWERSHELL_DIR()
::#
::#
:dk_DKPOWERSHELL_DIR
    call dk_debugFunc 0
 ::setlocal
   
    if defined DKPOWERSHELL_DIR %return%
    
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    set "DKPOWERSHELL_DIR=%DKBRANCH_DIR%\DKPowershell"
	set "DKPOWERSHELL_FUNCTIONS_DIR=%DKPOWERSHELL_DIR%\functions"
	set "DKPOWERSHELL_FUNCTIONS_DIR_=%DKPOWERSHELL_DIR%\functions\"
    ::if not exist "%DKPOWERSHELL_DIR%" %dk_call% dk_makeDirectory "%DKPOWERSHELL_DIR%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_DKPOWERSHELL_DIR
    %dk_call% dk_printVar DKPOWERSHELL_DIR
%endfunction%

@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_callPowershell(function, arguments..., return_args...)
::#
::#
:dk_callPowershell
 setlocal
    call dk_debugFunc 1 99
    ::call dk_validateArgs PSFunction array array
    
    %dk_call% dk_validate DKPOWERSHELL_FUNCTIONS_DIR "%dk_call% dk_validateBranch"
    
    :: https://stackoverflow.com/a/4732316/688352
    %dk_call% %ComSpec% /c powershell Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    
    ::for /f "usebackq delims=" %%Z in (`powershell . %DKPOWERSHELL_FUNCTIONS_DIR%\%~1.ps1; %~1 "%~2"`) do echo %%Z
    echo "%DKPOWERSHELL_FUNCTIONS_DIR%\%~1.ps1"
    for /f "usebackq delims=" %%Z in (`set "DKPOWERSHELL_FUNCTIONS_DIR=%DKPOWERSHELL_FUNCTIONS_DIR%" ^& powershell %DKPOWERSHELL_FUNCTIONS_DIR%\%~1.ps1 %~1 "%~2"`) do echo %%Z
    ::%dk_call% dk_echo "PSValue received from Powershell : %PSValue%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_callPowershell dk_debug "string from DKBatch"
    ::%dk_call% dk_callPowershell dk_debug "string from DKBatch" rtnVar
%endfunction%

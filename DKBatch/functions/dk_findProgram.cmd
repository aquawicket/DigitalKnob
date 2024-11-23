@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::dk_findProgram (<VAR> name [path1 path2 ...])
::#
::#
:dk_findProgram
    call dk_debugFunc 2 9 
 setlocal
 
    set "VAR=%~1"
    set "VAL=!%VAR%!"
    if exist "%VAL%" %dk_call% dk_debug "already FOUND %name% at %VAL%" && %return%
    
    set "name=%~2"
    if "%~3" equ "" set "pattern=" && set "recursive="
    if "%~3" neq "" set "pattern=%~3" && set "recursive=/R" 
    
	%dk_call% dk_commandToVariable "where" "%recursive% %pattern% %name%" value %NO_STDERR%
    ::if not defined value %dk_call% dk_notice "%~2 not found"
    endlocal & set "%1=%value%"

::DEBUG
::	%dk_call% printVar %1
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_findProgram POWERSHELL_EXE "powershell.exe"
    %dk_call% dk_printVar POWERSHELL_EXE
    
    %dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
    %dk_call% dk_findProgram POWERSHELL_EXE "pwsh.exe" "%DKTOOLS_DIR%"
%endfunction%

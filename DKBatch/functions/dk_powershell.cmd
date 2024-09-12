@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_powershell(commands)
::#
::#
:dk_powershell
    if defined dk_powershell (echo dk_powershell blocked && goto:eof) else (set "dk_powershell=1")   &::disallow recursion for this function
    call dk_debugFunc 0 99
 setlocal
 
    "%POWERSHELL_EXE%" /? %NO_STD% && goto:found
    
    :: try pwsh.exe
    %dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_setDKTOOLS_DIR"
    %dk_call% dk_findProgram POWERSHELL_EXE "pwsh.exe" "%DKTOOLS_DIR%"
    "%POWERSHELL_EXE%" /? %NO_STD% && goto:found
    
    :: try powershell.exe
    %dk_call% dk_findProgram POWERSHELL_EXE "powershell.exe"
    "%POWERSHELL_EXE%" /? %NO_STD% && goto:found

    :: install pwsh.exe and try again
    %dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_validateBranch"
    if not exist %DKIMPORTS_DIR% %dk_call% dk_notice "DKIMPORTS not found" & exit /b 1
    call "%DKIMPORTS_DIR%\powershell\dk_installPowershell.cmd"
    %dk_call% dk_findProgram POWERSHELL_EXE "pwsh.exe" "%DKTOOLS_DIR%"
    "%POWERSHELL_EXE%" /? %NO_STD% && goto:found
    
    
    :notfound
    %dk_call% dk_error "POWERSHELL_EXE command invalid"
    %return%
    
    
    :found
    if "%~1"=="" goto:eof
    %dk_call% dk_printVar POWERSHELL_EXE

::	echo %POWERSHELL_EXE% -Command %*"
::pause
    "%POWERSHELL_EXE%" -Command %*
    
    set "dk_powershell="  &::function complete, remove recursion block
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_powershell "$PSVAR='this is a powershell variable'; Write-Output 'testing dk_powershell(): ${PSVAR}'"
%endfunction%

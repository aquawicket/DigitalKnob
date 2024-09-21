@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_powershell(commands)
::#
::#
:dk_powershell
    if defined dk_powershell (echo dk_powershell blocked && %return%) else (set "dk_powershell=1")   &::disallow recursion for this function
    call dk_debugFunc 0 99
 setlocal

	%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_setPOWERSHELL_EXE"
	%dk_call% dk_assert POWERSHELL_EXE
    
::    :: try pwsh.exe
::    %dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_setDKTOOLS_DIR"
::    %dk_call% dk_findProgram POWERSHELL_EXE "pwsh.exe" "%DKTOOLS_DIR%"
::	if defined POWERSHELL_EXE "%POWERSHELL_EXE%" /? %NO_STD% && goto:found	
    
::    :: try powershell.exe
::    %dk_call% dk_findProgram POWERSHELL_EXE "powershell.exe"
::    if defined POWERSHELL_EXE "%POWERSHELL_EXE%" /? %NO_STD% && goto:found

::    :: install pwsh.exe and try again
::    %dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_validateBranch"
::    if not exist "%DKIMPORTS_DIR%" %dk_call% dk_notice "DKIMPORTS not found" && exit /b 1
::    call "%DKIMPORTS_DIR%\powershell\dk_installPowershell.cmd"
::    %dk_call% dk_findProgram POWERSHELL_EXE "pwsh.exe" "%DKTOOLS_DIR%"
::    if defined POWERSHELL_EXE "%POWERSHELL_EXE%" /? %NO_STD% && goto:found
    
::    :notfound
::    %dk_call% dk_fatal "POWERSHELL_EXE invalid"
::    %return%
      
::   :found
    if "%~1"=="" %return%
    %dk_call% dk_printVar POWERSHELL_EXE
    "%POWERSHELL_EXE%" -Command %*
    
	::function complete, remove recursion block
    set "dk_powershell="
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
	%dk_call% dk_powershell "Write-Output 'testing dk_powershell'"
    ::%dk_call% dk_powershell "$PSVAR='this is a powershell variable'; Write-Output 'testing dk_powershell(): ${PSVAR}'"
%endfunction%

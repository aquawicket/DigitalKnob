@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_POWERSHELL_EXE()
::#
::#
:dk_POWERSHELL_EXE
    call dk_debugFunc 0
:: setlocal
   
    if defined POWERSHELL_EXE %return%
    
	:: try pwsh.exe
    %dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DIGITALKNOB_DIR"
    %dk_call% dk_findProgram POWERSHELL_EXE "pwsh.exe" "%DKTOOLS_DIR%"
	if defined POWERSHELL_EXE %return%
    
    :: try powershell.exe
    %dk_call% dk_findProgram POWERSHELL_EXE "powershell.exe"
    if defined POWERSHELL_EXE %return%
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_POWERSHELL_EXE
    %dk_call% dk_printVar POWERSHELL_EXE
%endfunction%

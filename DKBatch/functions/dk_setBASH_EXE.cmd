@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_setBASH_EXE()
::#
::#
:dk_setBASH_EXE
    call dk_debugFunc 0
:: setlocal
   
    if defined BASH_EXE %return%
    
	:: try Git for windows bash.exe
	%dk_call% dk_validate GIT_DIR "%dk_call% dk_installGit"
	%dk_call% dk_findProgram BASH_EXE "bash.exe" "%GIT_DIR%"
	if defined BASH_EXE %return%

%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_setBASH_EXE
    %dk_call% dk_printVar BASH_EXE
%endfunction%

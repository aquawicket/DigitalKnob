@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_BASH_EXE()
::#
::#
:dk_BASH_EXE
    call dk_debugFunc 0
:: setlocal
   
    if defined BASH_EXE %return%
    
	:: try Git for windows bash.exe
	%dk_call% dk_validate GIT "%dk_call% dk_installGit"
	%dk_call% dk_findProgram BASH_EXE "bash.exe" "%GIT%"
	if defined BASH_EXE %return%

%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_BASH_EXE
    %dk_call% dk_printVar BASH_EXE
%endfunction%

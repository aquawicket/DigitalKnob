@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_BASH_EXE()
::#
::#
:dk_BASH_EXE
setlocal
	%dk_call% dk_debugFunc 0
   
    if exist "%BASH_EXE%" (%return%)
    
	:: try Git for windows bash.exe
	%dk_call% dk_validate GIT "%dk_call% dk_installGit"
	%dk_call% dk_findProgram BASH_EXE "bash.exe" "%GIT%"

	endlocal & (
		set "BASH_EXE=%BASH_EXE%"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_BASH_EXE
    %dk_call% dk_printVar BASH_EXE
%endfunction%

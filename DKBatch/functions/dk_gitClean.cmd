@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_gitClean()
::#
::#
:dk_gitClean
    call dk_debugFunc 0
 setlocal
  
    %dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
	
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	cd %DKBRANCH_DIR%
    "%GIT_EXE%" clean -fdx
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_gitClean 
%endfunction%
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_gitDiffSummary()
::#
::#
:dk_gitDiffSummary
 setlocal
	call dk_debugFunc 0
        
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_validateBranch"
    cd %DKBRANCH_DIR%
    
	%dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"

    "%GIT_EXE%" --no-pager diff --compact-summary
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_gitDiffSummary
%endfunction%

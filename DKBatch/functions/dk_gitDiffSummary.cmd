@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_gitDiffSummary()
::#
::#
:dk_gitDiffSummary
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
        
	call dk_validate DKBRANCH_DIR "call dk_validateBranch"
    cd %DKBRANCH_DIR%
    
	call dk_validate GIT_EXE "call dk_installGit"

    "%GIT_EXE%" --no-pager diff --compact-summary
goto:eof







:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	call dk_debugFunc
	
	call dk_gitDiffSummary
goto:eof
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*


::####################################################################
::# dk_installGitFileAssociations()
::#
:dk_installGitFileAssociations
	call dk_debugFunc 0
:: setlocal	

	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_validateBranch"
	%dk_call% dk_validate GITBASH_EXE   "%dk_call% dk_installGit"
	%dk_call% dk_installFileAssoc .sh %GITBASH_EXE%
	%dk_call% dk_installFileAssoc .bash %GITBASH_EXE%
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
 setlocal
 
    call dk_installGitFileAssociations
%endfunction%

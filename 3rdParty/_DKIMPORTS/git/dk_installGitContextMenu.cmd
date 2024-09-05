@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0


::####################################################################
::# dk_installGitFileAssociations()
::#
:dk_installGitContextMenu
	call dk_debugFunc 0
	
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate GITBASH_EXE "call %DKIMPORTS_DIR%\git\dk_installGit"
	call dk_installContextMenu "GIT ADD" "%GITBASH_EXE%" "\"%GIT_EXE%\" add \"%%%%1\""
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
    call dk_installGitContextMenu
%endfunction%

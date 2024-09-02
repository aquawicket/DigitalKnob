@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0


::####################################################################
::# dk_installGitFileAssociations()
::#
:dk_installGitFileAssociations
	call dk_debugFunc 0
	
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate GITBASH_EXE "call %DKIMPORTS_DIR%\git\dk_installGit"
	call dk_installFileAssoc .sh %GITBASH_EXE%
	call dk_installFileAssoc .bash %GITBASH_EXE%
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
    call dk_installGitFileAssociations
goto:eof

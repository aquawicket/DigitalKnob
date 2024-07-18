@echo off
call ..\..\..\DKBatch\functions\DK.cmd


::####################################################################
::# dk_installGitFileAssociations()
::#
:dk_installGitFileAssociations
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate GITBASH_EXE "call %DKIMPORTS_DIR%\git\dk_installGit"
	call dk_installFileAssoc .sh %GITBASH_EXE%
	call dk_installFileAssoc .bash %GITBASH_EXE%
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
    call dk_installGitFileAssociations
goto:eof

@echo off
call ..\..\..\DKBatch\functions\DK.cmd


::####################################################################
::# dk_installGitFileAssociations()
::#
:dk_installGitContextMenu
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate GITBASH_EXE "call %DKIMPORTS_DIR%\git\dk_installGit"
	call dk_installContextMenu "GIT ADD" "%GITBASH_EXE%" "\"%GIT_EXE%\" add \"%%%%%%%%1\""
goto:eof







::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
    call dk_installGitContextMenu
goto:eof

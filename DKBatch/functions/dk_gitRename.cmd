@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_gitRename(from, to)
::#
::#   rename a file in git
::#
::#   reference: https://stackoverflow.com/a/16071375/688352
::#
:dk_gitRename
	call dk_debugFunc 2
	
	call dk_validate GIT_EXE "call dk_installGit"
	"%GIT_EXE%" mv --force "%~1" "%~2"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_todo
	call dk_gitRename 
goto:eof

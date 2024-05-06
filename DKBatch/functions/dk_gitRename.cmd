@echo off
call dk_includeGuard
call DK

::################################################################################
::# dk_gitRename(<from> <to>)
::#
::#   rename a file in git
::#
::#   reference: https://stackoverflow.com/a/16071375/688352
::#
:dk_gitRename () {
	call dk_debugFunc
	
	call dk_validate GIT_EXE dk_validateGit
	"%GIT_EXE%" mv --force "%~1" "%~2"
goto:eof

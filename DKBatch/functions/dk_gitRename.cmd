@echo off
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
	if %__ARGC__% NEQ 2 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	call dk_validate GIT_EXE dk_validateGit
	"%GIT_EXE%" mv --force "%~1" "%~2"
goto:eof

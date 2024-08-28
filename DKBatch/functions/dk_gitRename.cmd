@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_gitRename(from, to)
::#
::#   rename a file in git
::#
::#   reference: https://stackoverflow.com/a/16071375/688352
::#
:dk_gitRename
 setlocal
	call dk_debugFunc 2
	
	%dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
	"%GIT_EXE%" mv --force "%~1" "%~2"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_todo
	%dk_call% dk_gitRename 
goto:eof

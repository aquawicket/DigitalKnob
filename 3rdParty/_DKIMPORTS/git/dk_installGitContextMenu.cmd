@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installGitContextMenu()
::#
:dk_installGitContextMenu
	call dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR    "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate GIT_EXE          "%dk_call% dk_installGit"
	%dk_call% dk_validate GITBASH_EXE      "%dk_call% dk_installGit"
	%dk_call% dk_installContextMenu "GIT ADD" "%GITBASH_EXE%" "\"%GIT_EXE%\" add \"%%%%%%%%1\""
	
	::%dk_call% dk_validate BASH_EXE       "%dk_call% %DKIMPORTS_DIR%\git\dk_installGit"
	::%dk_call% dk_installContextMenu "GIT ADD" "%BASH_EXE%" "\"%GIT_EXE%\" add \"%%%%1\""
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
    call dk_installGitContextMenu
%endfunction%

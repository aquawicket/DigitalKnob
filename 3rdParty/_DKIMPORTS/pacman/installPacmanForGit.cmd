@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installNotepadpp()
::#
:dk_installPacman
	call dk_debugFunc 0
	
	%dk_call% dk_validate BASH_EXE "%dk_call% dk_installGIT"
	
	:: Start a new Bash instance with a fresh environment
	:: https://superuser.com/a/1333539/600216
	%BASH_EXE% -c "env -i HOME="$HOME" PATH="$PATH" bash -l -c 'env'"
	
	%BASH_EXE% -c "env -i HOME="$HOME" PATH="$PATH" bash -l -c '/c/Users/Administrator/digitalknob/Development/3rdParty/_DKIMPORTS/pacman/installPacmanForGit.sh'"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_installPacman
%endfunction%

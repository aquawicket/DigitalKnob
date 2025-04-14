@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%../../../DKBatch/functions/")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_installPacman()
::#
:dk_installPacman
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate BASH_EXE "%dk_call% dk_installGIT"
	
	:: Start a new Bash instance with a fresh environment
	:: https://superuser.com/a/1333539/600216
	%BASH_EXE% -c "env -i HOME="$HOME" PATH="$PATH" bash -l -c 'env'"
	
	%BASH_EXE% -c "env -i HOME="$HOME" PATH="$PATH" bash -l -c '/c/Users/Administrator/digitalknob/Development/3rdParty/_DKIMPORTS/pacman/installPacmanForGit.sh'"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_installPacman
%endfunction%

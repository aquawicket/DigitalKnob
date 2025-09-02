@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_installPacman()
::#
:dk_installPacman
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate bash_exe "%dk_call% dk_installGIT"
	
	:: Start a new Bash instance with a fresh environment
	:: https://superuser.com/a/1333539/600216
	%bash_exe% -c "env -i HOME="$HOME" PATH="$PATH" bash -l -c 'env'"
	
	%bash_exe% -c "env -i HOME="$HOME" PATH="$PATH" bash -l -c '/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/pacman/installPacmanForGit.sh'"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_installPacman
%endfunction%

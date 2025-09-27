@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_gitApplyPatch(directory, patchFile)
::#
::#
:dk_gitApplyPatch
%setlocal%
	%dk_call% dk_debugFunc 2 

	::set "directory=%USERPROFILE:\=/%/DigitalKnob/Development/3rdParty/rmlui-master"
	::set "patchFile=%USERPROFILE:\=/%/DigitalKnob/Development/3rdParty/rmlui-master/termux.patch"
	set directory=%~1
	set patchFile=%~2
	
	:: NOTE: We must cd out of the .git local repository, or git apply wont work.
	%dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	%dk_call% dk_chdir %DIGITALKNOB_DIR%
	
::	%dk_call% dk_validate git_patch_exe "%dk_call% dk_depend git"
::	"%git_patch_exe%" --directory=%directory% < %patchFile% --verbose --dry-run
	
	%dk_call% dk_validate git_exe "%dk_call% dk_depend git"
	"%git_exe%" "-C %DKBRANCH_DIR% apply --verbose --no-index --unsafe-paths --directory=%directory% %patchFile%
	
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::%dk_call% dk_selectFolder
	::%dk_call% dk_selectFile
    ::%dk_call% dk_gitApplyPatch "%dk_selectFolder%" "%dk_selectFile%"
	
	set "directory=%USERPROFILE:\=/%/DigitalKnob/Development/3rdParty/rmlui-master"
	set "patchFile=%USERPROFILE:\=/%/DigitalKnob/Development/3rdParty/_DKIMPORTS/rmlui/termux.patch"
    %dk_call% dk_gitApplyPatch "%directory%" "%patchFile%"

%endfunction%

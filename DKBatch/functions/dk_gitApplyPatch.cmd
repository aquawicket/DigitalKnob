@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_gitApplyPatch(directory, patchFile)
::#
::#
:dk_gitApplyPatch
setlocal
	%dk_call% dk_debugFunc 2  

	::set "directory=C:/Users/Administrator/digitalknob/Development/3rdParty/rmlui-master"
	::set "patchFile=C:/Users/Administrator/digitalknob/Development/3rdParty/rmlui-master/termux.patch"
	set directory=%~1
	set patchFile=%~2
	
	:: NOTE: We must cd out of the .git local repository, or git apply wont work.
	%dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	%dk_call% dk_chdir %DIGITALKNOB_DIR%
	
::	%dk_call% dk_validate PATCH_EXE "%dk_call% dk_installGit"
::	"%PATCH_EXE%" --directory=%directory% < %patchFile% --verbose --dry-run
	
	%dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
	"%GIT_EXE%" "-C %DKBRANCH_DIR% apply --verbose --no-index --unsafe-paths --directory=%directory% %patchFile%
	
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	::%dk_call% dk_selectFolder directory
	::%dk_call% dk_selectFile patchFile
    ::%dk_call% dk_gitApplyPatch "%directory%" "%patchFile%"
	
	set "directory=C:/Users/Administrator/digitalknob/Development/3rdParty/rmlui-master"
	set "patchFile=C:/Users/Administrator/digitalknob/Development/3rdParty/_DKIMPORTS/rmlui/termux.patch"
    %dk_call% dk_gitApplyPatch "%directory%" "%patchFile%"

%endfunction%

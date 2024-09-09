@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_gitApplyPatch(directory, patchFile)
::#
::#
:dk_gitApplyPatch
 setlocal
    call dk_debugFunc 2
    
    %dk_call% dk_validate PATCH_EXE "%dk_call% dk_installGit"

	:: NOT WORKING
	::set directory=%~1
	::set patchFile=%~2
	::set directory=%directory:\=/%
	::set patchFile=%patchFile:\=/%
	::"%GIT_EXE%" apply --check --verbose --directory %directory% %patchFile% && "%GIT_EXE%" apply --verbose --directory %directory% %patchFile% || %dk_call% dk_fatal "the patch failed"
	
	%PATCH_EXE% -p1 --verbose --directory=%~1 < %~2
	
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
	%dk_call% dk_selectFolder directory
	%dk_call% dk_selectFile patchFile
	
    %dk_call% dk_gitApplyPatch "%directory%" "%patchFile%"
%endfunction%

@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_gitCreatePatch(fileA, fileB, patchFile)
::#
::#
:dk_gitCreatePatch
 setlocal
    call dk_debugFunc 3
        
    %dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_validateBranch"
    cd %DKBRANCH_DIR%
    
    %dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"

	"%GIT_EXE%"  diff --no-index --patch --output="%~3" "%~1" "%~2"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
	%dk_call% dk_selectFile fileA
	%dk_call% dk_selectFile fileB
	%dk_call% dk_saveFile patchFile
	
    %dk_call% dk_gitCreatePatch "%fileA%" "%fileB%" "%patchFile%"
%endfunction%

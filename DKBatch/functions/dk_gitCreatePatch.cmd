@echo off
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# dk_gitCreatePatch(fileA, fileB, patchFile)
::#
::#   FileA is the path/to/file to be patched.  it should contain the old data and should remain in it's required location.
::#   FileB is the path/to/file that contains the new data. it can be anywhere.
::#	  patchFile is the file created, it can be created to anywhere.
::#
:dk_gitCreatePatch
    %dk_call% dk_debugFunc 3
 ::setlocal
 
    echo dk_gitCreatePatch %*
	
    %dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    ::%dk_call% dk_chdir %DKBRANCH_DIR%
    
    %dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
	
	::%dk_call% dk_chdir %~dp1
	::%dk_call% dk_rename %~1 %~1.old
	::%dk_call% dk_copy %~2 %~1 OVERWRITE
	::set "fileA=%~nx1.old"
	::set "fileB=%~nx1"
	::"%GIT_EXE%" diff --relative --no-index  --unified --default-prefix --output=%~3 %fileA% %fileB%
	::%dk_call% dk_move %~1.old %~1 OVERWRITE
	
	%dk_call% dk_chdir %~dp1
	%dk_call% dk_copy %~2 %~1.patch OVERWRITE
	set "fileA=%~nx1"
	set "fileB=%~nx1.patch"
	"%GIT_EXE%" -C %DKBRANCH_DIR% diff --relative --no-index --unified --default-prefix --output=%~3 %fileA% %fileB%
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_selectFile fileA
	%dk_call% dk_selectFile fileB
	%dk_call% dk_saveFile patchFile
	%dk_call% dk_gitCreatePatch "%fileA%" "%fileB%" "%patchFile%"

	::%dk_call% dk_gitCreatePatch "%DKIMPORTS_DIR%/rmlui/CMakeLists.txt" "%DKIMPORTS_DIR%/rmlui/CMakeLists.txt.patch" "%DKIMPORTS_DIR%/rmlui/termux.patch"
%endfunction%

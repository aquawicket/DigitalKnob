@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_gitBackup(repo_path, git_file) OVERWRITE
::#
::#
:dk_gitBackup
%setlocal%
	%dk_call% dk_debugFunc 2 3
   
	if "%~1" neq "" (set "repo_path=%~1")
	if "%~2" neq "" (set "git_file=%~2")
	if "%~3" equ "OVERWRITE" (set "OVERWRITE=1") else (set "OVERWRITE=0")

	::###### error if repository doesn't exist
	if NOT EXIST "%repo_path%/.git" (
		%dk_call% dk_error "%repo_path% is not a path to a repository"
		%return%
	)
		
	if EXIST "%git_file%" (
		if "%OVERWRITE%" neq "1" (
			%dk_call% dk_error "dk_gitBackup Cannot create backup. Destiantion already exists and OVERWRITE is NOT set"
		)
		%dk_call% dk_delete %git_file%
	)
	
	%dk_call% dk_validate GIT_EXE "%dk_call% dk_depend git"
	
	::###### Back up the repositiory to a git_file
	::git -C <repo_path> bundle create <git_file> --all
	"%GIT_EXE%" -C "%repo_path%" bundle create "%git_file%" --all
	
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
    %dk_call% dk_gitBackup "%DKBRANCH_DIR%" "%DKDOWNLOAD_DIR%/DigitalKnob.git" OVERWRITE

%endfunction%

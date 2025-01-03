@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_gitClone(url, branch, dirctory)
::#
::#
:dk_gitClone
setlocal
	%dk_call% dk_debugFunc 2 3
    
	::###### error if repository already exists
	if exist "%~3\.git" %dk_call% dk_error "%~3\.git repository already exists" && %return%
	
	::###### backup if local path already exists and is not empty
	%dk_call% dk_isEmptyDirectory "%~3" || %dk_call% dk_copy "%~3" "%~3_BACKUP" OVERWRITE
	if not exist "%~3_BACKUP" %dk_call% dk_fatal "dk_copy failed"
	
	%dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
	
	::###### Clone if directory doesn't exist or is empty
	if not exist "%~3" ("%GIT_EXE%" -C "%~3" clone %~1 "%~3" && %return%)
	%dk_call% dk_isEmptyDirectory "%~3" && ("%GIT_EXE%" -C "%~3" clone %~1 "%~3" && %return%)
	
	::###### Fetch and checkout if directory already exists and is not empty
	"%GIT_EXE%" -C "%~3" init -b %~2
	"%GIT_EXE%" -C "%~3" remote add origin %~1
	"%GIT_EXE%" -C "%~3" fetch
	"%GIT_EXE%" -C "%~3" checkout -t origin/%~2 -f
	
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	echo dk_gitClone :DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
    %dk_call% dk_gitClone https://github.com/aquawicket/DigitalKnob.git "D:\digitalknob\Development"
%endfunction%

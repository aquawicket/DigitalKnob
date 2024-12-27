@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_gitClone(url, dirctory)
::#
::#
:dk_gitClone
    call dk_debugFunc 2
 setlocal
    
	::###### error if repository already exists
	if exist "%~2\.git" %dk_call% dk_error "%~2\.git repository already exists" && %return%
	
	::###### backup if local path already exists and is not empty
	%dk_call% dk_isEmptyDirectory "%~2" || %dk_call% dk_copy "%~2" "%~2_BACKUP" OVERWRITE
	if not exist "%~2_BACKUP" %dk_call% dk_fatal "dk_copy failed"
	
::	%dk_call% dk_set DKBATCH_FUNCTIONS_DIR "%~2_BACKUP\DKBatch\functions"
::	%dk_call% dk_set DKBATCH_FUNCTIONS_DIR_ "%DKBATCH_FUNCTIONS_DIR_%"
	
	%dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
	
	::###### Clone if directory doesn't exist or is empty
	if not exist "%~2" ("%GIT_EXE%" -C "%~2" clone %~1 "%~2" && %return%)
	%dk_call% dk_isEmptyDirectory "%~2" && ("%GIT_EXE%" -C "%~2" clone %~1 "%~2" && %return%)
	
	::###### Fetch and checkout if directory already exists and is not empty
	"%GIT_EXE%" -C "%~2" init -b Development 
	"%GIT_EXE%" -C "%~2" remote add origin %~1
	"%GIT_EXE%" -C "%~2" fetch
	"%GIT_EXE%" -C "%~2" checkout -t origin/Development -f
	
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
	
    %dk_call% dk_gitClone https://github.com/aquawicket/DigitalKnob.git "D:\digitalknob\Development"
%endfunction%

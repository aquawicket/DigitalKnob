@echo off
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# dk_gitClone(url, branch, dirctory)
::#
::#
:dk_gitClone
setlocal
	%dk_call% dk_debugFunc 2 3
    
	if not defined _URL_ (set "_URL_=%~1")
	%dk_call% dk_assertVar "%_URL_%"
	if not defined DKBRANCH_DIR (set "DKBRANCH_DIR=%~3")
	%dk_call% dk_assertPath "%DKBRANCH_DIR%"
	
	::###### error if repository already exists
	if exist "%DKBRANCH_DIR%/.git" (%dk_call% dk_error "'%DKBRANCH_DIR%/.git' repository already exists" & %return%)
	
	::###### backup if local path already exists and is not empty
	%dk_call% dk_isEmptyDirectory "%DKBRANCH_DIR%" || (%dk_call% dk_copy "%DKBRANCH_DIR%" "%DKBRANCH_DIR%_BACKUP" OVERWRITE)
	if not exist ("%DKBRANCH_DIR%_BACKUP" %dk_call% dk_fatal "dk_copy failed")
	
	%dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
	
	::###### Clone if directory doesn't exist or is empty
	if not exist "%DKBRANCH_DIR%" ("%GIT_EXE%" -C "%DKBRANCH_DIR%" clone "%_URL_%" "%DKBRANCH_DIR%" && %return%)
	%dk_call% dk_isEmptyDirectory "%DKBRANCH_DIR%" && ("%GIT_EXE%" -C "%DKBRANCH_DIR%" clone %_URL_% "%DKBRANCH_DIR%" && %return%)
	
	::###### Fetch and checkout if directory already exists and is not empty
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" init -b %~2
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" remote add origin %_URL_%
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" fetch
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" checkout -t origin/%~2 -f
	
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	echo dk_gitClone :DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
    %dk_call% dk_gitClone https://github.com/aquawicket/DigitalKnob.git "D:\digitalknob\Development"
%endfunction%

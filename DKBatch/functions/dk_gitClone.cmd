<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_gitClone(url, dirctory)
::#
::#
:dk_gitClone
    call dk_debugFunc 2
 setlocal
    
	if exist "%~2\.git" %dk_call% dk_error "%~2\.git repository already exists" && %return%
	%dk_call% dk_isEmptyDirectory "%~2" || %dk_call% dk_copy "%~2" "%~2_BACKUP"
	if not exist "%~2_BACKUP" %dk_call% dk_fatal "dk_copy failed" && %return%
	%dk_call% dk_set DKBATCH_FUNCTIONS_DIR "%~2_BACKUP\DKBatch\functions"
	%dk_call% dk_set DKBATCH_FUNCTIONS_DIR_ "%DKBATCH_FUNCTIONS_DIR%\"
	%dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
	
	::%dk_call% dk_cd %DKCACHE_DIR%
	%dk_call% dk_fileWrite %DKCACHE_DIR%\test.cmd "@echo off"
	%dk_call% dk_fileAppend %DKCACHE_DIR%\test.cmd "rmdir %~2 /s /q"
	%dk_call% dk_fileAppend %DKCACHE_DIR%\test.cmd "%GIT_EXE% clone %~1 %~2"
	
	(goto) 2>nul & (
	rem %dk_call% dk_cd %DKCACHE_DIR%
	start %DKCACHE_DIR%\test.cmd & exit
	)
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


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
	
>>>>>>> Development
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_gitClone https://github.com/aquawicket/DigitalKnob.git "%USERPROFILE%\digitalknob\main"
=======
	echo dk_gitClone :DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
    %dk_call% dk_gitClone https://github.com/aquawicket/DigitalKnob.git "D:\digitalknob\Development"
>>>>>>> Development
%endfunction%

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
	%dk_call% dk_set DKBATCH_FUNCTIONS_DIR_ "%DKBATCH_FUNCTIONS_DIR_%"
	%dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
	
	::%dk_call% dk_cd %DKCACHE_DIR%
	%dk_call% dk_fileWrite %DKCACHE_DIR%\test.cmd "@echo off"
	%dk_call% dk_fileAppend %DKCACHE_DIR%\test.cmd "rmdir %~2 /s /q"
	%dk_call% dk_fileAppend %DKCACHE_DIR%\test.cmd "%GIT_EXE% clone %~1 %~2"
	
	(goto) 2>nul & (
	rem %dk_call% dk_cd %DKCACHE_DIR%
	start %DKCACHE_DIR%\test.cmd & exit
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_gitClone https://github.com/aquawicket/DigitalKnob.git "%USERPROFILE%\digitalknob\main"
%endfunction%

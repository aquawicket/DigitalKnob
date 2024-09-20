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
	::%dk_call% dk_isEmptyDirectory "%~2" || %dk_call% dk_rename "%~2" "%~2_BACKUP"
	::if not exist "%~2_BACKUP" %dk_call% dk_fatal "dk_rename failed" && %return%
	%dk_call% dk_isEmptyDirectory "%~2" || %dk_call% dk_copy "%~2" "%~2_BACKUP"
	if not exist "%~2_BACKUP" %dk_call% dk_fatal "dk_copy failed" && %return%
	%dk_call% dk_set DKBATCH_FUNCTIONS_DIR "%~2_BACKUP\DKBatch\functions"
	%dk_call% dk_set DKBATCH_FUNCTIONS_DIR_ "%DKBATCH_FUNCTIONS_DIR%\"
	%dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
	
	cd %DKTEMP_DIR%
	%dk_call% dk_fileWrite %DKTEMP_DIR%\test.cmd "@echo off"
	%dk_call% dk_fileAppend %DKTEMP_DIR%\test.cmd "ping 127.0.0.1 -n 3 >null"
	%dk_call% dk_fileAppend %DKTEMP_DIR%\test.cmd "cd %DKTEMP_DIR%"
	%dk_call% dk_fileAppend %DKTEMP_DIR%\test.cmd "ping 127.0.0.1 -n 3 >null"
	%dk_call% dk_fileAppend %DKTEMP_DIR%\test.cmd "start rmdir %~2 /s /q"
	%dk_call% dk_fileAppend %DKTEMP_DIR%\test.cmd "ping 127.0.0.1 -n 3 >null"
	%dk_call% dk_fileAppend %DKTEMP_DIR%\test.cmd "del /F /Q %~2"
	%dk_call% dk_fileAppend %DKTEMP_DIR%\test.cmd "ping 127.0.0.1 -n 3 >null"
	%dk_call% dk_fileAppend %DKTEMP_DIR%\test.cmd "rd /S /Q %~2"
	%dk_call% dk_fileAppend %DKTEMP_DIR%\test.cmd "%GIT_EXE% clone %~1 %~2"
	
	(goto) 2>nul & (
	start %DKTEMP_DIR%\test.cmd & exit
	exit
	exit
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_gitClone https://github.com/aquawicket/DigitalKnob.git "%HOMEDRIVE%%HOMEPATH%\digitalknob\main"
%endfunction%

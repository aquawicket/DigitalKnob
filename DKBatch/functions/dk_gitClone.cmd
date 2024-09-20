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
	%dk_call% dk_isEmptyDirectory "%~2" || %dk_call% dk_rename "%~2" "%~2_BACKUP"
	
	%dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
    "%GIT_EXE%" clone %~1 "%~2"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_gitClone https://github.com/aquawicket/DigitalKnob.git "%HOMEDRIVE%%HOMEPATH%\digitalknob\Development"
%endfunction%

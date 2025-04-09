@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# dk_gitUpdate(url, branch, NO_CONFIRM)
::#
::#
:dk_gitUpdate
setlocal
	%dk_call% dk_debugFunc 2 3
 
    if "%~1" neq "" (set "_url_=%~1") else (set "_url_=https://github.com/aquawicket/DigitalKnob.git")
    if "%~2" neq "" (set "_branch_=%~2") else (set "_branch_=Development")
    
    ::if "%3" neq "NO_CONFIRM" (
    ::    echo Git Update? Any local changes will be lost.
    ::    %dk_call% dk_confirm || %return%
    ::)
        
    %dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    %dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
    
    if NOT exist "%DKBRANCH_DIR%\.git" (
		
		rem NOTE: 	This must cloan and update within the parentheses. rd /s /q "%DKBRANCH_DIR%" removes the current DigitalKnob
		rem			folder, leaving the current running batch process abandoned until it's cloned again. It seems like when we are 
		rem 		in the scope of called batch files, we loose all references to those deleted file once we leave the parentheses.
		rem         This includes variables, functions, etc. So to fix this, after we delete the very files our context is running 
		rem			from, we must stay in parentheses until those files are restored and updated, or we will lose the context.
		rem ####################################################################		
		if exist "%DKBRANCH_DIR%" (
			rem ###### Backup Branch directory and clone ######
			%dk_call% dk_copy "%DKBRANCH_DIR%" "%DKBRANCH_DIR%_BACKUP" OVERWRITE
			set "PATH=%DKBRANCH_DIR%_BACKUP\DKBatch\functions;%PATH%"
			rd /s /q "%DKBRANCH_DIR%"
			"%GIT_EXE%" clone %_url_% "%DKBRANCH_DIR%"
			"%GIT_EXE%" -C %DKBRANCH_DIR% pull --all
			"%GIT_EXE%" -C %DKBRANCH_DIR% checkout -- .
			"%GIT_EXE%" -C %DKBRANCH_DIR% checkout %_branch_%
			
			if NOT "%ERRORLEVEL%" == "0" (
				%dk_call% dk_echo "Remote has no '%_branch_%' branch. Creating..."
				"%GIT_EXE%" -C %DKBRANCH_DIR% checkout -b %_branch_% main
				"%GIT_EXE%" -C %DKBRANCH_DIR% push --set-upstream origin %_branch_%
			)
			%return%
		)
		rem ####################################################################
		
		rem ###### Clone into empty branch directory ######
		"%GIT_EXE%" clone %_url_% "%DKBRANCH_DIR%"
	)
	
	::###### Update ######
	"%GIT_EXE%" -C %DKBRANCH_DIR% pull --all
	"%GIT_EXE%" -C %DKBRANCH_DIR% checkout -- .
	"%GIT_EXE%" -C %DKBRANCH_DIR% checkout %_branch_%
			
	if NOT "%ERRORLEVEL%" == "0" (
		%dk_call% dk_echo "Remote has no '%_branch_%' branch. Creating..."
		"%GIT_EXE%" -C %DKBRANCH_DIR% checkout -b %_branch_% main
		"%GIT_EXE%" -C %DKBRANCH_DIR% push --set-upstream origin %_branch_%
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git Development
%endfunction%

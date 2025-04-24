@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


:: Choose the repositoy and the branch to merge in to a destination(usually main)
%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
%dk_call% dk_assertPath DKBRANCH_DIR
%dk_call% dk_assertPath DIGITALKNOB_DIR
%dk_call% dk_assertVar DKBRANCH

set "repository=%DKBRANCH_DIR%"
set "branch=%DKBRANCH%"
set "destination=main"

echo Running merge branch with these settings:
echo Repository: %repository%
echo     Branch: %branch%
echo Merging To: %destination%

:: ### Validate git.exe ###
%dk_call% dk_validate GIT_EXE  "%dk_call% dk_installGit"
%dk_call% dk_chdir "%DKBRANCH_DIR%"

pause
echo Merging %branch% into %destination% and pushing to remote
"%GIT_EXE%" -C "%DKBRANCH_DIR%" checkout %branch%
pause
"%GIT_EXE%" -C "%DKBRANCH_DIR%" pull
pause
"%GIT_EXE%" -C "%DKBRANCH_DIR%" checkout %destination%
pause
"%GIT_EXE%" -C "%DKBRANCH_DIR%" pull origin %destination%
pause
"%GIT_EXE%" -C "%DKBRANCH_DIR%" merge --no-ff --no-commit %branch%
pause

if NOT "%ERRORLEVEL%" equ "0" (
:conflicts
	echo THERE WAS AN ERROR MERGING.
	echo You will need to fix any existing conflicts to complete the merge.
	pause
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" git status
	echo AFTER ALL CONFLICTS ARE RESOLVED, CONTINUE.
	pause
) else (
	echo THE MERGE WAS SUCCESSFUL
	goto :resolved
)

:resolved
:: push merge to %destination%
echo Pushing merge to %destination%
"%GIT_EXE%" -C "%DKBRANCH_DIR%" commit -a -m "Merge %branch% Branch in to %destination%"
if NOT "%ERRORLEVEL%" equ "0" (
	echo THERE WAN AN ERROR COMMITING.
	goto :conflicts
) 

"%GIT_EXE%" -C "%DKBRANCH_DIR%" push origin %destination%

:: Bring branch up to date with %destination%
echo Bringing %branch% up to date with %destination%
"%GIT_EXE%" -C %DKBRANCH_DIR% checkout %branch%
"%GIT_EXE%" -C %DKBRANCH_DIR% merge %destination%
"%GIT_EXE%" -C %DKBRANCH_DIR% push
 
%dk_call% dk_success "THE MERGE IS COMPLETE."

@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


:: Choose the repositoy and the branch to merge in to a destination(usually master)
set "repository=%USERPROFILE%\digitalknob\Development"
set "branch=Development"
set "destination=master"

echo Running merge branch with these settings:
echo Repository: %repository%
echo     Branch: %branch%
echo Merging To: %destination%

set DKBRANCH=Development
set "DIGITALKNOB_DIR=%USERPROFILE%\digitalknob"
set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\%DKBRANCH%"
if exist "%ProgramFiles%\Git\bin\git.exe" set "GIT_EXE=%ProgramFiles%\Git\bin\git.exe"
if exist "%ProgramFiles(x86)%\Git\bin\git.exe" set "GIT_EXE=%ProgramFiles(x86)%\Git\bin\git.exe"
if NOT exist "%GIT_EXE%" (
	ERROR "Could not find git"
)
cd %DKBRANCH_DIR%
pause
echo Merging %branch% into %destination% and pushing to remote
"%GIT_EXE%" -C %DKBRANCH_DIR% checkout %branch%
pause
"%GIT_EXE%" -C %DKBRANCH_DIR% pull
pause
"%GIT_EXE%" -C %DKBRANCH_DIR% checkout %destination%
pause
"%GIT_EXE%" -C %DKBRANCH_DIR% pull origin %destination%
pause
"%GIT_EXE%" -C %DKBRANCH_DIR% merge --no-ff --no-commit %branch%
pause

if NOT "%ERRORLEVEL%" equ "0" (
	echo THERE WAN AN ERROR MERGING.
	goto :conflicts
) else (
	echo THE MERGE WAS SUCCESSFUL
	goto :resolved
)
goto:eof:

:conflicts
echo You will need to fix any existing conflicts to complete the merge.
pause
CPP_DK_Execute(GIT_EXE + " -C %DKBRANCH_DIR% git status")

echo AFTER ALL CONFLICTS ARE RESOLVED, CONTINUE.
pause 
goto :resolved



:resolved
:: push merge to %destination%
echo Pushing merge to %destination%
"%GIT_EXE%" -C %DKBRANCH_DIR% commit -a -m "Merge %branch% Branch in to %destination%"
if NOT "%ERRORLEVEL%" equ "0" (
	echo THERE WAN AN ERROR COMMITING.
	goto :conflicts
) 
"%GIT_EXE%" -C %DKBRANCH_DIR% push origin %destination%

:: Bring branch up to date with %destination%
echo Bringing %branch% up to date with %destination%
"%GIT_EXE%" -C %DKBRANCH_DIR% checkout %branch%
"%GIT_EXE%" -C %DKBRANCH_DIR% merge %destination%
"%GIT_EXE%" -C %DKBRANCH_DIR% push
 
echo THE MERGE IS COMPLETE.
%DKEND% 

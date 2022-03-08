%dkbatch%

:: Choose the repositoy and the branch to merge in to a destination(usually master)
set "repository=C:\Users\%USERNAME%\digitalknob\DK"
set "branch=Development"
set "destination=master"

echo Running merge branch with these settings:
echo Repository: %repository%
echo     Branch: %branch%
echo Merging To: %destination%


set "DIGITALKNOB=C:\Users\%USERNAME%\digitalknob"
set "DKPATH=%DIGITALKNOB%\DK"
if exist "C:\Program Files\Git\bin\git.exe" set "GIT=C:\Program Files\Git\bin\git.exe"
if exist "C:\Program Files (x86)\Git\bin\git.exe" set "GIT=C:\Program Files (x86)\Git\bin\git.exe"
if NOT exist "%GIT%" (
	ERROR "Could not find git"
)
cd %DKPATH%
pause
echo Merging %branch% into %destination% and pushing to remote
"%GIT%" checkout %branch%
pause
"%GIT%" pull
pause
"%GIT%" checkout %destination%
pause
"%GIT%" pull origin %destination%
pause
"%GIT%" merge --no-ff --no-commit %branch%
pause

if NOT "%ERRORLEVEL%" == "0" (
	echo THERE WAN AN ERROR MERGING.
	goto :conflicts
) else (
	echo THE MERGE WAS SUCCESSFUL
	goto :resolved
)
goto eof:

:conflicts
echo You will need to fix any existing conflicts to complete the merge.
pause
CPP_DK_Execute(GIT + " git status")

echo AFTER ALL CONFLICTS ARE RESOLVED, CONTINUE.
pause 
goto :resolved



:resolved
:: push merge to %destination%
echo Pushing merge to %destination%
"%GIT%" commit -a -m "Merge %branch% Branch in to %destination%"
if NOT "%ERRORLEVEL%" == "0" (
	echo THERE WAN AN ERROR COMMITING.
	goto :conflicts
) 
"%GIT%" push origin %destination%

:: Bring branch up to date with %destination%
echo Bringing %branch% up to date with %destination%
"%GIT%" checkout %branch%
"%GIT%" merge %destination%
"%GIT%" push
 
echo THE MERGE IS COMPLETE.
%DKEND% 

%dkbatch%

set "branch=Development"

set "DIGITALKNOB=C:\Users\%USERNAME%\digitalknob"
set "DKPATH=%DIGITALKNOB%\DK"
if exist "C:\Program Files\Git\bin\git.exe" set "GIT=C:\Program Files\Git\bin\git.exe"
if exist "C:\Program Files (x86)\Git\bin\git.exe" set "GIT=C:\Program Files (x86)\Git\bin\git.exe"
if NOT exist "%GIT%" (
	ERROR "Could not find git"
)
cd %DKPATH%
pause
echo Merging %branch% into master and pushing to remote
"%GIT%" checkout %branch%
pause
"%GIT%" pull
pause
"%GIT%" checkout master
pause
"%GIT%" pull origin master
pause
"%GIT%" merge --no-ff --no-commit %branch%
pause

if NOT "%ERRORLEVEL%" == "0" (
	echo THERE WAN AN ERROR MERGING
	pause
	:: If there are conflicts
	CPP_DK_Execute(GIT + " git status")
) else (
	echo THE MERGE WAS SUCCESSFUL
	pause
	:: After conflicts resolved
	"%GIT%" commit -a -m "Merge %branch% Branch in to Master"
	"%GIT%" push origin master
)
 
 
%DKEND% 

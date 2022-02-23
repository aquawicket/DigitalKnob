%dkbatch%

set "branch=Development"

if exist "C:\Program Files\Git\bin\git.exe" set "GIT=C:\Program Files\Git\bin\git.exe"
if exist "C:\Program Files (x86)\Git\bin\git.exe" set "GIT=C:\Program Files (x86)\Git\bin\git.exe"
if NOT exist "%GIT%" (
	ERROR "Could not find git"
)

echo Merging %branch% into master and pushing to remote
"%GIT%" checkout %branch%
"%GIT%" pull
"%GIT%" checkout master
"%GIT%" pull origin master
"%GIT%" merge --no-ff --no-commit %branch%

if NOT "%ERRORLEVEL%" == "0" (
	echo THERE WAN AN ERROR MERGING
) else (
	echo THE MERGE WAS SUCCESSFUL 
)

	
:: If there are conflicts
::CPP_DK_Execute(GIT + " git status")

:: After conflicts resolved
::"%GIT%" commit -a -m "Merge Development Branch in to Master"
::"%GIT%" push origin master
 
 
%DKEND% 

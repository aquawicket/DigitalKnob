:: This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
::
:: For the latest information, see https://github.com/aquawicket/DigitalKnob
::
:: Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
::
:: Permission is hereby granted, free of charge, to any person obtaining a copy
:: of this software and associated documentation files(the "Software"), to deal
:: in the Software without restriction, including without limitation the rights
:: to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
:: copies of the Software, and to permit persons to whom the Software is
:: furnished to do so, subject to the following conditions :
::
:: The above copyright notice and this permission notice shall be included in all
:: copies or substantial portions of the Software.
::
:: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
:: IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
:: FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
:: AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
:: LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
:: OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
:: SOFTWARE.
%dkbatch%

:: Choose the repositoy and the branch to merge in to a destination(usually master)
set "repository=C:\Users\%USERNAME%\digitalknob\Development"
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

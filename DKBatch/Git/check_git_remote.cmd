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

%DKBATCH%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:check_git_remote in1 in2 out1 out2
::
:: Func:  *description*
::
:: in1:   first input variable
:: in2:   second input variable
:: out1:  first output variable
:: out2:  second output variable
::
:: Example:  call check_git_remote someValue "anotherValue" result1 result2
::           echo check_git_remote returned: %result1% %result2%
:: 
::  Output:  check_git_remote returned: someValue "anotherValue"
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if not exist "%DKBRANCH_DIR%\.git" goto:eof
git remote update
call command_to_variable "%GIT_EXE% rev-parse --abbrev-ref HEAD" branch
call command_to_variable "%GIT_EXE% rev-list --count origin/%branch%..%branch%" ahead
call command_to_variable "%GIT_EXE% rev-list --count %branch%..origin/%branch%" behind
echo %ahead% commits ahead, %behind% commits behind

endlocal & set "%3=%out1%" & set "%4=%out2%" 
%DKEND%

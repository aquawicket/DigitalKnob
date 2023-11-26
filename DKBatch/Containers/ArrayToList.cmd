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

set "array_name=%~1"
if "%array_name%"=="" (
	echo [91m array_name is invalid, providing test variables [0m
	set "test[0]=test0"
	set "test[1]=test1"
	set "test[2]=test2"
	set "test[3]=test3"
	set "test[4]=test4"
	set "array_name=test"
)
echo array_name = %array_name%

call GetArrayLength %array_name%
set /a "count=%GetArrayLength%-1"
for /l %%n in (0, 1, %count%) do (
	if "%%n"=="0" (
		set "list=!%array_name%[%%n]!"
	) else (
		set "list=!list!;!%array_name%[%%n]!"
	)
)

echo %list%
set "%0=%list%" 
 
%DKEND% 

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
:replace_substring <input> <replace> <with> <output>
::
:: get_files: List the files in the given path
::
:: path:  	The path to list the files in
:: result: 	file_list returned
::
:: Example:  call get_files C:\Windows\Sysem32 file_list
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "input=%~1"
set "replace=%~2"
set "with=%~3"
set "output=%~4"

::call set "%4=%%input:%2=%3%%"
   
::set "replace=%2"
::call set "%4=%%input:%replace%=%with%%%"
   
::set "with=%3"
::call set "%4=%%input:%2=%with%%%"
   
set "output=%4"
call set "output=%%input:%replace%=%with%%%"

endlocal & set "%4==%output%"
%DKEND%



:TEST_replace_substring
	set "inputA=1234567890"
	set "replaceA=12345"
	set "withA=00000"
	echo inputA = %inputA%
	call:replace_substring %inputA% %replaceA% %withA% outputA
	echo outputA = %outputA%
	
	set "variableB=red white blue"
	set "replaceB=blue"
	set "withB=purple"
	echo variableB = %variableB%
	call:replace_in_variable variableB %replaceB% %withB%
	echo variableB = %variableB%

	pause
goto:eof
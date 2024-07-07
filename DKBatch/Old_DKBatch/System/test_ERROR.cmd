:: This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
::
:: For the latest information, see https://github.com/aquawicket/DigitalKnob
::
:: Copyright(c) 2010 - 2024 Digitalknob Team, and contributors
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

::%dkbatch%
set "DKBATCH=@echo off & call ../dkbatch.cmd %%~f0 %%* & @setlocal enableextensions enabledelayedexpansion"
::setx DKBATCH "%DKBATCH%"
%DKBATCH%
echo DKBATCH = "%DKBATCH%"

echo ################################
echo ##      TESTING Errors        ##
echo ################################
set ERRORLEVEL=0
%IF_ERROR% "IF_ERROR: This throws an error if ERRLVL is not 0, and continues"
echo:
	
set ERRORLEVEL=1
%IF_ERROR% "IF_ERROR: This throws an error if ERRLVL is not 0, and continues"
echo: 

%ERROR% "ERROR: This throws an error, and continues"
echo:

set ERRORLEVEL=0
%IF_FATAL% "IF_FATAL: This will be skipped since ERRORLEVEL = 0"
echo IF_FATAL was called but skipped since ERRORLEVEL = 0
echo:
	
::echo Setting ERRORLEVEL to 1 and calling IF_FATAL again.
::echo.
::set ERRORLEVEL=1
::%IF_FATAL% "IF_FATAL: This thows an error if ERRLVL is not 0, and exits the program"
::echo:

echo This will never be reached since the IF_FATAL above exits the program
%FATAL% "FATAL: This throws an error, and exits the program"
echo:

 
%DKEND% 

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
@echo off & call dkbatch.cmd %%~f0 %%* & @setlocal enableextensions enabledelayedexpansion
::%DKBATCH%

:: background color
::0 = Black       8 = Gray
::1 = Blue        9 = Light Blue
::2 = Green       A = Light Green
::3 = Aqua        B = Light Aqua
::4 = Red         C = Light Red
::5 = Purple      D = Light Purple
::6 = Yellow      E = Light Yellow
::7 = White       F = Bright White
::COLOR 1A


:main
	call:enter_command
    call:run_command
	goto:main
goto:end

:enter_command
   echo Enter a command:
   set /p command=
goto:eof

:run_command
   ::call ListToArray "%command%" command_arry length
   ::call PrintArray command_arry
   ::call CallArray command_arry
   ::call DeleteArray command_arry
   echo.
   call %command%
   echo.
   set "command_arry="
   set "length="
goto:eof

:end
%DKEND%

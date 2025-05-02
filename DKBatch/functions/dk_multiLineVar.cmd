@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


set "V=goto "
::################################################################################
::# dk_multiLineVar(NAME)
::#
::#    Reference: https://stackoverflow.com/a/7308798
::#
:dk_multiLineVar
setlocal disableDelayedExpansion
	::%dk_call% dk_debugFunc 1
	



	
	for /f "useback delims=" %%A in ("%~f0") do (
		if "%%~A"==":%~1" (
			set "$="
		)
		if defined $ (
			call set "VAR=%%VAR%%%%A\n"
		)
		if "%%~A"=="!V!:%~1" (
			set "$=1"
		)	
	)
	
	set "VAR=%VAR:"="[8m"[0m%"
	set "VAR=%VAR:"="%"
	set "VAR=%VAR:^=^^%"
	set "VAR=%VAR:!=^^^^!%"
	
	endlocal & (
	
(set \n=^
%=DO NOT ALTER THIS=%
)
		set "%~1=%VAR:\n=!\n!%"
	)
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	
	call :dk_multiLineVar TestVariable
	echo ############### dk_multiLineVar TestVariable ##########################
	echo !TestVariable!
	
%endfunction%








goto:eof
!V!:TestVariable
/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2025 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
:TestVariable


::2141
::2052
::3654
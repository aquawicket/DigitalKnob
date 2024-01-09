# This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
#
# For the latest information, see https://github.com/aquawicket/DigitalKnob
#
# Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files(the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions :
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

#################################################################
# cmake_eval eval_code error
#
# Func:  Run code within th DKCMake codebase
#
# eval_code:  the code to send to CMake
# error:    the error code if any
#
# Example:  call cmake_eval dk_info("called from cmake_eval")
#           echo cmake_eval returned: %error%
###############################################################
#echo cmake_eval $1
if [ -z "$1" ]; then
	echo "ERROR: cmake_eval() parameter1 is invalid"
	return $false
fi

DIGITALKNOB="$HOME/digitalknob"
DKCMAKE="$DIGITALKNOB%/Development/DKCMake"
CMAKE=$(which cmake)
echo "CMAKE = $CMAKE"

commands=$1
#echo "commands = $commands"
#set commands=$commands:"=%"  #TODO: remove double quotes
set DKCOMMAND="$commands"
echo "DKCOMMAND = $DKCOMMAND"


"$CMAKE" "-DDKCMAKE=$DKCMAKE" "-DDKCOMMAND=$DKCOMMAND" -P "$DKCMAKE/dev/cmake_eval.cmake" --log-level=TRACE >cmake_eval.out 2>cmake_eval.err
#echo return code: %ERRORLEVEL%  #TODO: get return code

out=
#for /f "Tokens=* Delims=" %%x in (cmake_eval.out) do (
#	set out=!out!%%x
#	echo %%x
#)
#out contains all of the lines
#echo %out%		
		
err=
#for /f "Tokens=* Delims=" %%x in (cmake_eval.err) do (
#	set err=!err!%%x
#	echo [91m %%x [0m
#)
#err contains all of the lines
#echo %err%

#del cmake_eval.out
#del cmake_eval.out


#if "%ERROR_CODE%"=="0" (
#	echo return code: %ERROR_CODE%
#)
#if not "%ERROR_CODE%"=="0" (
#	echo return code: %ERROR_CODE%
#)


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
# Func:  Run code within the DKCMake codebase
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
	#return $false #FIXME:  return: can only `return' from a function or sourced script
fi

#################################
#	Global variables
#################################
red="\033[31m"


DIGITALKNOB=/c/Users/aquawicket/digitalknob
DKCMAKE_DIR="$DIGITALKNOB/Development/DKCMake"
CMAKE_EXE=$(which cmake)
#echo "CMAKE_EXE = $CMAKE_EXE"

commands="$@"
#echo "commands = $commands"
#set commands=$commands:"=%"  #TODO: remove double quotes
DKCOMMAND="$commands"
#echo "DKCOMMAND = $DKCOMMAND"


#$CMAKE_EXE -DDKCMAKE_DIR=$DKCMAKE_DIR "-DDKCOMMAND=$DKCOMMAND" -P $DKCMAKE_DIR_DIR/dev/cmake_eval.cmake --log-level=TRACE >cmake_eval.out 2>cmake_eval.err
$CMAKE_EXE "-DDKCOMMAND=$DKCOMMAND" -P $DKCMAKE_DIR/dev/cmake_eval.cmake
echo return code: $? 


out=""
while IFS= read -r outline 
	do
		out="$out $outline"
        echo "$outline"
    done < cmake_eval.out
#out contains all of the lines
#echo "$out"
	
		
err=""
while IFS= read -r errline
    do
		err="$err $errline"
		echo -e "${red} $errline ${CLR}"
    done < cmake_eval.err
#err contains all of the lines
#echo "$err"	

#del cmake_eval.out
#del cmake_eval.out


#if "%ERROR_CODE%"=="0" (
#	echo return code: %ERROR_CODE%
#)
#if not "%ERROR_CODE%"=="0" (
#	echo return code: %ERROR_CODE%
#)


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
include_guard()

CMAKE_MINIMUM_REQUIRED(VERSION 3.10)
CMAKE_POLICY(SET CMP0007 NEW)
#include(${DKCMAKE}/DK.cmake)

#message("CMAKE_ARGC=\"${CMAKE_ARGC}\"")
#message("CMAKE_ARGV0=\"${CMAKE_ARGV0}\"")
#message("CMAKE_ARGV1=\"${CMAKE_ARGV1}\"")
#message("CMAKE_ARGV2=\"${CMAKE_ARGV2}\"")
#message("CMAKE_ARGV3=\"${CMAKE_ARGV3}\"")
#message("CMAKE_ARGV4=\"${CMAKE_ARGV4}\"")

#message("ARGC=\"${ARGC}\"")
#message("ARGN=\"${ARGN}\"")
#message("ARGV=\"${ARGV}\"")
#message("ARGV0=\"${ARGV0}\"")
#message("ARGV1=\"${ARGV1}\"")


function(loopback var)
	message(STATUS "${var}")
endfunction()

# Evaluate expression (faster version)
# Suggestion from the Wiki: http://cmake.org/Wiki/CMake/Language_Syntax
# Unfortunately, no built-in stuff for this: http://public.kitware.com/Bug/view.php?id=4034
# eval will not modify ans (the code evaluated may modify ans)
# vars starting with __eval should not be used in code
function(cmake_eval eval_code)
	string(REPLACE ";"  "\n" eval_code "${eval_code}")
	string(REPLACE "'"  "\"" eval_code "${eval_code}")
	#message(STATUS "eval_code = ${eval_code}")
	if(COMMAND cmake_language)
		#message(STATUS "eval_code = ${eval_code}")
		cmake_language(EVAL CODE "${eval_code}")
	else()
		# one file per execution of cmake (if this file were in memory it would probably be faster...)
		#fwrite_temp("" ".cmake")
		#ans(__eval_temp_file)
		# speedup: statically write filename so eval boils down to 3 function calls
		set(__eval_temp_file ${DKCMAKE}/__eval_temp_file.cmake)
		file(WRITE "${__eval_temp_file}" "
			function(eval eval_code)
			file(WRITE ${__eval_temp_file} \"\${eval_code}\")
			include(${__eval_temp_file})
			#set(__ans \${__ans} PARENT_SCOPE)
			endfunction()
		")
		include("${__eval_temp_file}")
		eval("${eval_code}")
		#return_ans()
	endif()
endfunction()


#message(STATUS "DKCOMMAND = ${DKCOMMAND}")
cmake_eval("${DKCOMMAND}")
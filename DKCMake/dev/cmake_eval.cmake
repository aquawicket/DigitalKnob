#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
# This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
#
# For the latest information, see https://github.com/aquawicket/DigitalKnob
#
# Copyright(c) 2010 - 2025 Digitalknob Team, and contributors
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


# Evaluate expression (faster version)
# Suggestion from the Wiki: http://cmake.org/Wiki/CMake/Language_Syntax
# Unfortunately, no built-in stuff for this: http://public.kitware.com/Bug/view.php?id=4034
# eval will not modify ans (the code evaluated may modify ans)
# vars starting with __eval should not be used in code
#function(cmake_eval eval_code)
#	dk_replaceAll("${eval_code}"  ";"  "\n"  eval_code)
#	dk_replaceAll("${eval_code}"  "'"  "\""  eval_code)
#	#message(STATUS "eval_code = ${eval_code}")
#	if(COMMAND cmake_language)
#		#message(STATUS "eval_code = ${eval_code}")
#		cmake_language(EVAL CODE "${eval_code}")
#	else()
#		# one file per execution of cmake (if this file were in memory it would probably be faster...)
#		#fwrite_temp("" ".cmake")
#		#ans(__eval_temp_file)
#		# speedup: statically write filename so eval boils down to 3 function calls
#		set(__eval_temp_file $ENV{DKCMAKE_DIR}/__eval_temp_file.cmake)
#		file(WRITE "${__eval_temp_file}" "
#			function(eval eval_code)
#			file(WRITE ${__eval_temp_file} \"\${eval_code}\")
#			include(${__eval_temp_file})
#			#set(__ans \${__ans} PARENT_SCOPE)
#			endfunction()
#		")
#		include("${__eval_temp_file}")
#		eval("${eval_code}")
#	endif()
#endfunction()


#message(STATUS "DKCOMMAND = ${DKCOMMAND}")
#cmake_eval("${DKCOMMAND}")
dk_eval("${DKCOMMAND}")

if(DKRETURN)
	#message(STATUS "DKRETURN = ${DKRETURN}")
	
	## create windows cmd to set variables
	dk_delete($ENV{DKCMAKE_DIR}/cmake_vars.cmd NO_HALT)
	foreach(item ${DKRETURN})
		set(line "set \"${item}=${${item}}\" \n")
		dk_fileAppend($ENV{DKCMAKE_DIR}/cmake_vars.cmd "${line}\n")
	endforeach()
	
	## create unix shell to set variables 
	dk_delete($ENV{DKCMAKE_DIR}/cmake_vars.sh NO_HALT)
	dk_fileAppend($ENV{DKCMAKE_DIR}/cmake_vars.sh "#!/bin/bash \n")
	foreach(var ${DKRETURN})
		dk_convertToCIdentifier(${var} var_)
		set(line "export ${var_}=\"${${var}}\" \n")
        dk_fileAppend($ENV{DKCMAKE_DIR}/cmake_vars.sh "${line}\n")
	endforeach()
endif()

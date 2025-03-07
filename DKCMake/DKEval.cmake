#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	file(TO_CMAKE_PATH "$ENV{USERPROFILE}$ENV{HOME}/digitalknob/Development/DKCMake/functions" DKCMAKE_FUNCTIONS_DIR)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
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

#message("DKCOMMAND = ${DKCOMMAND}")
string(REPLACE "\'" "\"" DKCOMMAND ${DKCOMMAND})
dk_parseFunctionsAndLoadFromString("${DKCOMMAND}")
dk_eval("${DKCOMMAND}")

if(DKRETURN)
	#message("DKRETURN = ${DKRETURN}")
	
#	## create windows cmd script to set the return variables
#	dk_delete(${DKCMAKE_DIR}/cmake_vars.cmd NO_HALT)
#	foreach(item ${DKRETURN})
#		set(line "set \"${item}=${${item}}\" \n")
#		dk_fileAppend(${DKCMAKE_DIR}/cmake_vars.cmd "${line}\n")
#		dk_exportVars(${item} "${${item}}")
#	endforeach()
	
#	## create unix shell script to set the return variables
#	dk_delete(${DKCMAKE_DIR}/cmake_vars.sh NO_HALT)
#	dk_fileAppend(${DKCMAKE_DIR}/cmake_vars.sh "#!/bin/sh \n")
#	foreach(var ${DKRETURN})
#		dk_convertToCIdentifier(${var} var_)
#		set(line "export ${var_}=\"${${var}}\" \n")
#       dk_fileAppend(${DKCMAKE_DIR}/cmake_vars.sh "${line}\n")
#	endforeach()

	dk_load(dk_exportVars)
	foreach(item ${DKRETURN})
		dk_exportVars(${item} "${${item}}")
	endforeach()
endif()

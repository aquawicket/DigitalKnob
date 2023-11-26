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


##################################################################################
# dk_file_setDigitalknobPath()
#
#	Set the digitalknob root directory environment variable
#
function(dk_setDigitalknobPath)
	# Set the DIGITALKNOB environment variable 
	get_filename_component(path ${CMAKE_SOURCE_DIR} ABSOLUTE)
	string(FIND "${path}" "digitalknob" pos)
	string(SUBSTRING ${path} 0 ${pos} path)
	set(DIGITALKNOB ${path}digitalknob CACHE INTERNAL "")
	set(DKCMAKE ${DIGITALKNOB}/DK/DKCMake/ CACHE INTERNAL "")
	set(ENV{DIGITALKNOB} ${DIGITALKNOB})
	set(ENV{DKCMAKE} ${DKCMAKE})
	if(WIN_HOST)
		execute_process(COMMAND cmd /c setx DIGITALKNOB ${DIGITALKNOB})
		execute_process(COMMAND cmd /c setx DKCMAKE ${DKCMAKE})
	endif()
	#message(STATUS "DIGITALKNOB = ${DIGITALKNOB}")
	#message(STATUS "DKCMAKE = ${DKCMAKE}")
	#message(STATUS "ENV{DIGITALKNOB} = $ENV{DIGITALKNOB}")
	#message(STATUS "ENV{DKCMAKE} = $ENV{DKCMAKE}")
endfunction()
dk_setDigitalknobPath()

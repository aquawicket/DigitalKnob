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


set(PASSED_PARAMETERS "") # it will contain all params string
set(ARG_NUM 1) # current index, starting with 1 (0 ignored)
math(EXPR ARGC_COUNT "${CMAKE_ARGC}-2") # disscount last 2 parameters


while(ARG_NUM LESS ARGC_COUNT)	
    set(CURRENT_ARG ${CMAKE_ARGV${ARG_NUM}})					# making current arg named "CMAKE_ARGV" + "CURRENT_INDEX"
    #message(STATUS "${CURRENT_ARG}")
    set(PASSED_PARAMETERS ${PASSED_PARAMETERS} ${CURRENT_ARG})  # adding current param to the list
    math(EXPR ARG_NUM "${ARG_NUM}+1") 							# incrementing current index
endwhile()

#message(STATUS "> ${PASSED_PARAMETERS}")
execute_process(COMMAND ${PASSED_PARAMETERS}
				RESULT_VARIABLE result
				OUTPUT_VARIABLE output
				OUTPUT_STRIP_TRAILING_WHITESPACE)

if(NOT ${result} EQUAL 0)
    message(STATUS "ERROR: '${result}'")
endif()
message(STATUS "output> ${output}")

file(WRITE log.txt "${output}")

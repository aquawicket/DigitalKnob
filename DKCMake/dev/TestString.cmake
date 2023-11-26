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
include(../DK.cmake)

dk_set(string_Ext ON)
include(../DKString.cmake)
dk_clearScreen()

message(STATUS " ")
message(STATUS "#####################################")
message(STATUS "#########  TestString.cmake  ########")
message(STATUS "#####################################")
message(STATUS " ")

macro(Test_String)
	message(STATUS "With the DKString.cmake class, we overwrite the set() function to intercept and \"stringify\" variables.")
	message(STATUS "That will add _function style macros to the variable name so we can access the function much like javascript.")
	message(STATUS "Instead of string.function() we use string_function(). CMake functions lack returning values directly, So, we use the last parameter as he return variable.")
	message(STATUS "DKString.cmake will automatically listen for the set() function and use it to stringify that variable, and add string _functions to it.")
	message(STATUS "For example, now we can use the string includes() function like this...")
	message(STATUS " ")
	message(STATUS " ")
	message(STATUS "EXAMPLE 1:")
	message(STATUS "${blue} set(MyString1 \"the text within the string\") ${CLR}")
	message(STATUS "${blue} MyString1_includes(\"within\" result) ${CLR}")
	message(STATUS "${blue} message(STATUS \"result = \${result}\") ${CLR}")
	message(STATUS " ")
	
	message(STATUS "OUTPUT 1:")
	set(MyString1 "the text within the string")
	MyString1_includes("within" result)
	message(STATUS "${blue} result = ${result} ${CLR}")
	
	message(STATUS " ")
	message(STATUS " ")
	message(STATUS "EXAMPLE 2:")
	message(STATUS "${blue} set(MyString2 \"the text within the string\") ${CLR}")
	message(STATUS "${blue} MyString2_includes(\"without\" result) ${CLR}")
	message(STATUS "${blue} message(STATUS \"result = \${result}\") ${CLR}")
	message(STATUS " ")
	
	message(STATUS "OUTPUT 2:")
	set(MyString2 "the text within the string")
	MyString2_includes("without" result)
	message(STATUS "${blue} result = ${result} ${CLR}")
	
	message(STATUS " ")
	message(STATUS " ")
	message(STATUS "This style puts CMake closer to javascript style, which looks like this.. result = MyString.include('within', 15)")
	message(STATUS "The only major differences are the dot .  is replaced with an underscore _  And instead of the function returning a value directly,")
	message(STATUS "we set the return variable as the last parameter. Then we can easily check it's value right after the function completes")
endmacro()

Test_String()
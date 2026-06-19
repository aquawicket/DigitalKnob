#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################
# This source file is part of DigitalKnob, the cross-platform C/C++/Javascript/Html/Css Solution
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

dk_set(string_Ext ON)
include(${DKCMAKE_DIR}/DKString.cmake)
dk_clearScreen()

dk_echo(" ")
dk_echo("#####################################")
dk_echo("#########  TestString.cmake  ########")
dk_echo("#####################################")
dk_echo(" ")

macro(Test_String)
	dk_echo("With the DKString.cmake class, we overwrite the set() function to intercept and \"stringify\" variables.")
	dk_echo("That will add _function style macros to the variable name so we can access the function much like javascript.")
	dk_echo("Instead of string.function() we use string_function(). CMake functions lack returning values directly, So, we use the last parameter as he return variable.")
	dk_echo("DKString.cmake will automatically listen for the set() function and use it to stringify that variable, and add string _functions to it.")
	dk_echo("For example, now we can use the string includes() function like this...")
	dk_echo(" ")
	dk_echo(" ")
	dk_echo("EXAMPLE 1:")
	dk_echo("${blue} set(MyString1 \"the text within the string\") ${clr}")
	dk_echo("${blue} MyString1_includes(\"within\" result) ${clr}")
	dk_echo("${blue} message(STATUS \"result = \${result}\") ${clr}")
	dk_echo(" ")
	
	dk_echo(STATUS "OUTPUT 1:")
	set(MyString1 "the text within the string")
	MyString1_includes("within" result)
	dk_echo(STATUS "${blue} result = ${result} ${clr}")
	
	dk_echo(" ")
	dk_echo(" ")
	dk_echo("EXAMPLE 2:")
	dk_echo("${blue} set(MyString2 \"the text within the string\") ${clr}")
	dk_echo("${blue} MyString2_includes(\"without\" result) ${clr}")
	dk_echo("${blue} message(STATUS \"result = \${result}\") ${clr}")
	dk_echo(" ")
	
	dk_echo("OUTPUT 2:")
	set(MyString2 "the text within the string")
	MyString2_includes("without" result)
	message(STATUS "${blue} result = ${result} ${clr}")
	
	dk_echo(" ")
	dk_echo(" ")
	dk_echo("This style puts CMake closer to javascript style, which looks like this.. result = MyString.include('within', 15)")
	dk_echo("The only major differences are the dot .  is replaced with an underscore _  And instead of the function returning a value directly,")
	dk_echo("we set the return variable as the last parameter. Then we can easily check it's value right after the function completes")
endmacro()

Test_String()
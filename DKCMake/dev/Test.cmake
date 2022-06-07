# This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
#
# For the latest information, see https://github.com/aquawicket/DigitalKnob
#
# Copyright(c) 2010 - 2022 Digitalknob Team, and contributors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files(the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions :
#
# The above copyright noticeand this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

CMAKE_MINIMUM_REQUIRED(VERSION 3.10)
CMAKE_POLICY(SET CMP0007 NEW)
include(../Functions.cmake)
include(../Variables.cmake)
include(../string.cmake)

message(STATUS " ")
message(STATUS "###############################")
message(STATUS "#########  Test.cmake  ########")
message(STATUS "###############################")
message(STATUS " ")


#dk_printAllVariables()
#DKIMPORT2(https://github.com/aquawicket/DigitalKnob.zip)


dk_DownloadAll3rdParty()


macro(Test_String)
	message(STATUS "With the string.cmake class, we overwrite the set() function to intercept and \"stringify\" variables. That will add _function style macros to the variable name so we can access the function much like javascript. Instead of string.function() we use string_function(). CMake functions lack returning values directly, So, we use the last parameter as he return variable.\n")
	message(STATUS "EXAMPLE:  set(MyString \"the text within the string\")\n")
	set(MyString "the text within the string")
	message(STATUS "string.cmake will automatically listen for the set() function and use it to stringify that variable, and add string _functions to it.")
	message(STATUS "For example, now we can use the string includes() function like this...\n")
	message(STATUS "MyString_includes(\"within\" 15 result)")
	MyString_includes("within" 3 result)
	message(STATUS "result = \${result}\n")
	DKDEBUG("OUTPUT: result = ${result}\n")
	message(STATUS "This style puts CMake closer to javascript style, which looks like this.. result = MyString.include('within', 15)")
	message(STATUS "The only major differences are the dot .  is replaced with an underscore _  And instead of the function returning a value directly,")
	message(STATUS "we set the return variable as the last parameter. Then we can easily check it's value right after the function completes")
endmacro()

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

include_guard()
# string.cmake
# https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String

# https://www.w3schools.com/jsref/jsref_obj_string.asp

#####################################################
# charAt()
#
# [Syntax]: charAt()
#
# [Parameters]
#  			:
# 
#     result:
#
#charAt()


#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#
#charCodeAt()


#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#
#concat()


#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#
#constructor

#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#

#endsWith()

#####################################################
# fromCharCode()
#
# [Syntax]: String.fromCharCode(n1, n2, ..., nX)
#
# [Parameters]
#  n1, n2, nX: (required) One or more Unicode values to be converted.
# 
#      result: (string) A string representing the unicode character(s).
function(fromCharCode)
	DKDEBUGFUNC(${ARGV})
endfunction()


#####################################################
# includes()
#    [Syntax]: includes(string searchvalue start result)
# searchvalue: (required) The string to search for.
#       start: (optional) The position to start from. Default value is 0.
#      result: (boolean) true if the string contains the value, otherwise false.
#
function(includes str searchvalue) #start #result
	DKDEBUGFUNC(${ARGV})
	string(FIND "${${str}}" "${searchvalue}" index)
	if(${ARGC} GREATER 3)
		if(${index} GREATER ${ARGV2})
			set(${ARGV3} true PARENT_SCOPE)
		else()
			set(${ARGV3} false PARENT_SCOPE)
		endif()
	else()
		if(${index} GREATER -1)
			set(${ARGV2} true PARENT_SCOPE)
		else()
			set(${ARGV2} false PARENT_SCOPE)
		endif()
	endif()
endfunction()


#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#
#indexOf()


#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#
#lastIndexOf()



#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#



#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#



#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#




#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#
#length



#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#
#localeCompare()



#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#
#match()



#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#
#prototype


#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#


#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#
#repeat()


#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#
#replace()



#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#
#search()



#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#
#slice()




#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
##split()




#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
##startsWith()




#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
##substr()




#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
##substring()




#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#
#toLocaleLowerCase()



#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#
#toLocaleUpperCase()




#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#
#toLowerCase()



#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#
#toString()



#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#
#toUpperCase()




#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#
#trim()



#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#
#valueOf()





set(string_Ext OFF)
#########################################################
#  string_Ext.cmake
#
#	Add javascript like access to functions. Experamental  
#
if(string_Ext)
	execute_process(COMMAND ${CMAKE_COMMAND} -E remove ${DIGITALKNOB}/DK/DKCMake/)
	file(APPEND ${DIGITALKNOB}/DK/DKCMake/string_Ext.cmake "### Don't make changes in this file. They will not save. ###\n")
	file(APPEND ${DIGITALKNOB}/DK/DKCMake/string_Ext.cmake "### This file was automatically generated from Functions.cmake ###\n")

	function(CreateStringFunc str)
		DKDEBUGFUNC(${ARGV})
		if(0)
			cmake_language(EVAL CODE ${str}) # only available on cmake 3.18+
		else()
			file(APPEND ${DIGITALKNOB}/DK/DKCMake/string_Ext.cmake "${str}")
		endif()
	endfunction()

	set(stringified "test" CACHE INTERNAL "")
	function(stringify str)
		DKDEBUGFUNC(${ARGV})
		CreateStringFunc("macro(${str}_includes searchstr)\n	includes(${str} \${searchstr} \${ARGN})\nendmacro()\n")
		include(${DIGITALKNOB}/DK/DKCMake/string_Ext.cmake)
	endfunction()

	set(string_set TRUE)
	macro(set)
		DKDEBUGFUNC(${ARGV})
		_set(${ARGV})
		if(string_set)
			string(FIND "${stringified}" "${ARGV0}" stringified_index)
			if(${stringified_index} EQUAL -1)
				stringify(${ARGV0})
				_set(stringified ${stringified} ${ARGV0})
			endif()
		endif()
	endmacro(set)
endif()




#####################################################
# func()
#
# [Syntax]: 
#
# [Parameters]
#  			:
# 
#     result:
#
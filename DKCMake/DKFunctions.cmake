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
include($ENV{DKCMAKE}DK.cmake)

# Extra Documentation
# https://asitdhal.medium.com/cmake-functions-and-macros-22293041519f
# https://foonathan.net/2016/03/cmake-install/ 


### SETTINGS ##################################################################
set(DKTODO_ENABLED				1		CACHE INTERNAL "")
set(DKDEBUG_ENABLED				1		CACHE INTERNAL "")
set(DKDEBUGFUNC_ENABLED			0		CACHE INTERNAL "")
set(WAIT_ON_ERRORS				1		CACHE INTERNAL "")
set(WAIT_ON_WARNINGS			0		CACHE INTERNAL "")
set(HALT_ON_ERRORS				0		CACHE INTERNAL "")
set(HALT_ON_WARNINGS			0		CACHE INTERNAL "")
set(PRINT_CALL_DETAILS 			1		CACHE INTERNAL "")
set(PRINT_FILE_NAMES 			1 		CACHE INTERNAL "")
set(PRINT_LINE_NUMBERS 			1		CACHE INTERNAL "")
set(PRINT_FUNCTION_NAMES 		1 		CACHE INTERNAL "")
set(PRINT_FUNCTION_ ARGUMENTS 	1 		CACHE INTERNAL "")
set(dk_disabled_list	 		""		CACHE INTERNAL "")


###############################################################################
# dk_todo(msg)
#
#	print a TODO message and wait 10 seconds
#
#	@msg:(Optional)		A header message to print
#
macro(dk_todo)
	if(NOT DKTODO_ENABLED)
		return()
	endif()
	if(${ARGV})
		set(msg ${ARGV0})
	else()
		set(msg "TODO:")
	endif()
	dk_debug(msg)
endmacro()


###############################################################################
# TestReturnValue(args result)
#
#	Example function that uses returns value with a supplied variable 
#	Implementation: 
#		function(TestReturnValue args result)
#			set(args ${ARGV})
#			list(GET args -1 result)
#			list(REMOVE_AT args -1)
#			set(${result} ${args} PARENT_SCOPE) #just relay the arguments
#		endfunction()
#
#	Usage:
#		TestReturnValue("ABC" "123" 5 myResult)
#		message(STATUS "TestReturnValue() -> myResult = ${myResult}") # should print->  return value = ABC;123;5


###############################################################################
# CreateFunction(name contents args)
#
#	Example that creates functions dynamicaly at run time
#	Implementation:	
#		function(CreateFunction name contents) #args)
#			if(CMAKE_VERSION VERSION_LESS 3.18)
#				if(NOT extFileCleared)
#					file(WRITE functions_ext.cmake "")
#					set(extFileCleared 1 CACHE INTERNAL "")
#				endif()
#				file(APPEND functions_ext.cmake "function(${name})\n	${contents}\nendfunction()\n")
#				include(functions_ext.cmake)
#			else()
#				cmake_language(EVAL CODE "function(${name})\n	${contents}\nendfunction()\n")
#			endif()	
#		endfunction()
#
#	Usage:
#		CreateFunction(MyDynamicFunc 
#			"message(STATUS \"Test message\")") 
#			"foreach(arg IN LIST ${ARGN})
#				set(count 0) 
#				message(STATUS \"arg:${count} = ${arg}\")
#				MATH(EXPR count \"${cound}+1\")
#			endforeach()"
#			${ARGN}
#		)
#	
#	set(myVariable "myVariable")
#	MyDynamicFunc("myStringData" "My;List;Data" "${myVariable}" 17 moreData)


###############################################################################
# dk_aliasFunctions(name)
#
function(dk_aliasFunctions name)
	DKDEBUGFUNC(${ARGV})
	if(NOT EXISTS ${DKFunctions_ext})
		file(APPEND ${DKFunctions_ext} "### Don't make changes in this file. They will be overwritten. ###\n")
		file(APPEND ${DKFunctions_ext} "### This file was automatically generated from DKFunctions.cmake ###\n")
	endif()
	file(APPEND ${DKFunctions_ext} "\n## ${name} ##\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN_HOST_${name})\n   if(WIN_HOST)\n      ${name}(\${ARGV})\n  endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN32_HOST_${name})\n   if(WIN_HOST AND X86)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN64_HOST_${name})\n   if(WIN_HOST AND X64)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(UNIX_HOST_${name})\n   if(UNIX_HOST)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC_HOST_${name})\n   if(MAC_HOST)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC32_HOST_${name})\n   if(MAC_HOST AND X86)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC64_HOST_${name})\n   if(MAC_HOST AND X64)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX_HOST_${name})\n   if(LINUX_HOST)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX32_HOST_${name})\n   if(LINUX_HOST AND X86)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX64_HOST_${name})\n   if(LINUX_HOST AND X64)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	
	file(APPEND ${DKFunctions_ext} "macro(WIN_${name})\n   if(WIN)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN32_${name})\n   if(WIN_32)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN64_${name})\n   if(WIN_64)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(UNIX_${name})\n   if(NOT WIN)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(APPLE_${name})\n   if(MAC OR IOS OR IOSSIM)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC_${name})\n   if(MAC)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC32_${name})\n   if(MAC_32)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC64_${name})\n   if(MAC_64)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS_${name})\n   if(IOS AND NOT IOSSIM)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS32_${name})\n   if(IOS_32 AND NOT IOSSIM)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS64_${name})\n   if(IOS_64 AND NOT IOSSIM)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_${name})\n   if(IOSSIM)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM32_${name})\n   if(IOSSIM_32)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM64_${name})\n   if(IOSSIM_64)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX_${name})\n   if(LINUX)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX32_${name})\n   if(LINUX_32)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX64_${name})\n   if(LINUX_64)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_${name})\n   if(RASPBERRY)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY32_${name})\n   if(RASPBERRY_32)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY64_${name})\n   if(RASPBERRY_64)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID_${name})\n   if(ANDROID)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID32_${name})\n   if(ANDROID_32)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID64_${name})\n   if(ANDROID_64)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	
	if("${ARGN}" STREQUAL "NO_DEBUG_RELEASE_TAGS")
		return()
	endif()
	file(APPEND ${DKFunctions_ext} "macro(DEBUG_${name})\n   if(DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN_DEBUG_${name})\n   if(WIN AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN32_DEBUG_${name})\n   if(WIN_32 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN64_DEBUG_${name})\n   if(WIN_64 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(UNIX_DEBUG_${name})\n   if(NOT WIN AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(APPLE_DEBUG_${name})\n   if(MAC OR IOS OR IOSSIM AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC_DEBUG_${name})\n   if(MAC AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC32_DEBUG_${name})\n   if(MAC_32 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC64_DEBUG_${name})\n   if(MAC_64 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS_DEBUG_${name})\n   if(IOS AND DEBUG AND NOT IOSSIM)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS32_DEBUG_${name})\n   if(IOS_32 AND DEBUG AND NOT IOSSIM)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS64_DEBUG_${name})\n   if(IOS_64 AND DEBUG AND NOT IOSSIM)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_DEBUG_${name})\n   if(IOSSIM AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM32_DEBUG_${name})\n   if(IOSSIM_32 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM64_DEBUG_${name})\n   if(IOSSIM_64 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX_DEBUG_${name})\n   if(LINUX AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX32_DEBUG_${name})\n   if(LINUX_32 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX64_DEBUG_${name})\n   if(LINUX_64 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_DEBUG_${name})\n   if(RASPBERRY AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY32_DEBUG_${name})\n   if(RASPBERRY_32 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY64_DEBUG_${name})\n   if(RASPBERRY_64 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID_DEBUG_${name})\n   if(ANDROID AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID32_DEBUG_${name})\n   if(ANDROID_32 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID64_DEBUG_${name})\n   if(ANDROID_64 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	
	file(APPEND ${DKFunctions_ext} "macro(RELEASE_${name})\n   if(RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN_RELEASE_${name})\n   if(WIN AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN32_RELEASE_${name})\n   if(WIN_32 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN64_RELEASE_${name})\n   if(WIN_64 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(UNIX_RELEASE_${name})\n   if(NOT WIN AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(APPLE_RELEASE_${name})\n   if(MAC OR IOS OR IOSSIM AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC_RELEASE_${name})\n   if(MAC AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC32_RELEASE_${name})\n   if(MAC_32 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC64_RELEASE_${name})\n   if(MAC_64 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS_RELEASE_${name})\n   if(IOS AND RELEASE AND NOT IOSSIM)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS32_RELEASE_${name})\n   if(IOS_32 AND RELEASE AND NOT IOSSIM)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS64_RELEASE_${name})\n   if(IOS_64 AND RELEASE AND NOT IOSSIM)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_RELEASE_${name})\n   if(IOSSIM AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM32_RELEASE_${name})\n   if(IOSSIM_32 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM64_RELEASE_${name})\n   if(IOSSIM_64 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX_RELEASE_${name})\n   if(LINUX AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX32_RELEASE_${name})\n   if(LINUX_32 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX64_RELEASE_${name})\n   if(LINUX_64 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_RELEASE_${name})\n   if(RASPBERRY AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY32_RELEASE_${name})\n   if(RASPBERRY_32 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY64_RELEASE_${name})\n   if(RASPBERRY_64 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID_RELEASE_${name})\n   if(ANDROID AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID32_RELEASE_${name})\n   if(ANDROID_32 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID64_RELEASE_${name})\n   if(ANDROID_64 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
endfunction()
set(DKFunctions_ext ${DKCMAKE}/DKFunctions_ext.cmake)
file(REMOVE ${DKFunctions_ext})

###############################################################################
# dk_printAllVariables()
#
#	Print all cmake varibles
#
macro(dk_printAllVariables)
	DKDEBUGFUNC(${ARGV})
	get_cmake_property(varNames VARIABLES)
	list(SORT varNames)
	foreach(varName ${varNames})
		#message(STATUS "${varName}=${${varName}}")
		dk_info(varName)
		file(APPEND ${CMAKE_BINARY_DIR}/cmake_variables.temp "${varName}				==				${${varName}}\n")
	endforeach()
endmacro()


###############################################################################
# dk_includes(str substr result)
#
#	Test if a string contains a substring
#
#	str:(required)		The string to search 
#	substr:(required)	The substring to search for
#	result:(required)	Returns true if the str contains the substr. Otherwise returns false
#
function(dk_includes str substr result)
	#DKDEBUGFUNC(${ARGV})
	string(FIND "${str}" "${substr}" index)
	if(${index} GREATER -1)
		set(${result} true PARENT_SCOPE)
	else()
		set(${result} false PARENT_SCOPE)
	endif()
endfunction()


###############################################################################
# dk_set(variable value)
#	
#	https://stackoverflow.com/a/29250496/688352
#
#	@variable:(required)	The name of a variable to declair
#	@value:(required)		The value to set the variable to. 
#
function(dk_set variable value)
	DKDEBUGFUNC(${ARGV})
	set(${variable} ${value} ${ARGN} CACHE INTERNAL "")
	
	###### print library versions ############
	dk_includes(${variable} "_VERSION" result)
	if(${result})
		dk_info("${variable}: ${value}")
	endif()
	##########################################
endfunction()
dk_aliasFunctions("dk_set")


###############################################################################
# dk_unset(variable)
#
#	@variable:(required)
#
function(dk_unset variable)
	DKDEBUGFUNC(${ARGV})
	set(${variable} "" CACHE INTERNAL "")
	unset(${variable})
endfunction()


###############################################################################
# dk_exit()
#
macro(dk_exit)
	DKDEBUGFUNC(${ARGV})
	if(WIN_HOST)
		execute_process(COMMAND taskkill /IM cmake.exe /F WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})
	else()
		execute_process(COMMAND killall -9 cmake WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})
	endif()
endmacro()


##############################################################################
# dk_isNumber(variable result)
# 
#	Test if a varaible is a number
#
#	@variable:(required) The variable to test
#	@result: True if the variable is a number, False if otherwise.
#
macro(dk_isNumber variable result)
	DKDEBUGFUNC(${ARGV})
	if(variable MATCHES "^[0-9]+$")
		set(${result} TRUE)
	else()
		set(${result} FALSE)
	endif()
endmacro()


##############################################################################
# dk_wait()
# 
#	Wait until a keypress or timeout has elapsed in seconds
#
#	@ARGV0:timeout (Optional)(Number) default = 60
#	@ARGV1:msg     (Optional)(String) default = "press and key to continue."
#
macro(dk_wait) 
	DKDEBUGFUNC(${ARGV})
	set(argv_0 ${ARGV0})
	set(argv_1 ${ARGV1})
	
	dk_isNumber(argv_0 isNumber)
	if(isNumber)
		set(timeout ${argv_0})
	else()
		set(timeout 60) # default
	endif()
	
	if(NOT argv_1)
		set(msg "press and key to continue.") # default
	else()
		set(msg ${argv_1})
	endif()

	if(${timeout} GREATER 0)
		set(timeout_str && timeout /t ${timeout}) 
		set(msg "${msg}. Waiting ${timeout} seconds...")
	else()
		set(timeout_str && timeout /t -1) # no timeout
	endif()
	
	if(WIN_HOST)	
		execute_process(COMMAND cmd /c echo ${msg} ${timeout_str} > nul WORKING_DIRECTORY C:/)
		return()
	endif()
	if(UNIX_HOST)
		execute_process(COMMAND bash -c "read -n 1 -s -r -p \"${msg}\"" OUTPUT_VARIABLE outVar)
		return()
	endif()
	dk_error("Not implemented for this platform")
endmacro()


##############################################################################
# dk_dump(variable)
# 
#	Print the contents of a variable to the screen
#
#	@variable:(required)	The variable to print to the screen. Without variable brackets ${ }'
#
macro(dk_dump variable)
	DKDEBUGFUNC(${ARGV})
	message(STATUS "\n${cyan}############################### Variable DUMP ##############################################${CLR}")	
	if(CMAKE_CURRENT_FUNCTION_LIST_FILE)
		dk_getFilename(${CMAKE_CURRENT_FUNCTION_LIST_FILE} FILENAME)
	endif()
	if(NOT DEFINED ${variable})
		dk_error("variable not defined. The correct syntax is \"DUMP(variable_name)\", using the variable name")
		dk_error("dk_dump(variable): CORRECT SYNTAX        DUMP(\${variable}): INCORRECT SYNTAX")
	endif()
	dk_info("${FILENAME}:${CMAKE_CURRENT_FUNCTION_LIST_LINE} -> ${CMAKE_CURRENT_FUNCTION}(${ARGV})")
	list(LENGTH ${variable} variableLength)
	if(${variableLength} GREATER 1)
		set(variableType "list")
	elseif(variable MATCHES "^[0-9]+$")
		set(variableType "number")
	else()
		set(variableType "string")
	endif()
	message(STATUS "${cyan}   NAME:    ${variable} ${CLR}")
	message(STATUS "${cyan}   TYPE:    ${variableType} ${CLR}")
	message(STATUS "${cyan}   LENGTH:  ${variableLength} ${CLR}")
	message(STATUS "${cyan}   VALUE:   ${${variable}} ${CLR}")
	message(STATUS "${cyan}############################################################################################${CLR}\n")
	dk_wait()
endmacro()


##############################################################################
# dk_watch(variable)
# 
#	Watch a varible reading and writing access events
#
#	@variable:(required)	The variable to watch
#
macro(dk_watch variable)
	DKDEBUGFUNC(${ARGV})
	variable_watch(variable dk_watchCallback)
endmacro()


##############################################################################
# dk_watchCallback(variable access val 1st stack)
# 
#	Description:  TODO
#
#	@variable:(required)			The variable to watch
#	@access:(required) 		TODO
#	@val:(required) 		TODO
#   @1st:(required) 		TODO
#	@stack:(required) 		TODO
#
macro(dk_watchCallback variable access val lst stack)
	DKDEBUGFUNC(${ARGV})
	message(STATUS "${cyan}##################################################################################################${CLR}")
	message(STATUS "${cyan}   Variable watch: variable=${${variable}} access=${access} val=${val} 1st=${1st} stack=${stack}${CLR}")
	message(STATUS "${cyan}##################################################################################################${CLR}")
	dk_wait()
endmacro()


##############################################################################
# dk_setXcodeProperty(TARGET property value)
# 
#	Set a XCode specific property
#
#   @TARGET:(required)		The project target name to set the property for
#	@property:(required)	The name of the property to set
#   @value:(required)		The value to set the property to
#
macro(dk_setXcodeProperty TARGET property value)
	DKDEBUGFUNC(${ARGV})
    set_property(TARGET ${TARGET} PROPERTY XCODE_ATTRIBUTE_${property} ${value})
endmacro()


###############################################################################
# dk_deleteCache()
#
#	Delete all CMake cache files thoughout the digitalknob directory
#
function(dk_deleteCache)
	DKDEBUGFUNC(${ARGV})
	dk_info("Deleteing CMake cache . . .")
	dk_file_getDigitalknobPath(DIGITALKNOB)
	if(WIN_HOST)
		dk_executeProcess(for /r %%i in (CMakeCache.*) do del "%%i" WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(for /d /r %%i in (*CMakeFiles*) do rd /s /q "%%i" WORKING_DIRECTORY ${DIGITALKNOB})
	else()
		dk_executeProcess(find . -name "CMakeCache.*" -delete WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess("rm -rf `find . -type d -name CMakeFiles`" WORKING_DIRECTORY ${DIGITALKNOB})
	endif()
endfunction()


###############################################################################
# dk_deleteTempFiles()
#
#	Delete all .tmp files recursivly thoughout the digitalknob directory
#
function(dk_deleteTempFiles)
	DKDEBUGFUNC(${ARGV})
	dk_info("Deleteing Temporary files . . .")
	dk_file_getDigitalknobPath(DIGITALKNOB)
	if(WIN_HOST)
		dk_executeProcess(for /r %%i in (*.TMP) do del "%%i" WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(for /r %%i in (*.tmp) do del "%%i" WORKING_DIRECTORY ${DIGITALKNOB})
	else()
		dk_executeProcess("rm -rf `find . -name *.tmp`" WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(find . -name "*.TMP" -delete WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(find . -name "*.tmp" -delete WORKING_DIRECTORY ${DIGITALKNOB})
		
	endif()
endfunction()


###############################################################################
# dk_deleteEmptyDirectories(path)
#
#	Delete all empty directories with a path
#
#	@path:(required)	The path to search for empty folders to delete
#
function(dk_deleteEmptyDirectories path)
	DKDEBUGFUNC(${ARGV})
	if(NOT EXISTS ${path})
		dk_error("path:${path} does not exist")
		return()
	endif()
	if(WIN_HOST)
		execute_process(COMMAND for /f "delims=" %d in ('dir /s /b /ad ^| sort /r') do rd "%d" WORKING_DIRECTORY ${path})
	else()
		dk_error("Not implemented for this platform")
	endif()
endfunction()


###############################################################################
# dk_getEnv(name result)
#
#	Get a system environment variable
#
#	@name:(required)	The name of the system environment variable to get
#	@result:			Returns the value of the system environment vairable
#
function(dk_getEnv name result)
	DKDEBUGFUNC(${ARGV})
	#dk_debug("ENVname = $ENV{${name}}")
	dk_debug(ENV{${name}})
	set(${result} $ENV{${name}} PARENT_SCOPE)
endfunction()


###############################################################################
# dk_download(src_path dest_path)
#
#	Download a file
#
#	@src_path:(required)	The url of the file to download
#	@dest_path:(required)	The path to download the file to
#
#	Notes: https://cmake.org/pipermail/cmake/2012-September/052205.html/
#
function(dk_download src_path dest_path) # ARGV1 = dest_path
	DKDEBUGFUNC(${ARGV})
	#FIXME: Will not download if only 1 argument
	#TODO: Let's supply the ability to add a primary root address to download from,  for fast downloading from local hard drives or storage 
	#      we will also add a "backup" root address to download from. In case one of the internet download fails.
	#      Also, we will treat the url variable like a list. If it has more one item, treat them as alternative download links
#	if(NOT PrimaryDownloadServer)
#		dk_info("TODO: just set PrimaryDownloadServer to your mirror location and all file downoads will attempt that location first")
#	endif()
#	if(NOT SecondaryDownloadServer)
#		dk_info("TODO: just set SecondaryDownloadServer to your mirror location and all file downoads that fail will attempt secondary location next")
#	endif()
	
	# Setup all src_path variables
	if(NOT src_path)
		dk_assert("src_path is invalid")
		return()
	endif()
	#dk_debug("src_path = ${src_path}")
	dk_debug(src_path)
	
	get_filename_component(src_dir ${src_path} DIRECTORY)
	if(NOT src_dir)
		dk_assert("src_dir is invalid")
		return()
	endif()
	#dk_debug("src_dir = ${src_dir}")
	dk_debug(src_dir)
	
	get_filename_component(src_filename ${src_path} NAME)
	if(NOT src_filename)
		dk_assert("src_filename is invalid")
		return()
	endif()
	#dk_debug("src_filename = ${src_filename}")
	dk_debug(src_filename)
	
	dk_getExtension(${src_path} src_ext)	
	if(NOT src_ext)
		dk_assert("src_ext is invalid")
		return()
	endif()
	#dk_debug("src_ext = ${src_ext}")
	dk_debug(src_ext)
	
	# Setup all dest_path variables
	if(NOT dest_path)
		set(dest_path ${DKDOWNLOAD})
	endif()
	if(NOT dest_path)
		dk_assert("dest_path is invalid")
		return()
	endif()	
	if(IS_DIRECTORY ${dest_path})
		set(dest_path "${dest_path}/${src_filename}")
	endif()
	#dk_debug("dest_path = ${dest_path}")
	dk_debug(dest_path)
	
	get_filename_component(dest_dir ${dest_path} DIRECTORY)
	if(NOT dest_dir)
		dk_assert("dest_dir is invalid")
		return()
	endif()
	if(NOT EXISTS ${dest_dir})
		dk_warn("dest_dir:(${dest_dir}) does not exists. It will be created")
		dk_makeDirectory(${dest_dir})
	endif()
	dk_set(CURRENT_DIR ${dest_dir})
	#dk_debug("dest_dir = ${dest_dir}")
	dk_debug(dest_dir)
	
	get_filename_component(dest_filename ${dest_path} NAME)
	if(NOT dest_filename)
		dk_assert("dest_filename is invalid")
		return()
	endif()
	#dk_debug("dest_filename = ${dest_filename}")
	dk_debug(dest_filename)
	
	dk_getExtension(${dest_path} dest_ext)
	if(NOT dest_ext)
		dk_assert("dest_ext is invalid")
		return()
	endif()
	#dk_debug("dest_ext = ${dest_ext}")
	dk_debug(dest_ext)
	
	if(EXISTS ${dest_path})
		dk_warn("dest_path:(${dest_path}) already exists")
		return()
	endif()
	
	dk_debug("Downloading ${src_path}")
	dk_debug("      To -> ${dest_path}")
	
	# setup temp_path variables
	set(temp_filename "${dest_filename}.downloading")
	set(temp_path ${dest_dir}/${temp_filename})
	#dk_debug("temp_path = ${temp_path}")
	dk_debug(temp_path)
	if(EXISTS ${temp_path})
		file(REMOVE ${temp_path})
	endif()
	if(EXISTS ${temp_path})
		dk_assert("temp_path:(${temp_path}) could not be removed")
		return()
	endif()
	
	dk_info("Downloading ${src_filename}. . . please wait")
	file(DOWNLOAD ${src_path} ${temp_path} 
		SHOW_PROGRESS 
		INACTIVITY_TIMEOUT 60
		STATUS status 
	)
	list(GET status 0 status_code) 
	list(GET status 1 status_string)
	if(NOT status_code EQUAL 0)
		file(REMOVE ${temp_path})
		dk_assert("error: downloading ${src_path} \nstatus_code: ${status_code} \nstatus_string: ${status_string}")
	else()
		if(NOT EXISTS ${temp_path})
			dk_assert("temp_path:(${temp_path}) could not locate temporary download file")
			return()
		endif()
		dk_rename(${temp_path} ${dest_path} false)
		if(NOT EXISTS ${dest_path})
			dk_assert("dest_path:(${dest_path}) Could not locate downloaded file")
			return()
		endif()
		dk_info("Finnished downloading ${dest_filename}")
	endif() 
endfunction()
dk_aliasFunctions("dk_download")


###############################################################################
# dk_extract(src dest)
#
function(dk_extract src dest)
	DKDEBUGFUNC(${ARGV})
	if(NOT EXISTS ${dest})
		dk_makeDirectory(${dest})
	endif()
	if(NOT EXISTS ${CMAKE_COMMAND})
		dk_assert("CMAKE_COMMAND not found: \${CMAKE_COMMAND} = ${CMAKE_COMMAND}")
	endif()
	dk_executeProcess(${CMAKE_COMMAND} -E tar xvf ${src} WORKING_DIRECTORY ${dest})
endfunction()


###############################################################################
# dk_zip(path)
#
function(dk_zip path)
	DKDEBUGFUNC(${ARGV})
	dk_info("Zipping: ${path}")
	if(NOT EXISTS ${path})
		dk_assert("The path ${path} does not exist")
	endif()
	execute_process(COMMAND ${CMAKE_COMMAND} -E tar "cfv" "${DKPROJECT}/assets.zip" --format=zip "." WORKING_DIRECTORY ${path}/)
endfunction()


###############################################################################
# dk_copy(from to overwrite)
#
function(dk_copy from to overwrite)
	DKDEBUGFUNC(${ARGV})
	if(EXISTS ${from})
		if(IS_DIRECTORY ${from})
			file(GLOB_RECURSE allfiles RELATIVE "${from}/" "${from}/*")
			foreach(each_file ${allfiles})
				if(${each_file} STREQUAL "DKMAKE.cmake")
					continue()
				endif()
				if(${each_file} STREQUAL "DKMAKE.cmake.BACKUP")
					continue()
				endif()
				set(sourcefile "${from}/${each_file}")
				set(destinationfile "${to}/${each_file}")
				if(overwrite)
					execute_process(COMMAND ${CMAKE_COMMAND} -E compare_files ${sourcefile} ${destinationfile} RESULT_VARIABLE compare_result)
					if(compare_result EQUAL 1)
						execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${sourcefile} ${destinationfile})
						dk_info("COPIED: ${sourcefile} to ${destinationfile}")
					elseif(compare_result EQUAL 0)
#						dk_info("${sourcefile} No Copy, The files are identical.")
					else()
						dk_warn( "dk_copy(${from} ${to} ${overwrite}): \n ERROR: compare_result = ${compare_result}")
					endif()
				elseif(NOT EXISTS ${destinationfile})
					execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${sourcefile} ${destinationfile})
					dk_info("COPIED: ${sourcefile} to ${destinationfile}")
				endif()
			endforeach()
		else()
			if(overwrite)
				execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${from} ${to})
				dk_info("COPIED: ${from} to ${to}")
			elseif(NOT EXISTS ${to})
				execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${from} ${to})
				dk_info("COPIED: ${from} to ${to}")
			endif()
		endif()
	else()
		dk_warn("from:(${from}) The source path does not exist")
	endif()
endfunction()


###############################################################################
# dk_filesMatch(fileA fileB)
#
function(dk_filesMatch fileA fileB)
	DKDEBUGFUNC(${ARGV})
	execute_process(COMMAND ${CMAKE_COMMAND} -E compare_files ${fileA} ${fileB} RESULT_VARIABLE compare_result)
	if(compare_result EQUAL 0)
		dk_info("The files are identical.")
	elseif(compare_result EQUAL 1)
		dk_info("The files are different.")
	else()
		dk_info("Error while comparing the files.")
	endif()
endfunction()


###############################################################################
# dk_rename(from to overwrite)
#
function(dk_rename from to overwrite)
	DKDEBUGFUNC(${ARGV})
	dk_info("Renameing ${from} to ${to}")
	if(EXISTS ${from})
		dk_assert("from:${from} not found")
		return()
	endif()
	if(EXISTS ${to})
		if(NOT ${overwrite})
			dk_assert("Cannot rename file. Destiantion exists and not set to overwrite")
			return()
		endif()
		file(REMOVE ${to})
	endif()
	file(RENAME ${from} ${to})
endfunction()


###############################################################################
# dk_remove(path)
#
function(dk_remove path)
	DKDEBUGFUNC(${ARGV})
	if(NOT EXISTS ${path})
		dk_warn("Path:(${path}) does not exist")
		return()
	endif()
	
	file(REMOVE ${path})
	return()
	
	
	if(IS_DIRECTORY ${path})
		execute_process(COMMAND ${CMAKE_COMMAND} -E remove_directory ${path})
	else()
		execute_process(COMMAND ${CMAKE_COMMAND} -E remove ${path})
	endif()
endfunction()


###############################################################################
# dk_upxCompress(path)
#
function(dk_upxCompress path)
	DKDEBUGFUNC(${ARGV})
	dk_info("UPX compressing ${path}...")
	dk_info("Please wait...")
	dk_executeProcess("${UPX_EXE} -9 -v ${path}")
endfunction()


###############################################################################
# dk_enable(plugin)
#	
function(dk_enable plugin)
	DKDEBUGFUNC(${ARGV})
	if(NOT ${plugin})
		if(${ARGC} GREATER 1)
			dk_set(${${ARGV1}} ON)
			dk_set(HAVE_${${ARGV1}} ON)
			# In c++ we can't use certian symbals in the preprocess or for macros. - must be turned to _
			string(REPLACE "-" "_" argv1_macro "${ARGV1}")
			string(REPLACE "." "_" argv1_macro "${argv1_macro}")
			dk_define(HAVE_${argv1_macro})
		else()
			dk_set(${plugin} ON)
			dk_set(HAVE_${plugin} ON)
			# In c++ we can't use certian symbals in the preprocess or for macros. - must be turned to _
			string(REPLACE "-" "_" plugin_macro "${plugin}")
			string(REPLACE "." "_" plugin_macro "${plugin_macro}")
			dk_define(HAVE_${plugin_macro})
		endif()
	endif()
endfunction()


###############################################################################
# dk_disable(plugin)
#
function(dk_disable plugin)
	DKDEBUGFUNC(${ARGV})
	if(BYPASS_DISABLE)
		dk_info("* dk_disable(${plugin}) ignored.  BYPASS_DISABLE is set to ON. ${plugin} will not be disabled *")
		return()
	endif()
	if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKCMAKE} AND NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKPROJECT}) # /from DKCMake or curremt Project directory only
		dk_assert("dk_disable() Can only be used from the DKCMake/DKDisabled.cmake file. This is to avoid having disabled libraries hideing everywhere")
	endif()
	
	if(NOT EXISTS ${DKIMPORTS}/${plugin}/DKMAKE.cmake)
	if(NOT EXISTS ${DKPLUGINS}/${plugin}/DKMAKE.cmake)
		dk_warn("dk_disable(${plugin}):  unable to locate plugin in /3rdParty/_DKIMPORTS  or /DKPlugins")
		return()
	endif()
	endif()
	
	if(${ARGC} GREATER 1)
		dk_unset(${ARGV1})
		dk_unset(HAVE_${ARGV1})
		# In c++ we can't use certian symbals in the preprocess or for macros. - must be turned to _
		string(REPLACE "-" "_" argv1_macro "${ARGV1}")
		dk_undefine(HAVE_${argv1_macro})
		dk_undepend(${ARGV1})
	else()
		dk_unset(${plugin})
		dk_unset(HAVE_${plugin})
		# In c++ we can't use certian symbals in the preprocess or for macros. - must be turned to _
		string(REPLACE "-" "_" plugin_macro "${plugin}")
		dk_undefine(HAVE_${plugin_macro})
		dk_undepend(${plugin})
	endif()
endfunction()


###############################################################################
# dk_define(str)
#
function(dk_define str)
	DKDEBUGFUNC(${ARGV})
	if(CMAKE_SCRIPT_MODE_FILE)
		return()
	endif()
	list(FIND DKDEFINES_LIST "${str}" index)
	if(${index} GREATER -1)
		return() # already in the list, return.
	endif()
	dk_set(DKDEFINES_LIST ${DKDEFINES_LIST} ${str})
	add_definitions(-D${str})
endfunction()
dk_aliasFunctions("dk_define")


###############################################################################
# dk_undefine(str)
#
function(dk_undefine str)
	DKDEBUGFUNC(${ARGV})
	if(NOT DKDEFINES_LIST)
		return()
	endif()
	list(REMOVE_ITEM DKDEFINES_LIST ${str})
	remove_definitions(-D${str})
endfunction()


###############################################################################
# dk_include(path)
#
#	Add a directory to the compiler include paths
#
#	@path:(required)	The path to add to the compiler include paths
#
function(dk_include path)
	DKDEBUGFUNC(${ARGV})
	foreach(item ${ARGV})
		list(FIND DKINCLUDES_LIST "${item}" index)
		if(${index} GREATER -1)
			continue()  # item is already in the list
		endif()
		dk_set(DKINCLUDES_LIST ${DKINCLUDES_LIST} ${item})
		include_directories(${item})
		
		if(INSTALL_DKLIBS)
			dk_getFilename(${CMAKE_CURRENT_LIST_DIR} LIB_NAME)
			file(INSTALL DIRECTORY ${path}/ DESTINATION ${CMAKE_INSTALL_PREFIX}/${LIB_NAME}/include FILES_MATCHING PATTERN "*.h")
		endif()
	endforeach()
endfunction()
dk_aliasFunctions("dk_include")


###############################################################################
# dk_linkDir(path)
#
#	Add a directory to the compiler library paths
#
#	@path:(required)	The path to add to the compiler library paths
#
function(dk_linkDir path)
	DKDEBUGFUNC(${ARGV})
	foreach(item ${ARGV})
		list(FIND DKLINKDIRS_LIST "${item}" index)
		if(${index} GREATER -1)
			continue()  # item is already in the list
		endif()
		dk_set(DKLINKDIRS_LIST ${DKLINKDIRS_LIST} ${item})
		link_directories(${item})
	endforeach()
endfunction()
dk_aliasFunctions("dk_linkDir")


###############################################################################
# dk_getCurrentDirectory(result)
#
#	Retrieve the current working directory
#
#	@result: returns the current working directory upon success. False upon error
#
#function(dk_getCurrentDirectory result)
#	DKDEBUGFUNC(${ARGV})
#	if(WIN_HOST)
#		execute_process(COMMAND echo "hello world" ECHO_OUTPUT_VARIABLE output WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
#	else()
#		execute_process(COMMAND pwd ECHO_OUTPUT_VARIABLE output WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
#	endif()
#	execute_process(COMMAND timeout /t 2 /nobreak WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})  ##wait 2 seconds for the stdout to flush
#	#dk_info("output = ${output}")
#	dk_info(output)
#	set(${result} ${output} PARENT_SCOPE)
#endfunction()


###############################################################################
# dk_makeDirectory(path)
#
#	Create a directory 
#
#	@path:(required)	The full path to the direcotory to be created
#
function(dk_makeDirectory path)
	DKDEBUGFUNC(${ARGV})
	make_directory(${path})  # requires full path
	return()
	
	# build missing directory parents recursivley
#	if(MAC_HOST)
#		file(RELATIVE_PATH rel_path "${DIGITALKNOB}/DK" ${path})
#		dk_info("RELATIVE_PATH(${path}) OF (${DIGITALKNOB}/DK) =-> ${rel_path}")
#		dk_info("MAKE_DIRECTORY ${rel_path}")
#		file(MAKE_DIRECTORY ${rel_path})
#	else()
#		string(REPLACE "/" ";" path_list ${path})
#		foreach(item ${path_list})
#			string(REPLACE "home" "/home" item ${item})
#			if(path2)
#				set(path2 "${path2}/${item}")
#				if(NOT EXISTS ${path2})
#					file(MAKE_DIRECTORY ${path2})
#				endif()
#			else()
#				set(path2 "${item}")
#			endif()
#		endforeach()
#	endif()
endfunction()


###############################################################################
# dk_getDirectory(path result)
#
#	Get the directory portion of a path
#
#	@path:(required)	The path to use
#	@result:	Returns the directory upon success: False upon error
#
function(dk_getDirectory path result)
	DKDEBUGFUNC(${ARGV})
	string(FIND ${path} "/" index REVERSE)
	if(${index} EQUAL -1)
		return() # no path dividers found
	endif()
	string(SUBSTRING ${path} 0 ${index} directory) 
    set(${result} ${directory} PARENT_SCOPE)
endfunction()


###############################################################################
# dk_getFilename(path result)
#
#	Get the filename portion of a path
#
#	@path:(required) The path to use
#	@result:	Returns the file name upon success: False upon error
#
function(dk_getFilename path result)
	DKDEBUGFUNC(${ARGV})
	string(FIND ${path} "/" index REVERSE)
	if(${index} EQUAL -1)
		dk_assert("No Path Dividers found")
		return()
	endif()
	MATH(EXPR index "${index}+1")
	string(SUBSTRING ${path} ${index} -1 filename) 
    set(${result} ${filename} PARENT_SCOPE)
endfunction()


###############################################################################
# dk_getExtension(path result)
#
#	Get the extension portion of a path
#
#	@path:(required) The path to use
#	@result:	Returns the extension upon success: False upon error
#
function(dk_getExtension path result)
	DKDEBUGFUNC(${ARGV})
	# WHY A NEW GET EXTENSION FUNCTION ?
#	get_filename_component(extension ${url} EXT)       #Gets the large part of the extension of everything after the first .
#	get_filename_component(extension ${url} LAST_EXT)  #LAST_EXT only available with cmake 3.14+ 
#	cmake_path(GET url EXTENSION LAST_ONLY extension)  #LAST_ONLY only available with cmake 3.19+
	string(FIND ${path} "." index REVERSE)
	if(${index} EQUAL -1)
		return() # no extension found
	endif()
	string(SUBSTRING ${path} ${index} -1 ext) 
    set(${result} ${ext} PARENT_SCOPE)
endfunction()


###############################################################################
# dk_dirIsEmpty(path result)
#
#	Get weather or not a directory is empty
#
#	@path: The full path to the directory to check
#	@result: Returns true if the directory is empty. False if the directory is not empty
#
function(dk_dirIsEmpty path result)
	DKDEBUGFUNC(${ARGV})
	if(EXISTS ${path})
		file(GLOB items RELATIVE "${path}/" "${path}/*")
		list(LENGTH items count)
		if(${count} GREATER 0)
			set(${result} false PARENT_SCOPE)
			return()
		endif()
	endif()
	set(${result} true PARENT_SCOPE)
endfunction()


###############################################################################
# dk_refreshIcons()
#
#	Refresh the icons on a windows operating system
#
function(dk_refreshIcons)
	DKDEBUGFUNC(${ARGV})
	dk_executeProcess(ie4uinit.exe -ClearIconCache)
	dk_executeProcess(ie4uinit.exe -show)	# Windows 10
endfunction()


###############################################################################
# dk_patch(import_name dest_path)
#
#	Copy files from a DK/3rdParty/_DKIMPORTS/library to the DK/3rdParty/library install location
#
#	@import_name:(required)	The name of the 3rdParty DKIMPORT library
#	@dest_path:(required)	The location of the installed library under /3rdParty
#
function(dk_patch import_name dest_path)
	DKDEBUGFUNC(${ARGV})
	dk_warn("COPYING PATCH FILES FROM _IMPORTS/${import_name} TO ${dest_path}")
	dk_warn("To stop patch files from overwriting install files, remove the \"PATCH\" argument from the end of the DKIMPORT or dk_install command")
	dk_warn("located in ${DKIMPORTS}/${import_name}/DKMAKE.cmake")
	dk_copy(${DKIMPORTS}/${import_name}/ ${dest_path}/ TRUE)
endfunction()


###############################################################################
# dk_install(src_path import_name dest_path)
#
#	Install a 3rdParty library, executable or package
#	For archive files such as libraries and assets, the arguments are:  The download src_path, the name of its _DKIMPORTS folder, The name given to the installed 3rdParty/folder  
#	For executable files such as software amd IDE's the arguments are:  The download src_path, the name of the final name of the dl file, The installation path to check for installation.
#
#	@src_path:(required)	The download url or local path to an install file. May be .zip, .exe, .msi, .tar.gz etc. 
#	@import_name:(required)	The name of the 3rdParty package being installed
#	@dest_path:(required)	The path to the install location under DK/3rdParty
#
function(dk_install src_path import_name dest_path)
	DKDEBUGFUNC(${ARGV})
	dk_info(" ")
	string(TOLOWER ${import_name} import_name_lower)
	if(NOT ${import_name} STREQUAL ${import_name_lower})
		dk_assert("ERROR: 2nd parameter in dk_install() (${import_name}) must be all lowercase")
	endif()
	
	if(NOT EXISTS ${DKIMPORTS}/${import_name})
		dk_assert("ERROR: 2nd parameter in dk_install() (${DKIMPORTS}/${import_name}) does not exist")
	endif()
	if(EXISTS ${dest_path}/installed)
		dk_info("${import_name} already installed")
		if("${ARGN}" STREQUAL "PATCH")
			dk_patch(${import_name} ${dest_path})
		endif()
		return()
	endif()
	dk_debug(" ")
	dk_debug(src_path)
	dk_getDirectory(${src_path} src_directory)
	dk_debug(src_directory)
	dk_getFilename(${src_path} src_filename)
	dk_debug(src_filename)
	dk_getExtension(${src_filename} src_extension)
	dk_debug(src_extension)
	dk_debug(" ")
	dk_debug(dest_path)
	dk_getDirectory(${dest_path} dest_directory)
	dk_debug(dest_directory)
	dk_getFilename(${dest_path} dest_filename)
	dk_debug(dest_filename)
	dk_getExtension(${dest_filename} dest_extension)
	dk_debug(dest_extension)
	dk_debug(" ")
	
	# let's check that the scr_filename has at least the name of the target in it somewhere, or else we gotta rename it
	string(TOLOWER ${src_filename} src_filename_lower)
	string(FIND ${src_filename_lower} ${import_name} index)
	#dk_includes(${src_filename_lower} ${import_name} result)
	if(${index} EQUAL -1)
	#if(NOT ${result})
		dk_debug("The download filename ${src_filename} does not contaian the import name ${import_name}")
		string(TOLOWER ${dest_filename} dest_filename_lower)
		string(FIND ${dest_filename_lower} ${import_name} index)
		#dk_includes(${dest_filename_lower} ${import_name} result)
		#if(NOT ${result})
		if(${index} EQUAL -1)
			set(dl_filename "${import_name}-${dest_filename}${src_extension}") 
		else()
			set(dl_filename "${dest_filename}${src_extension}")
		endif()
	elseif(NOT ${src_filename} MATCHES "[0-9]")
		dk_debug("The download filename ${src_filename} does not contain any numbers to identify it's version")
		dk_debug("Normally we would rename the downloaded filename to ${dest_filename}${src_extension}, but we'll let it pass.")
# 		set(dl_filename "${dest_filename}${src_extension}")
		set(dl_filename ${src_filename})
	else()
		set(dl_filename ${src_filename})
	endif()
	
	dk_download(${src_path} ${DKDOWNLOAD}/${dl_filename})
	if(NOT EXISTS ${DKDOWNLOAD}/${dl_filename})
		dk_assert("The download files does not exist")
		return()
	endif()
	
	set(FILETYPE "UNKNOWN")
	if(NOT ${src_extension} STREQUAL "")
		if(${src_extension} STREQUAL ".bz")
			set(FILETYPE "Archive")
		elseif(${src_extension} STREQUAL ".bz2")
			set(FILETYPE "Archive")
		elseif(${src_extension} STREQUAL ".exe")
			string(FIND ${src_filename} ".sfx.exe" index)
			#dk_includes(${src_filename} ".sfx.exe" result)
			#if(${result})
			if(${index} GREATER -1)
				set(FILETYPE "Archive")
			else()
				set(FILETYPE "Executable")
			endif()
		elseif(${src_extension} STREQUAL ".gz")
			set(FILETYPE "Archive")
		elseif(${src_extension} STREQUAL ".js")
			set(FILETYPE "Javascript")
		elseif(${src_extension} STREQUAL ".rar")
			set(FILETYPE "Archive")
		elseif(${src_extension} STREQUAL ".tar")
			set(FILETYPE "Archive")
		elseif(${src_extension} STREQUAL ".xz")
			set(FILETYPE "Archive")
		elseif(${src_extension} STREQUAL ".zip")
			set(FILETYPE "Archive")
		elseif(${src_extension} STREQUAL ".AppImage")
			set(FILETYPE "Executable")
		endif()
	endif()
	# If the file type is unknown, we'll still try to extract it like a compressed file anyway
	# It's better the have a chance at success.
	dk_debug("The Downloaded file ${${dl_filename}} is a ${FILETYPE} file ${src_extension}")
	if(${FILETYPE} STREQUAL "UNKNOWN")
		set(FILETYPE "Archive")
		dk_debug("We will try to extract it in case it's an archive, but it may fail.")
	endif()
	if(${FILETYPE} STREQUAL "Archive")
		file(REMOVE ${DKDOWNLOAD}/UNZIPPED)
		dk_extract(${DKDOWNLOAD}/${dl_filename} ${DKDOWNLOAD}/UNZIPPED)
		# We either have a root folder in /UNZIPPED, or multiple files without a root folder
		file(GLOB items RELATIVE "${DKDOWNLOAD}/UNZIPPED/" "${DKDOWNLOAD}/UNZIPPED/*")
		list(LENGTH items count)
		if(${count} GREATER 2) ##NOTE: This should be "${count} GREATER 1" but msys has a readme file in it next to the inner msys folder and that messes things up for more than 1
			#vZip extracted with no root folder, Rename UNZIPPED and move to 3rdParty
			dk_rename(${DKDOWNLOAD}/UNZIPPED ${dest_path} true)
		else()
			if(EXISTS ${DKDOWNLOAD}/UNZIPPED/${dest_filename}) ##Zip extracted to expected folder. Move the folder to 3rdParty
				dk_rename(${DKDOWNLOAD}/UNZIPPED/${dest_filename} ${dest_path} true)
				file(REMOVE ${DKDOWNLOAD}/UNZIPPED)
			else() #vZip extracted to a root folder, but not named what we expected. Rename and move folder to 3rdParty
				foreach(item ${items})
					if(NOT IS_DIRECTORY ${DKDOWNLOAD}/UNZIPPED/${item})
						list(REMOVE_ITEM items ${item}) #remove any readme.txt or other non-directory items
					endif()
				endforeach()
				dk_rename(${DKDOWNLOAD}/UNZIPPED/${items} ${dest_path} true)
				file(REMOVE ${DKDOWNLOAD}/UNZIPPED)
			endif() 
		endif()
#	elseif(${FILETYPE} STREQUAL "Executable")
#		dk_setPath(${DKDOWNLOAD})
#		dk_set(QUEUE_BUILD ON)
#		DKEXECUTE(${DKDOWNLOAD}/${src_filename})
	else() #NOT ARCHIVE, just copy the file into it's 3rdParty folder
		dk_copy(${DKDOWNLOAD}/${dl_filename} ${dest_path}/${dl_filename} TRUE)
	endif()
	if("${ARGN}" STREQUAL "PATCH")
		dk_patch(${import_name} ${dest_path})
	else()
		file(GLOB ITEMS ${DKIMPORTS}/${import_name}/*)
		list(LENGTH ITEMS count)
		dk_debug(${count})
		if(${count} GREATER 1)
			dk_warn(" Found ${count} items in the ${import_name} import folder. dk_install has not requested to PATCH the installed files. If needed, add PATCH as the last argument to the dk_install or dk_import command in ${DKIMPORTS}/${import_name}/DKMAKE.cmake ")
		endif()
	endif()
	file(WRITE ${dest_path}/installed "${dest_filename} ")
endfunction()
dk_aliasFunctions("dk_install" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_validatePath(path result)
#
function(dk_validatePath path result)
	DKDEBUGFUNC(${ARGV})
	get_filename_component(path ${path} ABSOLUTE)
	set(${result} ${path} PARENT_SCOPE)
endfunction()


###############################################################################
# dk_getShortPath(path result)
#
function(dk_getShortPath path result)
	DKDEBUGFUNC(${ARGV})
	if(WIN_HOST)
		file(WRITE ${DKCMAKE}/dk_getShortPath.cmd "@ECHO OFF \necho %~s1")
		execute_process(COMMAND ${DKCMAKE}/dk_getShortPath.cmd ${path} OUTPUT_VARIABLE path WORKING_DIRECTORY ${DIGITALKNOB})
		string(REPLACE "\\" "/" path ${path})
		string(REPLACE "\n" "" path ${path})
		set(${result} ${path} PARENT_SCOPE)
	endif()
endfunction()
# TEST_dk_getShortPath
# dk_getShortPath("C:/Program Files (x86)/CMake/bin/cmake.exe" result)
# dk_dump(result)


###############################################################################
# dk_executeProcess(commands)
#
function(dk_executeProcess commands)
	DKDEBUGFUNC(${ARGV})
	set(commands ${ARGV})
	list(REMOVE_ITEM commands COMMAND) # we can supply the cmake specific base commands
	list(REMOVE_ITEM commands "cmd /c ")
	
	list(FIND commands "WORKING_DIRECTORY" index)
	if(index EQUAL -1)
		set(command ${commands} WORKING_DIRECTORY ${CURRENT_DIR}) # add WORKING_DIRECTORY if missing
	endif()	
	
	#dk_info("")
	#dk_info("*** dk_executeProcess ***")
	dk_info("\n-> ${commands}\n")
	#dk_info("")
	
	if(WIN_HOST)
		execute_process(COMMAND cmd /c ${commands} RESULT_VARIABLE result ERROR_VARIABLE error) # FIXME: Do we always need  cmd /c  here?
	else()
		execute_process(COMMAND ${commands} RESULT_VARIABLE result ERROR_VARIABLE error)
	endif()
	if(NOT ${result} EQUAL 0)
		if(WIN_HOST)
			execute_process(COMMAND timeout /t 2 /nobreak OUTPUT_QUIET WORKING_DIRECTORY ${CURRENT_DIR}) # wait 2 seconds for the stdout to flush before printing error
		else()
			execute_process(COMMAND sleep 2 WORKING_DIRECTORY ${CURRENT_DIR}) # wait 2 seconds for the stdout to flush before printing error
		endif()
		dk_assert("ERROR: command=${commands}\n  result=${result}\n   error=${error}")
	endif()
endfunction()


###############################################################################
# dk_setEnv(name value)
#
#	Set a system environment variable
#
#	@name:(required)	The name of the system environment variable to set
#	@value:(required)	The value to set the system environment vairable to
#
function(dk_setEnv name value)
	DKDEBUGFUNC(${ARGV})
	#dk_debug("ENVname = $ENV{${name}}")
	dk_debug(ENV{${name}})
	if(ENV{${name}})
		string(FIND $ENV{${name}} ${value} index)
	else()
		set(index -1)
	endif()
	
	if(${index} EQUAL -1)
		#dk_debug("ENV{${name}} = $ENV{${name}}")
		dk_debug(ENV{${name}})
		#dk_debug("value = ${value}")
		dk_debug(value)
#		if(NOT "$ENV{${name}}" STREQUAL "${value}")
		if(WIN_HOST)
			dk_info("Setting %${name}% environment variable to ${value}")
			set(ENV{${name}} ${value})
			#dk_executeProcess(setx ${name} ${value}) # https://stackoverflow.com/a/69246810		#FIXME
			execute_process(COMMAND cmd /c setx ${name} ${value}) # https://stackoverflow.com/a/69246810
		else()
			dk_error("dk_setEnv() not implemented on this system")
		endif()
	endif()
endfunction()


###############################################################################
# dk_setPath(path)
#
function(dk_setPath path)
	DKDEBUGFUNC(${ARGV})
	if(path STREQUAL "OFF")
		return() 
	endif()	
	dk_set(CURRENT_DIR ${path})
	if(NOT EXISTS ${CURRENT_DIR})
		dk_info("Creating directory: ${CURRENT_DIR})")
		dk_makeDirectory(${CURRENT_DIR})
	endif()
	
	# TODO https://stackoverflow.com/a/6595001/688352
	# NOTE: Some 3rdParty projects break when their binary output path is changed. It may be better to compile the project normally, then do a library install to a final common location 
#	if(WIN_HOST)
#		foreach(item ${DKCMAKE_BUILD})
#			#string(FIND "${item}" "-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY=" index)
#			dk_includes("${item}" "-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY=" result)
#			#if(${index} GREATER -1)
#			if(${result})
#				list(REMOVE_ITEM DKCMAKE_BUILD ${item})
#			endif()
#	
#			#string(FIND "${item}" "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=" index)
#			dk_includes("${item}" "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=" result)
#			#if(${index} GREATER -1)
#			if(${result})
#				list(REMOVE_ITEM DKCMAKE_BUILD ${item})
#			endif()
#		
#			#string(FIND "${item}" "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=" index)
#			dk_includes("${item}" "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=" result)
#			#if(${index} GREATER -1)
#			if(${result})
#				list(REMOVE_ITEM DKCMAKE_BUILD ${item})
#			endif()
#		endforeach()
#		dk_set(DKCMAKE_BUILD ${DKCMAKE_BUILD} -DCMAKE_ARCHIVE_OUTPUT_DIRECTORY=${CURRENT_DIR} -DCMAKE_LIBRARY_OUTPUT_DIRECTORY=${CURRENT_DIR} -DCMAKE_RUNTIME_OUTPUT_DIRECTORY=${CURRENT_DIR})
#	endif()
endfunction()
dk_aliasFunctions("dk_setPath")


###############################################################################
# dk_msys(args)
#
function(dk_msys)
	DKDEBUGFUNC(${ARGV})
	if(QUEUE_BUILD)
		string(REPLACE ";" " " str "${ARGV}")
		set(bash "#!/bin/bash")
		list(APPEND bash "cd ${CURRENT_DIR}")
		if(WIN_32 OR ANDROID_32)
			list(APPEND bash "export PATH=${MINGW32}/bin:$PATH")
		elseif(WIN_64 OR ANDROID_64)
			list(APPEND bash "export PATH=${MINGW64}/bin:$PATH")
		else()
			dk_assert("dk_msys(): ERROR: not WIN_32, WIN_64, ANDROID_32 or ANDROID_64")
		endif()
		list(APPEND bash "export PATH=${MSYS}/bin:$PATH")
		list(APPEND bash "${str}")
		list(APPEND bash "exit")
		list(APPEND bash " ")
		string(REPLACE ";" "\n"	bash "${bash}")
		string(REPLACE "C:/" "/c/" bash ${bash})
		file(WRITE ${MSYS}/dkscript.tmp ${bash})
		dk_info("dk_msys -> ${bash}")
		dk_executeProcess(${MSYS}/bin/bash ${MSYS}/dkscript.tmp)
	endif()
endfunction()
dk_aliasFunctions("dk_msys")


###############################################################################
# dk_msys2(args)
#
function(dk_msys2)
	DKDEBUGFUNC(${ARGV})
	if(QUEUE_BUILD)
		string(REPLACE ";" " " str "${ARGV}")
		set(bash "#!/bin/bash")
		list(APPEND bash "cd ${CURRENT_DIR}")
		if(WIN_32 OR ANDROID_32)
			list(APPEND bash "export PATH=${MINGW32}/bin:$PATH")
		elseif(WIN_64 OR ANDROID_64)
			list(APPEND bash "export PATH=${MINGW64}/bin:$PATH")
		else()
			dk_error("dk_msys2(): ERROR: not WIN_32, WIN_64, ANDROID_32 or ANDROID_64")
		endif()
		list(APPEND bash "export PATH=${MSYS2}/usr/bin:$PATH")
		list(APPEND bash "${str}")
		list(APPEND bash "exit")
		list(APPEND bash " ")
		string(REPLACE ";" "\n"	bash "${bash}")
		string(REPLACE "C:/" "/c/" bash ${bash})
		file(WRITE ${MSYS2}/dkscript.tmp ${bash})
		dk_info("dk_msys2 -> ${bash}")
		dk_executeProcess(${MSYS2}/usr/bin/bash ${MSYS2}/dkscript.tmp)
	endif()
endfunction()
dk_aliasFunctions("dk_msys2")


###############################################################################
# dk_mergeFlags(args result)
#
function(dk_mergeFlags args result)
	DKDEBUGFUNC(${ARGV})
	set(args ${args} ${result} ${ARGN})
	list(GET args -1 result)
	list(REMOVE_AT args -1)
	set(search "-DCMAKE_C_FLAGS=" "-DCMAKE_C_FLAGS_DEBUG=" "-DCMAKE_C_FLAGS_RELEASE=" "-DCMAKE_CXX_FLAGS=" "-DCMAKE_CXX_FLAGS_DEBUG=" "-DCMAKE_CXX_FLAGS_RELEASE=" "CFLAGS=" "CXXFLAGS=")
	foreach(word ${search})
		set(DK_${word} "${word}")
		set(index 0)
		set(placeholder 0)
		foreach(arg ${args})
			math(EXPR index "${index}+1")
			string(FIND ${arg} ${word} hasWord)
			if(${hasWord} GREATER -1)
				if(${placeholder} EQUAL 0)
					math(EXPR placeholder "${index}-1")
					# set(placeholder ${index})
				endif()				
				list(REMOVE_ITEM args ${arg})
				string(REPLACE ${word} "" arg ${arg})
				set(DK_${word} "${DK_${word}}${arg} ")
			endif()
		endforeach()
		if(${placeholder} GREATER 0)
			list(LENGTH args args_length)
			if(${placeholder} GREATER ${args_length})
				math(EXPR placeholder "${args_length}-1")
			endif()			
			list(INSERT args ${placeholder} "${DK_${word}}")  # FIXME:  Error on Linux:  List index: 6 out of range (-6, 5)
		endif()
	endforeach()
	set(${result} ${args} PARENT_SCOPE)
endfunction()


###############################################################################
# dk_command(args)
#
function(dk_command)
	DKDEBUGFUNC(${ARGV})
	if(NOT EXISTS ${CURRENT_DIR})
		dk_set(CURRENT_DIR ${DIGITALKNOB})
	endif()
#	dk_debug("${ARGV}")
	dk_mergeFlags("${ARGV}" merged_args)
#	dk_debug("${ARGV}")
	dk_executeProcess(${merged_args} WORKING_DIRECTORY ${CURRENT_DIR})
endfunction()
dk_aliasFunctions("dk_command")



###############################################################################
# dk_queueCommand(args)
#	
function(dk_queueCommand)
	DKDEBUGFUNC(${ARGV})
	if(QUEUE_BUILD)
		dk_command(${ARGV})
	endif()	
endfunction()
dk_aliasFunctions("dk_queueCommand")


###############################################################################
# dk_visualStudioDebug(folder sln_file)
#
function(dk_visualStudioDebug folder sln_file) #target #arch
	DKDEBUGFUNC(${ARGV})
	if(NOT WIN_HOST)
		return()
	endif()
	if(DEBUG AND QUEUE_BUILD)
		if(NOT EXISTS ${3RDPARTY}/${folder}/${OS}/${sln_file})
			dk_assert("CANNOT FIND: ${3RDPARTY}/${folder}/${OS}/${sln_file}" )
		endif()
		if(${ARGC} GREATER 3)
			set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /t:${ARGV2} /p:Configuration=Debug /p:Platform=${ARGV3})
		elseif(${ARGC} GREATER 2)
			set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /t:${ARGV2} /p:Configuration=Debug)
		else()
			set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /p:Configuration=Debug)
		endif()
		dk_executeProcess(${EXECUTE_COMMAND} WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
	endif()
endfunction()
dk_aliasFunctions("dk_visualStudioDebug" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_visualStudioRelease(folder sln_file)
#
function(dk_visualStudioRelease folder sln_file) #target #arch
	DKDEBUGFUNC(${ARGV})
	if(NOT WIN_HOST)
		return()
	endif()
	if(RELEASE AND QUEUE_BUILD)
		if(NOT EXISTS ${3RDPARTY}/${folder}/${OS}/${sln_file})
			dk_assert("CANNOT FIND: ${3RDPARTY}/${folder}/${OS}/${sln_file}" )
		endif()
		if(${ARGC} GREATER 3)
			set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /t:${ARGV2} /p:Configuration=Release /p:Platform=${ARGV3})
		elseif(${ARGC} GREATER 2)
			set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /t:${ARGV2} /p:Configuration=Release)
		else()
			set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /p:Configuration=Release)
		endif()
		dk_executeProcess(${EXECUTE_COMMAND} WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
	endif()
endfunction()
dk_aliasFunctions("dk_visualStudioRelease" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_visualStudio(args)
#
function(dk_visualStudio)
	DKDEBUGFUNC(${ARGV})
	dk_visualStudioDebug(${ARGV})
	dk_visualStudioRelease(${ARGV})
endfunction()
dk_aliasFunctions("dk_visualStudio" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_xcodeDebug(folder)
#
function(dk_xcodeDebug folder)
	DKDEBUGFUNC(${ARGV})
	if(NOT MAC_HOST)
		return()
	endif()
	if(DEBUG AND QUEUE_BUILD)
		if(${ARGC} GREATER 1)
			dk_executeProcess(xcodebuild -target ${ARGV1} -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		else()
			dk_executeProcess(xcodebuild -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		endif()
	endif()
endfunction()
dk_aliasFunctions("dk_xcodeDebug" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_xcodeRelease(folder)
#
function(dk_xcodeRelease folder)
	DKDEBUGFUNC(${ARGV})
	if(NOT MAC_HOST)
		return()
	endif()
	if(RELEASE AND QUEUE_BUILD)
		if(${ARGC} GREATER 1)
			dk_executeProcess(xcodebuild -target ${ARGV1} -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		else()
			dk_executeProcess(xcodebuild -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		endif()
	endif()
endfunction()
dk_aliasFunctions("dk_xcodeRelease" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_xcode(args)
#
function(dk_xcode)
	DKDEBUGFUNC(${ARGV})
	dk_xcodeDebug(${ARGV})
	dk_xcodeRelease(${ARGV})
endfunction()
dk_aliasFunctions("dk_xcode" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_ndkDebug(folder)
#
function(dk_ndkDebug folder)
	DKDEBUGFUNC(${ARGV})
	if(DEBUG AND QUEUE_BUILD)
		if(WIN_HOST)
			dk_executeProcess(${ANDROID-NDK}/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS}/Debug)
		endif()
		if(UNIX_HOST)
			dk_executeProcess(${ANDROID-NDK}/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS}/Debug)
		endif()
	endif()
endfunction()
dk_aliasFunctions("dk_ndkDebug" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_ndkRelease(folder)
#
function(dk_ndkRelease folder)
	DKDEBUGFUNC(${ARGV})
	if(RELEASE AND QUEUE_BUILD)
		if(WIN_HOST)
			dk_executeProcess(${ANDROID-NDK}/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS}/Release)
		endif()
		if(UNIX_HOST)
			dk_executeProcess(${ANDROID-NDK}/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS}/Release)
		endif()
	endif()
endfunction()
dk_aliasFunctions("dk_ndkRelease" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_ndk(args)
#
function(dk_ndk)
	DKDEBUGFUNC(${ARGV})
	dk_ndkDebug(${ARGV})
	dk_ndkRelease(${ARGV})
endfunction()
dk_aliasFunctions("dk_ndk" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_make(lib)
#
function(dk_make lib)
	DKDEBUGFUNC(${ARGV})
	dk_queueCommand(make ${ARGV})
endfunction()


###############################################################################
# dk_lib(lib_path)
#
function(dk_lib lib_path)
	DKDEBUGFUNC(${ARGV})
	foreach(item ${ARGV})
#		dk_set(LIBLIST "${LIBLIST} ${lib_path}") ## used for double checking
		#string(FIND "${LIBS}" "${item}" index)
		dk_includes("${LIBS}" "${item}" result)
		#if(NOT ${index} EQUAL -1)
		if(${result})
			continue() # item is already in the list
		endif()
		dk_set(LIBS "${LIBS};${item}")

		if(INSTALL_DKLIBS)
			if(EXISTS ${lib_path})
				dk_getFilename(${CMAKE_CURRENT_LIST_DIR} LIB_NAME)
				file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/${LIB_NAME}/lib/${OS})
			else()
				dk_assert("Could not locate ${lib_path}")
			endif()
		endif()
		
	endforeach()
endfunction()
dk_aliasFunctions("dk_lib" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_libDebug(lib_path)
#
function(dk_libDebug lib_path)
	DKDEBUGFUNC(${ARGV})
	if(NOT DEBUG)
		return()
	endif()	
	dk_set(LIBLIST ${LIBLIST} ${lib_path}) # used for double checking
	if(NOT EXISTS ${lib_path})
		dk_info("MISSING: ${lib_path}")
		dk_set(QUEUE_BUILD ON) 
	endif()
	#string(FIND "${DEBUG_LIBS}" "${lib_path}" index)
	dk_includes("${DEBUG_LIBS}" "${lib_path}" result)
	#if(NOT ${index} EQUAL -1)
	if(${result})
		return() # The library is already in the list
	endif()
	if(LINUX OR RASPBERRY OR ANDROID)
		dk_set(DEBUG_LIBS debug ${lib_path} ${DEBUG_LIBS})  # Add to beginning of list
	else()
		dk_set(DEBUG_LIBS ${DEBUG_LIBS} debug ${lib_path})  # Add to end of list
	endif()

	if(INSTALL_DKLIBS)
		dk_getFilename(${CMAKE_CURRENT_LIST_DIR} LIB_NAME)
		file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/${LIB_NAME}/lib/${OS}/Debug)
	endif()
	
endfunction()
dk_aliasFunctions("dk_libDebug" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_libRelease(lib_path)
#
function(dk_libRelease lib_path)
	DKDEBUGFUNC(${ARGV})
	if(NOT RELEASE)
		return()
	endif()
	dk_set(LIBLIST ${LIBLIST} ${lib_path}) # used for double checking
	if(NOT EXISTS ${lib_path})
		dk_info("MISSING: ${lib_path}")
		dk_set(QUEUE_BUILD ON)
	endif()
	#string(FIND "${RELEASE_LIBS}" "${lib_path}" index)
	dk_includes("${RELEASE_LIBS}" "${lib_path}" result)
	#if(NOT ${index} EQUAL -1)
	if(${result})
		return() # The library is already in the list
	endif()	
	if(LINUX OR RASPBERRY OR ANDROID)
		dk_set(RELEASE_LIBS optimized ${lib_path} ${RELEASE_LIBS})  # Add to beginning of list
	else()
		dk_set(RELEASE_LIBS ${RELEASE_LIBS} optimized ${lib_path})  # Add to end of list
	endif()
	
	if(INSTALL_DKLIBS)
		dk_getFilename(${CMAKE_CURRENT_LIST_DIR} LIB_NAME)
		file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/${LIB_NAME}/lib/${OS}/Release)
	endif()
	
endfunction()
dk_aliasFunctions("dk_libRelease" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_generateCmake(plugin_name)
#
function(dk_generateCmake plugin_name)
	DKDEBUGFUNC(${ARGV})
	dk_getPathToPlugin(${plugin_name} plugin_path)
	if(NOT EXISTS "${plugin_path}")
		dk_assert("dk_generateCmake(${plugin_name}): plugin not found")
		return()
	endif()

	# Create CmakeLists.txt file
	file(REMOVE ${plugin_path}/CMakeLists.txt)
	file(APPEND ${plugin_path}/CMakeLists.txt "### This file is generated by DKCMake. Any Changes here, will be overwritten. ###\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "### ${plugin_name} ###\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "cmake_minimum_required(VERSION 3.10)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "cmake_policy(SET CMP0054 NEW)\n")
#	file(APPEND ${plugin_path}/CMakeLists.txt "cmake_policy(SET CMP0002 OLD)\n")
#	file(APPEND ${plugin_path}/CMakeLists.txt "include(${DKCMAKE}/DKFunctions.cmake)\n")
#	file(APPEND ${plugin_path}/CMakeLists.txt "include(${DKCMAKE}/DKVariables.cmake)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "include(\$ENV{DKCMAKE}DK.cmake)\n")
		
	file(APPEND ${plugin_path}/CMakeLists.txt "project(${plugin_name})\n")

	file(APPEND ${plugin_path}/CMakeLists.txt "include_directories(${DKPLUGINS})\n")
	foreach(each_include ${DKINCLUDES_LIST})
		file(APPEND ${plugin_path}/CMakeLists.txt "include_directories(${each_include})\n")
	endforeach()
	foreach(each_define ${DKDEFINES_LIST})
		file(APPEND ${plugin_path}/CMakeLists.txt "add_definitions(-D${each_define})\n")
	endforeach()
	foreach(each_linkdir ${DKLINKDIRS_LIST})
		file(APPEND ${plugin_path}/CMakeLists.txt "link_directories(${each_linkdir})\n")
	endforeach()	

	file(APPEND ${plugin_path}/CMakeLists.txt "file(GLOB ${plugin_name}_SRC\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		${plugin_path}/*.h\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		${plugin_path}/*.c\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		${plugin_path}/*.cpp\n")
	file(APPEND ${plugin_path}/CMakeLists.txt ")\n")

	file(APPEND ${plugin_path}/CMakeLists.txt "if(WIN)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		file(GLOB WIN_SRC\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "			${plugin_path}/*.rc\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "			${plugin_path}/*.manifest\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		list(APPEND ${plugin_name}_SRC \${WIN_SRC})\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "endif()\n")
	
	file(APPEND ${plugin_path}/CMakeLists.txt "if(IOS OR IOSSIM)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		file(GLOB IOS_SRC\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "			${plugin_path}/*.mm\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		list(APPEND ${plugin_name}_SRC \${IOS_SRC})\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "endif()\n")

	file(APPEND ${plugin_path}/CMakeLists.txt "add_library(${plugin_name} STATIC \${${plugin_name}_SRC})\n")
#	file(APPEND ${plugin_path}/CMakeLists.txt "target_compile_options(${plugin_name} PRIVATE \${CMAKE_CXX_FLAGS} $<$<CONFIG:Debug>:\${CMAKE_CXX_FLAGS_DEBUG}> $<$<CONFIG:Release>:\${CMAKE_CXX_FLAGS_RELEASE}>)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "if(WIN_HOST)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		set_target_properties(${plugin_name} PROPERTIES LINKER_LANGUAGE CPP)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		set_property(DIRECTORY \${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${plugin_name})\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "endif()\n")
	
#	file(APPEND ${plugin_path}/CMakeLists.txt "install(TARGETS ${plugin_name} DESTINATION lib/\${OS})\n")
#	file(APPEND ${plugin_path}/CMakeLists.txt "file(GLOB HEADER_FILES ${plugin_path}/*.h)\n")
#	file(APPEND ${plugin_path}/CMakeLists.txt "install(FILES \${HEADER_FILES} DESTINATION include/${plugin_name})\n")
	
#	file(APPEND ${plugin_path}/CMakeLists.txt "if(NOT DKAPP)\n")
#	file(APPEND ${plugin_path}/CMakeLists.txt "     set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${plugin_name})\n")
#	file(APPEND ${plugin_path}/CMakeLists.txt "endif()\n")
	
	# add headers to DKPlugins.h
	if(${plugin_name} STREQUAL DK OR STATIC)
		file(GLOB HEADER_FILES RELATIVE ${DKPLUGINS} ${plugin_path}/*.h)
		foreach(header ${HEADER_FILES})
			#string(FIND "${PLUGINS_FILE}" "${header}" index)
			dk_includes("${PLUGINS_FILE}" "${header}" result)
			#if(${index} EQUAL -1)
			if(NOT ${result})
				dk_info("Adding ${header} to header file.")
				dk_set(PLUGINS_FILE ${PLUGINS_FILE} "#include \"${header}\"\\n")
			endif()
		endforeach()
	endif()
	
	dk_enable(${plugin_name})
	WIN_dk_libDebug(${plugin_path}/${OS}/${DEBUG_DIR}/${plugin_name}.lib)
	WIN_dk_libRelease(${plugin_path}/${OS}/${RELEASE_DIR}/${plugin_name}.lib)
	APPLE_dk_libDebug(${plugin_path}/${OS}/${DEBUG_DIR}/lib${plugin_name}.a)
	APPLE_dk_libRelease(${plugin_path}/${OS}/${RELEASE_DIR}/lib${plugin_name}.a)
	LINUX_dk_libDebug(${plugin_path}/${OS}/${DEBUG_DIR}/lib${plugin_name}.a)
	LINUX_dk_libRelease(${plugin_path}/${OS}/${RELEASE_DIR}/lib${plugin_name}.a)
	RASPBERRY_dk_libDebug(${plugin_path}/${OS}/${DEBUG_DIR}/lib${plugin_name}.a)
	RASPBERRY_dk_libRelease(${plugin_path}/${OS}/${RELEASE_DIR}/lib${plugin_name}.a)
	ANDROID_dk_libDebug(${plugin_path}/${OS}/${DEBUG_DIR}/lib${plugin_name}.a)
	ANDROID_dk_libRelease(${plugin_path}/${OS}/${RELEASE_DIR}/lib${plugin_name}.a)
	if(REBUILD OR REBUILDALL)
		dk_set(QUEUE_BUILD ON)
	endif()
	
	dk_set(DKPLUGIN_LIST ${DKPLUGIN_LIST} ${plugin_name})  #Add to list
endfunction()


###############################################################################
# dk_dll(name)
#
function(dk_dll name)
	DKDEBUGFUNC(${ARGV})
	dk_getPathToPlugin(${name} plugin_path)
	if(NOT EXISTS "${plugin_path}")
		dk_assert("${name} plugin not found")
		return()
	endif()
	dk_include(${plugin_path})
			
	# Create CmakeLists.txt file
	file(REMOVE ${plugin_path}/CMakeLists.txt)
	if(NOT EXISTS "${plugin_path}/CMakeLists.txt")
	file(APPEND ${plugin_path}/CMakeLists.txt "### ${name} ###\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "cmake_minimum_required(VERSION 3.10)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "cmake_policy(SET CMP0054 NEW)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "include(${DKCMAKE}/DKFunctions.cmake)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "include(${DKCMAKE}/DKVariables.cmake)\n")
	
	file(APPEND ${plugin_path}/CMakeLists.txt "if(IOS)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		set(PLATFORM OS64)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		include(${DKCMAKE}/ios.toolchain.cmake)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		add_definitions(-DIOS)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "endif()\n")
	
	file(APPEND ${plugin_path}/CMakeLists.txt "if(IOSSIM)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		set(PLATFORM SIMULATOR64)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		include(${DKCMAKE}/ios.toolchain.cmake)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		add_definitions(-DIOS)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "endif()\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "project(${name})\n")
	
	foreach(each_include ${DKINCLUDES_LIST})
		file(APPEND ${plugin_path}/CMakeLists.txt "include_directories(${each_include})\n")
	endforeach()
	foreach(each_define ${DKDEFINES_LIST})
		file(APPEND ${plugin_path}/CMakeLists.txt "add_definitions(-D${each_define})\n")
	endforeach()
	foreach(each_linkdir ${DKLINKDIRS_LIST})
		file(APPEND ${plugin_path}/CMakeLists.txt "link_directories(${each_linkdir})\n")
	endforeach()
	file(APPEND ${plugin_path}/CMakeLists.txt "file(GLOB ${name}_SRC \n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		${plugin_path}/*.h\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "    	${plugin_path}/*.c\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "    	${plugin_path}/*.cpp\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "    	${plugin_path}/*.rc\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "    	${plugin_path}/*.manifest\n")
	if(IOS OR IOSSIM)
		file(APPEND ${plugin_path}/CMakeLists.txt "		${plugin_path}/*.mm\n")
	endif()
	file(APPEND ${plugin_path}/CMakeLists.txt ")\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "add_library(${name} SHARED \${${name}_SRC})\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "add_definitions(-D_WIN32_WINNT=0x0600)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "set_target_properties(${name} PROPERTIES LINK_FLAGS_DEBUG \"/NODEFAULTLIB:libc.lib /NODEFAULTLIB:LIBCMTD.lib /SAFESEH:NO\" LINK_FLAGS \"/NODEFAULTLIB:libc.lib /NODEFAULTLIB:LIBCMT.lib /SAFESEH:NO\") \n")
	file(APPEND ${plugin_path}/CMakeLists.txt "target_compile_options(${name} PRIVATE $<$<CONFIG:Debug>:/MDd /Od /Ob0 /EHsc /Zi /RTC1 /DDEBUG /D_DEBUG> $<$<CONFIG:Release>:/MD /O2 /Ob2 /EHsc /DNDEBUG>)\n")
	if(DEBUG_LIBS)
		string(REPLACE "debug" " debug " DLL_DEBUG_LIBS ${DEBUG_LIBS})
	endif()
	if(RELEASE_LIBS)
		string(REPLACE "optimized" " optimized " DLL_RELEASE_LIBS ${RELEASE_LIBS})
	endif()
	if(LIBS)
		string(REPLACE ".lib" ".lib " DLL_LIBS ${LIBS})
	endif()
	if(DLL_DEBUG_LIBS AND DLL_RELEASE_LIBS)
#		file(APPEND ${plugin_path}/CMakeLists.txt "target_link_libraries(${name} debug ${DKPLUGINS}/DK/${OS}/${DEBUG_DIR}/DK.lib optimized ${DKPLUGINS}/DK/${OS}/${RELEASE_DIR}/DK.lib) \n")
		file(APPEND ${plugin_path}/CMakeLists.txt "target_link_libraries(${name} ${DLL_DEBUG_LIBS} ${DLL_RELEASE_LIBS} ${DLL_LIBS}) \n")
	endif()
	file(APPEND ${plugin_path}/CMakeLists.txt "if(WIN_HOST)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		set_target_properties(${name} PROPERTIES LINKER_LANGUAGE CPP)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "endif()\n")
	endif()
	dk_addToPluginList(${name})
endfunction()


###############################################################################
# dk_executable(name)
#
#	
function(dk_executable name)
	DKDEBUGFUNC(${ARGV})
	dk_getPathToPlugin(${name} plugin_path)
	if(NOT EXISTS "${plugin_path}")
		dk_assert("${name} plugin not found")
		return()
	endif()
	dk_include(${plugin_path})
	file(REMOVE ${plugin_path}/CMakeLists.txt)
	if(NOT EXISTS "${plugin_path}/CMakeLists.txt")
#	file(APPEND ${plugin_path}/CMakeLists.txt "### ${name} ###\n")
#	file(APPEND ${plugin_path}/CMakeLists.txt "cmake_minimum_required(VERSION 3.10)\n")
#	file(APPEND ${plugin_path}/CMakeLists.txt "cmake_policy(SET CMP0054 NEW)\n")
#	file(APPEND ${plugin_path}/CMakeLists.txt "include(${DKCMAKE}/DKFunctions.cmake)\n")
#	file(APPEND ${plugin_path}/CMakeLists.txt "include(${DKCMAKE}/DKVariables.cmake)\n")
#	file(APPEND ${plugin_path}/CMakeLists.txt "project(${name})\n")
	endif()
	dk_addToPluginList(${name})
endfunction()


###############################################################################
# dk_testApp(name)
#
#	@name:
#
function(dk_testApp name)
	DKDEBUGFUNC(${ARGV})
	dk_getPathToPlugin(${name} plugin_path)
	if(NOT EXISTS "${plugin_path}/test")
		dk_info("dk_testApp(): ${name}_test app not found")
		return()
	endif()
	dk_info("building ${name}_test app")
	dk_set(test_path "${plugin_path}/test")
	
	# Create CmakeLists.txt file
	file(REMOVE "${test_path}/CMakeLists.txt")
	file(APPEND ${test_path}/CMakeLists.txt "### This file is generated by DKCMake. Any Changes here, will be overwritten. ###\n")
	file(APPEND ${test_path}/CMakeLists.txt "### ${name} ###\n")
	file(APPEND ${test_path}/CMakeLists.txt "cmake_minimum_required(VERSION 3.10)\n")
	file(APPEND ${test_path}/CMakeLists.txt "cmake_policy(SET CMP0054 NEW)\n")
	file(APPEND ${test_path}/CMakeLists.txt "include(${DKCMAKE}/DKFunctions.cmake)\n")
	file(APPEND ${test_path}/CMakeLists.txt "include(${DKCMAKE}/DKVariables.cmake)\n")
	dk_appendCmake("project(${name}_test)\n")
	dk_appendCmake("include_directories(${DKPLUGINS})\n")
		
	# TODO		
	dk_addToPluginList(${name})
endfunction()


###############################################################################
# dk_addToPluginList(name)
#
# @name:
#
function(dk_addToPluginList name)
	DKDEBUGFUNC(${ARGV})
	dk_getPathToPlugin(${name} plugin_path)
	if(NOT EXISTS "${plugin_path}")
		dk_assert("${name} plugin not found")
		return()
	endif()
	dk_include(${plugin_path})
	dk_set(DKPLUGIN_LIST ${DKPLUGIN_LIST} ${name})
endfunction()


###############################################################################
# dk_appendCmake(str)
#
#	@str:
#
function(dk_appendCmake str)
	DKDEBUGFUNC(${ARGV})
	file(APPEND ${plugin_path}/CMakeLists.txt "${str}")
endfunction()

SET(ASSETS 
	PATTERN *.h EXCLUDE
	PATTERN *.c EXCLUDE
	PATTERN *.cmake EXCLUDE
	PATTERN *.cpp EXCLUDE
	PATTERN *.dir EXCLUDE
	PATTERN *.filters EXCLUDE
	PATTERN *.lib EXCLUDE
	PATTERN *.manifest EXCLUDE
	PATTERN *.mm EXCLUDE
	PATTERN *.pdb EXCLUDE
	PATTERN *.plist EXCLUDE
	PATTERN *.rc EXCLUDE
	PATTERN *.sln EXCLUDE
	PATTERN *.tmp EXCLUDE
	PATTERN *.TMP EXCLUDE
	PATTERN *.temp EXCLUDE
	PATTERN *.TEMP EXCLUDE
	PATTERN *.vcxproj EXCLUDE
	PATTERN CMakeFiles EXCLUDE
	PATTERN CMakeLists.txt EXCLUDE
	PATTERN temp.txt EXCLUDE
	PATTERN win32 EXCLUDE
	PATTERN win64 EXCLUDE
	PATTERN mac32 EXCLUDE
	PATTERN mac64 EXCLUDE
	PATTERN ios32 EXCLUDE
	PATTERN ios64 EXCLUDE
	PATTERN iossim32 EXCLUDE
	PATTERN iossim64 EXCLUDE
	PATTERN linux32 EXCLUDE
	PATTERN linux64 EXCLUDE
	PATTERN android32 EXCLUDE
	PATTERN android64 EXCLUDE
	PATTERN raspberry32 EXCLUDE
	PATTERN raspberry64 EXCLUDE
	PATTERN dktest EXCLUDE)


###############################################################################
# dk_assets(name)
#
#	Add a library's files to the App's assets
#
#	@name:
#
function(dk_assets name)
	DKDEBUGFUNC(${ARGV})
	if(NOT DKAPP)
		return()
	endif()	
	dk_getPathToPlugin(${name} plugin_path)
	if(NOT plugin_path)
		dk_assert("${name} plugin not found")
		return()
	endif()
	dk_info("Importing ${name} assets...")
	file(COPY ${plugin_path} DESTINATION ${DKPROJECT}/assets ${ASSETS})
#	file(COPY ${plugin_path}/${OS}/${DEBUG_DIR}/*.exe DESTINATION ${DKPROJECT}/assets/${OS}/Debug)
endfunction()


###############################################################################
# dk_getPathToPlugin(name result)
#
#	@name:
#	@result:
#
function(dk_getPathToPlugin name result)
	DKDEBUGFUNC(${ARGV})
	list(FIND dk_disabled_list "${ARGV}" index)
	if(${index} GREATER -1)
		dk_info("${ARGV} IS DISABLED")
		return()
	endif()
	file(GLOB children RELATIVE ${DIGITALKNOB} ${DIGITALKNOB}/*)
 	foreach(child ${children})
		if(EXISTS ${DIGITALKNOB}/${child}/3rdParty/_DKIMPORTS/${name}/DKMAKE.cmake)
			set(${result} "${DIGITALKNOB}/${child}/3rdParty/_DKIMPORTS/${name}" PARENT_SCOPE)
			return()
    	endif()
		if(EXISTS ${DIGITALKNOB}/${child}/DKPlugins/${name}/DKMAKE.cmake)
			set(${result} "${DIGITALKNOB}/${child}/DKPlugins/${name}" PARENT_SCOPE)
			return()
    	endif()
  	endforeach()
	set(${result} "")
#	dk_error("Could not find ${name} Plugin.")
	dk_assert("Could not find ${name} Plugin.")
endfunction()


###############################################################################
# dk_depend(name)
#
#	Add a library or plugin to the dependency list
#
#	@name:
#
function(dk_depend name)
	DKDEBUGFUNC(${ARGV})
#	dk_debug(CMAKE_CURRENT_LIST_DIR)
	
#	if(${ARGC} GREATER 1)
#		dk_info(ARGV)
#		dk_dump(ARGV) # FIXME: DUMP not working here, show 2 for the ARGC count, but only shows variable name ARGV, no value
#	endif()

	list(FIND dk_disabled_list ${name} index)
	if(${index} GREATER -1)
		dk_warn("${name} IS DISABLED")
		return()
	endif()
	
# 	TODO TODO TODO TODO 
# 	dk_createSmartObject(${name}) #TODO:  automatically determin plugin, create variables, setup auto compiles, etc 
# 	TODO TODO TODO TODO 
	
#	If dk_depend had second variable (a sub library), set that variable to ON
#	if(${ARGC} GREATER 1)
#	list(FIND dkdepend_list "${name} ${args}" index)
#	if(${index} GREATER -1) #library is already in the list
#		return()
#	endif()
#	else()
#		list(FIND dkdepend_list "${name}" index)
#		if(${index} GREATER -1)
#			return() #library is already in the list
#		endif()
#	endif()
		
	list(FIND dkdepend_list ${name} index)
	if(${index} GREATER -1)
		return()  #library is already in the list
	endif()
	
	dk_enable(${name})
	dk_runDepends(${name}) # strip everything from the file except if() else() elseif() endif() and dk_depend() before sorting.
#	else()
#		list(FIND dkdepend_list "${name}" index)
#		if(${index} GREATER -1)
#			return() #library is already in the list
#		endif()
#		dk_runDepends(${name}) # strip everything from the file except if() else() elseif() endif() and dk_depend() before sorting.
#	endif()
endfunction()
dk_aliasFunctions("dk_depend")


###############################################################################
# dk_undepend(name)
#
#	Remove a library or plugin from the dependency list
#
#	@name:
#
function(dk_undepend name)
	DKDEBUGFUNC(${ARGV})
	# Only allow dk_undepend command from these filters	
	if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKCMAKE} AND NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKPROJECT}) # /DKCMake or /App directory only
		dk_assert("dk_undepend() Can only be used from the DKDisabled.cmake file. This is to avoid having disabled libraries hideing everywhere")
	endif()
	dk_info("DISABLING ${ARGV}")
	dk_set(dk_disabled_list ${dk_disabled_list} "${ARGV}")
	if(${ARGC} GREATER 1)
		dk_removeTarget(${name} ${ARGV1})
	endif()
endfunction()


###############################################################################
# dk_runDepends(name)
#
#	Strip everything from the library's DKMAKE.cmake file except dk_depend() commands AND conditionals.
#	Conditionals such as if(), else(), elseif(), endif(), return() will remain included during the sorting process. 
#	WARNING: BE CAREFULL WRITING NEW VARIABLES TO USE WITH CONDITIONALS, AS THEY MIGHT BE IGNORED 
#
#	@name:
#
function(dk_runDepends name)
	DKDEBUGFUNC(${ARGV})
	dk_getPathToPlugin(${name} plugin_path)
	if(NOT plugin_path)
		dk_assert("${name} plugin not found")
		return()
	endif()
#	dk_debug("FOUND ${name} DK makefile at ${plugin_path}")
	
	file(STRINGS ${plugin_path}/DKMAKE.cmake lines)
	unset(disable_script)
	unset(depends_script)
	unset(index)
	
	set(KEEPLINE 0)
	foreach(line ${lines})
		#string(FIND "${line}" "if(" index)
		dk_includes("${line}" "if(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
		#string(FIND "${line}" "IF(" index)
		dk_includes("${line}" "IF(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
		## elseif(
		##NOTE: The 'if(' search commands take care of elseif() and endif() since 'if' is already in those words 
		
		#string(FIND "${line}" "else(" index)
		dk_includes("${line}" "else(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
		#string(FIND "${line}" "ELSE(" index)
		dk_includes("${line}" "ELSE(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
		## endif(
		##NOTE: The 'if(' search commands take care of elseif() and endif() since 'if' is already in those words 
		
		#string(FIND "${line}" "return(" index)
		dk_includes("${line}" "return(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
		#string(FIND "${line}" "RETURN(" index)
		dk_includes("${line}" "RETURN(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
		#string(FIND "${line}" "dk_disable(" index)
		dk_includes("${line}" "dk_disable(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
#		#string(FIND "${line}" "SET(" index)
#		dk_includes("${line}" "SET(" result)
#		#if(${index} GREATER -1)
#		if(${result})
#			set(KEEPLINE 1)
#		endif()
		
#		#string(FIND "${line}" "dk_set(" index) # taken care of by SET( sytax above
#		dk_includes("${line}" "dk_set(" result)
#		#if(${index} GREATER -1)
#		if(${result})
#			set(KEEPLINE 1)
#		endif()
		
		if(KEEPLINE)
			set(disable_script "${disable_script}${line}\n")
		endif()
		
		# FIXME: we need to get a proper count of openeing (  before we can determine that we have actually reached the closing )
		#string(FIND "${line}" ")" indexB)
		dk_includes("${line}" ")" result)
		#if(${indexB} GREATER -1)
		if(${result})
			set(KEEPLINE 0)
		endif()
	endforeach()
	
	set(KEEPLINE 0)
	foreach(line ${lines})
		#string(FIND "${line}" "if(" index)
		dk_includes("${line}" "if(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
		#string(FIND "${line}" "IF(" index)
		dk_includes("${line}" "IF(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
		## elseif(
		##NOTE: The 'if(' search commands take care of elseif() and endif() since 'if' is already in those words 
		
		#string(FIND "${line}" "else(" index)
		dk_includes("${line}" "else(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
		#string(FIND "${line}" "ELSE(" index)
		dk_includes("${line}" "ELSE(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
		## endif(
		##NOTE: The 'if(' search commands take care of elseif() and endif() since 'if' is already in those words 
		
		#string(FIND "${line}" "return(" index)
		dk_includes("${line}" "return(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
		#string(FIND "${line}" "RETURN(" index)
		dk_includes("${line}" "RETURN(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
		#string(FIND "${line}" "dk_enable(" index)
		dk_includes("${line}" "dk_enable(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
		#string(FIND "${line}" "dk_disable(" index)
		dk_includes("${line}" "dk_disable(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()	
		
		#string(FIND "${line}" "dk_depend(" index)
		dk_includes("${line}" "dk_depend(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
		#string(FIND "${line}" "dk_set(" index)
		dk_includes("${line}" "dk_set(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
		#string(FIND "${line}" "message(" index)
		dk_includes("${line}" "message(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
		#string(FIND "${line}" "dk_assert(" index)
		dk_includes("${line}" "dk_assert(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
		#string(FIND "${line}" "dk_error(" index)
		dk_includes("${line}" "dk_error(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
		#string(FIND "${line}" "dk_warn(" index)
		dk_includes("${line}" "dk_warn(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
		#string(FIND "${line}" "dk_info(" index)
		dk_includes("${line}" "dkinfo(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
		#string(FIND "${line}" "dk_debug(" index)
		dk_includes("${line}" "dk_debug(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()

		#string(FIND "${line}" "dk_verbose(" index)
		dk_includes("${line}" "dk_verbose(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
		#string(FIND "${line}" "dk_trace(" index)
		dk_includes("${line}" "dk_trace(" result)
		#if(${index} GREATER -1)
		if(${result})
			set(KEEPLINE 1)
		endif()
		
		if(KEEPLINE)
			set(depends_script "${depends_script}${line}\n")
		endif()
		
		# FIXME: we need to get a proper count of openeing (  before we can determine that we have actually reached the closing )
		#string(FIND "${line}" ")" indexB)
		dk_includes("${line}" ")" result)
		#if(${indexB} GREATER -1)
		if(${result})
			set(KEEPLINE 0)
		endif()
	endforeach()
	
	if(disable_script)
		file(WRITE ${plugin_path}/DISABLES.TMP "${disable_script}")
		INCLUDE(${plugin_path}/DISABLES.TMP)
#		file(APPEND ${filepath} "${disable_script}")   #cmake 3.18+
		file(REMOVE ${plugin_path}/DISABLES.TMP)
	endif()
	
	if(depends_script)
		if(${ARGC} GREATER 1)
			dk_enable(${ARGV1})
		else()
			dk_set(${ARGV0}_all 1)
		endif()
		file(WRITE ${plugin_path}/DEPENDS.TMP "${depends_script}")
		INCLUDE(${plugin_path}/DEPENDS.TMP)
#		file(APPEND ${filepath} "${depends_script}")    #cmake 3.18+
		file(REMOVE ${plugin_path}/DEPENDS.TMP)
		if(${ARGC} GREATER 1)
			dk_set(${ARGV1} OFF)
		endif()
	endif()
	
	if(${ARGC} GREATER 1)
		list(FIND dkdepend_list "${name} ${ARGV1}" index)
		if(${index} GREATER -1)
			return()
		endif()
	else()
		list(FIND dkdepend_list "${name}" index)
		if(${index} GREATER -1)
			return() # already on the list
		endif()
	endif()
	
	dk_set(dkdepend_list ${dkdepend_list} "${ARGV}")  #Add sublibrary to list
#	if(${ARGC} GREATER 1)
#		dk_set(dkdepend_list ${dkdepend_list} "${name} ${ARGV1}")  #Add sublibrary to list
#	else()
#		dk_set(dkdepend_list ${dkdepend_list} ${name})  #Add library to list
#	endif()	
	list(REMOVE_DUPLICATES dkdepend_list)
endfunction()


###############################################################################
# dk_dependAll()
#
function(dk_dependAll)
	DKDEBUGFUNC(${ARGV})
	set(DEPENDALL_FILE "")
	
	if(IS_DIRECTORY ${DKIMPORTS})
		file(GLOB allfiles RELATIVE "${DKIMPORTS}/" "${DKIMPORTS}/*")
		foreach(each_file ${allfiles})
			if(EXISTS ${DKIMPORTS}/${each_file}/DKMAKE.cmake)
				set(DEPENDALL_FILE ${DEPENDALL_FILE} "dk_depend(${each_file})\n")
			endif()
		endforeach()
    endif()
	
	# Find all DKPlugins Folders from digitalknob root
	file(GLOB children RELATIVE ${DIGITALKNOB}/ ${DIGITALKNOB}/*)
  	foreach(child ${children})
		if(EXISTS ${DIGITALKNOB}/${child}/DKPlugins)
			file(GLOB plugins RELATIVE ${DIGITALKNOB}/${child}/DKPlugins/ ${DIGITALKNOB}/${child}/DKPlugins/*)
			foreach(plugin ${plugins})
				if(EXISTS ${DIGITALKNOB}/${child}/DKPlugins/${plugin}/DKMAKE.cmake)
					if(NOT ${plugin} STREQUAL "_DKIMPORT")
						set(DEPENDALL_FILE ${DEPENDALL_FILE} "dk_depend(${plugin})\n")
					endif()
				endif()
			endforeach()
		endif()
  	endforeach()
	
	# To exclude libraries, use dk_disable(lib) in your app DKMAKE.cmake file or in DKDisabled.cmake
	string (REPLACE ";" "" DEPENDALL_FILE "${DEPENDALL_FILE}")
	file(WRITE ${DKPROJECT}/DEPEND_ALL.txt "${DEPENDALL_FILE}")
	unset(DEPENDALL_FILE)
	INCLUDE(${DKPROJECT}/DEPEND_ALL.txt)
endfunction()


###############################################################################
# dkFileReplace(filePath find replace)
#
#	@filePath:
#	@find:
#	@replace:
#
function(dkFileReplace filePath find replace)
	DKDEBUGFUNC(${ARGV})
	file(READ ${filePath} fileString)
	string(FIND "${fileString}" "${find}" index)
	if(${index} GREATER -1)
		string(REPLACE "${find}" "${replace}" fileString "${fileString}")
		file(WRITE ${filePath} "${fileString}")
	else()
		dk_info("WARNING: cannot find \"${find}\"  in  (${filePath})")
	endif()
endfunction()


###############################################################################
# dk_updateAndroidName(name)
#
#	@name:
#
function(dk_updateAndroidName name)
	DKDEBUGFUNC(${ARGV})
	string(TOLOWER ${name} name)
	if(ANDROID)
		# update all files and folders recursivley
		file(GLOB_RECURSE allfiles LIST_DIRECTORIES true RELATIVE "${DKPROJECT}/${OS}/" "${DKPROJECT}/${OS}/*")
		dk_debug("Getting a list of files in ${DKPROJECT}/${OS}")
		list(REVERSE allfiles)
		foreach(each_file ${allfiles})
			#dk_debug("#####  each_file = ${each_file}")
			dk_debug(each_file)
			set(filepath "${DKPROJECT}/${OS}/${each_file}")
			#dk_debug("### each_file = ${each_file}")
			dk_debug(each_file)
			if(NOT IS_DIRECTORY ${filepath})
				string(FIND "${each_file}" "opendb" indexD)
				if(${indexD} GREATER -1)
					continue()
				endif()
				string(FIND "${each_file}" ".log" indexD)
				if(${indexD} GREATER -1)
					continue()
				endif()
				file(READ ${filepath} filestring)
				string(FIND "${filestring}" "dkapp" index)
				if(${index} GREATER -1)
					dk_info("Replacing 'dkapp' with '${name}' in ${filepath}")
					string(REPLACE "dkapp" "${name}" filestring "${filestring}")
					file(WRITE ${filepath} "${filestring}")
				endif()
			endif()
			get_filename_component(fname ${each_file} NAME)
			string(FIND "${fname}" "dkapp" indexB)
			if(${indexB} GREATER -1)
				set(new_name ${each_file})
				string(REPLACE "dkapp" "${name}" new_name "${new_name}")
				dk_info("Renaming ${each_file} to ${new_name}")
				dk_rename(${DKPROJECT}/${OS}/${each_file} ${DKPROJECT}/${OS}/${new_name} true)
			endif()
		endforeach()
	endif()
endfunction()


###############################################################################
# dk_updateInfoPlist(name)
#
#	@name:
#
function(dk_updateInfoPlist name)
	DKDEBUGFUNC(${ARGV})
	if(MAC)
		# FIXME
		dk_info("Updating MAC info.plist . . .")
		if(DEBUG)
			if(EXISTS ${DKPROJECT}/${OS}/${DEBUG_DIR}/${name}.app/Contents/info.plist)
				file(READ ${DKPROJECT}/${OS}/${DEBUG_DIR}/${name}.app/Contents/info.plist plist)
				string(REPLACE "<key>CFBundleIconFile</key>" "" plist ${plist})
				string(REPLACE "<string>logo</string>" "" plist ${plist})
				string(REPLACE "<dict>" "<dict><key>CFBundleIconFile</key><string>logo</string>" plist ${plist})
				file(WRITE "${plist}" ${DKPROJECT}/${OS}/${DEBUG_DIR}/${name}.app/Contents/info.plist)
			endif()
		endif()
		if(RELEASE)
			if(EXISTS ${DKPROJECT}/${OS}/${RELEASE_DIR}/${name}.app/Contents/info.plist)
				file(READ ${DKPROJECT}/${OS}/${RELEASE_DIR}/${name}.app/Contents/info.plist plist)
				string(REPLACE "<key>CFBundleIconFile</key>" "" plist ${plist})
				string(REPLACE "<string>logo</string>" "" plist ${plist})
				string(REPLACE "<dict>" "<dict><key>CFBundleIconFile</key><string>logo</string>" plist ${plist})
				file(WRITE "${plist}" ${DKPROJECT}/${OS}/${RELEASE_DIR}/${name}.app/Contents/info.plist)
			endif()	
		endif()
	endif()
	if(IOS OR IOSSIM)
		dk_info("Updating IOS Info.plist . . .")
		dk_info("CHECKING FOR... ${DKPROJECT}/${OS}/${DEBUG_DIR}/${name}.app/Info.plist")
		if(EXISTS ${DKPROJECT}/${OS}/${DEBUG_DIR}/${name}.app/Info.plist)
			dk_info("Updating IOS Debug Info.plist . . .")
			file(READ ${DKPROJECT}/${OS}/${DEBUG_DIR}/${name}.app/Info.plist plist)
			string(REPLACE "<dict>" "<dict>\n<key>Icon files</key>\n<array>\n<string>Icon.png</string>\n<string>Icon@2x.png</string>\n<string>Icon-72.png</string>\n<string>Icon-Small-50.png</string>\n<string>Icon-Small.png</string>\n<string>Icon-Small@2x.png</string>\n</array>\n" plist ${plist})
			file(WRITE "${plist}" ${DKPROJECT}/${OS}/${DEBUG_DIR}/${name}.app/Info.plist)
		endif()
	endif()
endfunction()


###############################################################################
# dk_buildLog(entry)
#
#	@entry:
#
function(dk_buildLog entry)
	DKDEBUGFUNC(${ARGV})
	dk_info("	${entry}")
	file(APPEND ${DKPROJECT}/${OS}/DKBUILD.log "${entry}\n")
endfunction()


###############################################################################
# dk_addSource(regex)
#
#	@regex:
#
function(dk_addSource regex)
	DKDEBUGFUNC(${ARGV})
	dk_set(SRC_INCLUDE ${SRC_INCLUDE} ${ARGV})
endfunction()


###############################################################################
# dk_removeSource(regex)
#
#	@regex:
#
function(dk_removeSource regex)
	DKDEBUGFUNC(${ARGV})
	dk_set(SRC_EXCLUDE ${SRC_EXCLUDE} ${ARGV})
endfunction()

###############################################################################
# dk_wrapString()
#
#	Function to wrap a given string into multiple lines at the given column position.
#
#	@VARIABLE:	The name of the CMake variable holding the string.
#	@AT_COLUMN:	The column position at which string will be wrapped.
#
function(dk_wrapString)
	DKDEBUGFUNC(${ARGV})
	set(oneValueArgs VARIABLE AT_COLUMN)
	cmake_parse_arguments(dk_wrapString "${options}" "${oneValueArgs}" "" ${ARGN})
    string(LENGTH ${${DK_WRAPSTRING_VARIABLE}} stringLength)
    math(EXPR offset "0")
    while(stringLength GREATER 0)
        if(stringLength GREATER ${DK_WRAPSTRING_AT_COLUMN})
            math(EXPR length "${DK_WRAPSTRING_AT_COLUMN}")
        else()
            math(EXPR length "${stringLength}")
        endif()
        string(SUBSTRING ${${DK_WRAPSTRING_VARIABLE}} ${offset} ${length} line)
        set(lines "${lines}\n${line}")
        math(EXPR stringLength "${stringLength} - ${length}")
        math(EXPR offset "${offset} + ${length}")
    endwhile()
    set(${DK_WRAPSTRING_VARIABLE} "${lines}" PARENT_SCOPE)
endfunction()


###############################################################################
# dk_bin2h()
#
#	https://gist.github.com/sivachandran/3a0de157dccef822a230#file-bin2h-cmake
#	Function to embed contents of a file as byte array in C/C++ header file(.h). The header file
#	will contain a byte array and integer variable holding the size of the array.
#	
#	@SOURCE_FILE     - The path of source file whose contents will be embedded in the header file.
#   @VARIABLE_NAME   - The name of the variable for the byte array. The string "_SIZE" will be append
#                      to this name and will be used a variable name for size variable.
#   @HEADER_FILE     - The path of header file.
#   @APPEND          - If specified appends to the header file instead of overwriting it
#   @NULL_TERMINATE  - If specified a null byte(zero) will be append to the byte array. This will be
#                      useful if the source file is a text file and we want to use the file contents
#                      as string. But the size variable holds size of the byte array without this
#                      null byte.
#	Usage:
#		dk_bin2h(SOURCE_FILE "Logo.png" HEADER_FILE "Logo.h" VARIABLE_NAME "LOGO_PNG")
#
function(dk_bin2h)
	DKDEBUGFUNC(${ARGV})
    set(options APPEND NULL_TERMINATE)
    set(oneValueArgs SOURCE_FILE VARIABLE_NAME HEADER_FILE)
    cmake_parse_arguments(dk_bin2h "${options}" "${oneValueArgs}" "" ${ARGN})
    # reads source file contents as hex string
    file(READ ${DK_BIN2H_SOURCE_FILE} hexString HEX)
    string(LENGTH ${hexString} hexStringLength)
    # appends null byte if asked
    if(DK_BIN2H_NULL_TERMINATE)
        set(hexString "${hexString}00")
    endif()
    # wraps the hex string into multiple lines at column 32(i.e. 16 bytes per line)
#	dk_wrapString(VARIABLE hexString AT_COLUMN 32)
    math(EXPR arraySize "${hexStringLength} / 2")
    # adds '0x' prefix and comma suffix before and after every byte respectively
#	string(REGEX REPLACE "([0-9a-f][0-9a-f])" "\\1" arrayValues ${hexString})
    # removes trailing comma
#	string(REGEX REPLACE ", $" "" arrayValues ${arrayValues})
    # converts the variable name into proper C identifier
    string(MAKE_C_IDENTIFIER "${DK_BIN2H_VARIABLE_NAME}" DK_BIN2H_VARIABLE_NAME)
    string(TOUPPER "${DK_BIN2H_VARIABLE_NAME}" DK_BIN2H_VARIABLE_NAME)
    # declares byte array and the length variables
    set(arrayDefinition "std::string ${DK_BIN2H_VARIABLE_NAME} = \"${hexString}\";")
    set(arraySizeDefinition "size_t ${DK_BIN2H_VARIABLE_NAME}_SIZE = ${arraySize};")
    set(declarations "${arrayDefinition}\n\n${arraySizeDefinition}\n\n")
    if(DK_BIN2H_APPEND)
        file(APPEND ${DK_BIN2H_HEADER_FILE} "${declarations}")
    else()
        file(WRITE ${DK_BIN2H_HEADER_FILE} "${declarations}")
    endif()
endfunction()


###############################################################################
# dk_printSettings()
#
#	https://cmake.org/cmake/help/latest/manual/cmake-variables.7.html
#
function(dk_printSettings)
	DKDEBUGFUNC(${ARGV})
	dk_buildLog("#################  HOST SYSTEM VARIABLES  ################")
	dk_buildLog("CMAKE_COMMAND:                 ${CMAKE_COMMAND}")
	dk_buildLog("CMAKE_EXE:                     ${CMAKE_EXE}")
	dk_buildLog("CMAKE_VERSION:                 ${CMAKE_VERSION}")
	dk_buildLog("CMAKE_HOST_SYSTEM_NAME:        ${CMAKE_HOST_SYSTEM_NAME}")
	dk_buildLog("CMAKE_HOST_SYSTEM_VERSION:     ${CMAKE_HOST_SYSTEM_VERSION}")
	dk_buildLog("CMAKE_HOST_SYSTEM_PROCESSOR:   ${CMAKE_HOST_SYSTEM_PROCESSOR}")
	dk_buildLog("CMAKE_SYSTEM_NAME:             ${CMAKE_SYSTEM_NAME}")
	dk_buildLog("CMAKE_LIBRARY_ARCHITECTURE:    ${CMAKE_LIBRARY_ARCHITECTURE}")
	dk_buildLog("ENV(USERNAME):                 $ENV{USERNAME}")
	dk_buildLog("ENV(USER):	    				$ENV{USER}")
	dk_buildLog("DIGITALKNOB:                   ${DIGITALKNOB}")
	dk_buildLog("3RDPARTY:                      ${3RDPARTY}")
	dk_buildLog("DKPLUGINS:                     ${DKPLUGINS}")
	dk_buildLog(" ")
	dk_buildLog("#############  PROJECT VARIABLES  ############")
	dk_buildLog("APP_NAME:                      ${APP_NAME}")            ### APP_NAME is set to the App folder name
	dk_buildLog("DKPROJECT:                     ${DKPROJECT}")
	dk_buildLog("CMAKE_BINARY_DIR:              ${CMAKE_BINARY_DIR}")
	if(CMAKE_ARCHIVE_OUTPUT_DIRECTORY)
		dk_buildLog("CMAKE_ARCHIVE_OUTPUT_DIRECTORY: ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}")
	endif()
	if(CMAKE_LIBRARY_OUTPUT_DIRECTORY)
		dk_buildLog("CMAKE_LIBRARY_OUTPUT_DIRECTORY: ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
	endif()
	if(CMAKE_RUNTIME_OUTPUT_DIRECTORY)
		dk_buildLog("CMAKE_RUNTIME_OUTPUT_DIRECTORY: ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")
	endif()
	dk_buildLog("DEBUG_DIR:                     ${DEBUG_DIR}")
	dk_buildLog("RELEASE_DIR:                   ${RELEASE_DIR}")
	dk_buildLog("CMAKE_GENERATOR:               ${CMAKE_GENERATOR}")
	dk_buildLog("VS_STARTUP_PROJECT:            ${VS_STARTUP_PROJECT}") 
	dk_buildLog("CMAKE_C_COMPILER:              ${CMAKE_C_COMPILER}")
	if(CMAKE_C_STANDARD)
		dk_buildLog("CMAKE_C_STANDARD:              ${CMAKE_C_STANDARD}")
	endif()
	if(CMAKE_C_STANDARD_REQUIRED)
		dk_buildLog("CMAKE_C_STANDARD_REQUIRED:     ${CMAKE_C_STANDARD_REQUIRED}")
	endif()
	if(CMAKE_C_EXTENSIONS)
		dk_buildLog("CMAKE_C_EXTENSIONS:            ${CMAKE_C_EXTENSIONS}")
	endif()
	dk_buildLog("CMAKE_C_FLAGS:                 ${CMAKE_C_FLAGS}")
	dk_buildLog("CMAKE_C_FLAGS_DEBUG:           ${CMAKE_C_FLAGS_DEBUG}")
	dk_buildLog("CMAKE_C_FLAGS_RELEASE:         ${CMAKE_C_FLAGS_RELEASE}")
	dk_buildLog("CMAKE_CXX_COMPILER:            ${CMAKE_CXX_COMPILER}")
	if(CMAKE_CXX_STANDARD)
		dk_buildLog("CMAKE_CXX_STANDARD:            ${CMAKE_CXX_STANDARD}")
	endif()
	if(CMAKE_CXX_STANDARD_REQUIRED)
		dk_buildLog("CMAKE_CXX_STANDARD_REQUIRED:   ${CMAKE_CXX_STANDARD_REQUIRED}")
	endif()
	if(CMAKE_CXX_EXTENSIONS)
		dk_buildLog("CMAKE_CXX_EXTENSIONS :         ${CMAKE_CXX_EXTENSIONS}")
	endif()
	dk_buildLog("CMAKE_CXX_FLAGS:               ${CMAKE_CXX_FLAGS}")
	dk_buildLog("CMAKE_CXX_FLAGS_DEBUG:         ${CMAKE_CXX_FLAGS_DEBUG}")
	dk_buildLog("CMAKE_CXX_FLAGS_RELEASE:       ${CMAKE_CXX_FLAGS_RELEASE}")
	dk_buildLog("OS:                            ${OS}")
	dk_buildLog("DEBUG:                         ${DEBUG}")
	dk_buildLog("RELEASE:                       ${RELEASE}")
	if(BUILD)
		dk_buildLog("BUILD:                         ${BUILD}")
	endif()
	if(REBUILD)
		dk_buildLog("REBUILD:                       ${REBUILD}")
	endif()
	if(REBUILDALL)
		dk_buildLog("REBUILDALL:                    ${REBUILDALL}")
	endif()
	if(DKCEF)
		dk_buildLog("DKCEF:                         ${DKCEF}")
	endif()
	if(WIN)
		dk_buildLog("WIN:                           ${WIN}")
	endif()	
	if(WIN_32)
		dk_buildLog("WIN_32:                        ${WIN_32}")
	endif()
	if(WIN_64)
		dk_buildLog("WIN_64:                        ${WIN_64}")
	endif()
	if(MAC)
		dk_buildLog("MAC:                           ${MAC}")
	endif()
	if(MAC_32)
		dk_buildLog("MAC_32:                        ${MAC_32}")
	endif()
	if(MAC_64)
		dk_buildLog("MAC_64:                        ${MAC_64}")
	endif()
	if(IOS)
		dk_buildLog("IOS:                           ${IOS}")
	endif()
	if(IOS_32)
		dk_buildLog("IOS_32:                        ${IOS_32}")
	endif()
	if(IOS_64)
		dk_buildLog("IOS_64:                        ${IOS_64}")
	endif()
	if(IOSSIM)
		dk_buildLog("IOSSIM:                        ${IOSSIM}")
	endif()
	if(IOSSIM_32)
		dk_buildLog("IOSSIM_32:                     ${IOSSIM_32}")
	endif()
	if(IOSSIM_64)
		dk_buildLog("IOSSIM_64:                     ${IOSSIM_64}")
	endif()
	if(LINUX)
		dk_buildLog("LINUX:                         ${LINUX}")
	endif()
	if(LINUX_32)
		dk_buildLog("LINUX_32:                      ${LINUX_32}")
	endif()
	if(LINUX_64)
		dk_buildLog("LINUX_64:                      ${LINUX_64}")
	endif()
	if(ANDROID)
		dk_buildLog("ANDROID:                       ${ANDROID}")
	endif()
	if(ANDROID_32)
		dk_buildLog("ANDROID_32:                    ${ANDROID_32}")
	endif()
	if(ANDROID_64)
		dk_buildLog("ANDROID_64:                    ${ANDROID_64}")
	endif()
	if(RASPBERRY)
		dk_buildLog("RASPBERRY:                     ${RASPBERRY}")
	endif()
	if(RASPBERRY_32)
		dk_buildLog("RASPBERRY_32:                  ${RASPBERRY_32}")
	endif()
	if(RASPBERRY_64)
		dk_buildLog("RASPBERRY_64:                  ${RASPBERRY_64}")
	endif()
	dk_buildLog(" ") 
endfunction()


###############################################################################
# dk_addTarget(name target)
#
#	@name:
#	@target:
#
function(dk_addTarget name target)
	DKDEBUGFUNC(${ARGV})
	dk_debug("dk_addTarget( ${ARGV} )")
	if(${name}_targets_OFF)
		list(REMOVE_ITEM ${name}_targets_OFF ${target})
	endif()
	if(${name}_targets)
		dk_set(${name}_targets ${${name}_targets} ${target})
	else()
		dk_set(${name}_targets ${target})
	endif()
	if(${name}_all)
		dk_set(${name}_${target} 1)
#		dk_set(${name}::${target} 1) # TESTME
	endif()
endfunction()


###############################################################################
# dk_removeTarget(name target)
#
#	@name:
#	@target:
#
function(dk_removeTarget name target)
	DKDEBUGFUNC(${ARGV})
	dk_debug("dk_removeTarget( ${ARGV} )")
	if(${name}_targets)
		list(REMOVE_ITEM ${name}_targets ${target})
	endif()
	if(${name}_targets_OFF)
		dk_set(${name}_targets_OFF ${${name}_targets_OFF} ${target})
	else()
		dk_set(${name}_targets_OFF ${target})
	endif()
	dk_set(${name}_${target} 0)
	dk_unset(${name}_${target})
#	dk_unset(${name}::${target}) # TESTME
endfunction()


###############################################################################
# dk_createSmartObject(object)
#
#	TODO
#	We can scan each plugin and attempt to create it's variable and infomation manually here
#
function(dk_createSmartObject object)
	DKDEBUGFUNC(${ARGV})
	dk_debug("dk_createSmartObject(${object})")
	# We require something that can resolve to a full, valid path containing a DKMAKE.cmake file 
endfunction()


###############################################################################
# dk_log(args)
#
#	A simple, quick and easy logger
#
#	@args:
#
function(dk_log args)
	DKDEBUGFUNC(${ARGV})
	dk_debug("${ARGV}")
	set(output " ")
	foreach(arg ${ARGV})
		if(DEFINED ${arg})
			set(output "${output} ${arg}=${${arg}} ")
		else()
			set(output "${output} ${arg}")
		endif()
			dk_info("${output}")
	endforeach()
	dk_wait()
endfunction()


###############################################################################
# dk_removeSubstring(removethis fromthis result)
#
#	@removethis:
#	@fromthis:
#	@result:
#
function(dk_removeSubstring removethis fromthis result)
	DKDEBUGFUNC(${ARGV})
	foreach(item ${fromthis})
		string(REPLACE ${removethis} "" item ${item})
		list(APPEND rtn ${item})
	endforeach()
#	string(REPLACE "  " " " rtn "${rtn}") #replace doube spaces with single space
	set(${result} ${rtn} PARENT_SCOPE) #return result
endfunction()


###############################################################################
# dk_findTarget(target result_path result_type)
#
#	@target:
#	@result_path:
#	@result_type:
#
function(dk_findTarget target result_path result_type)
	DKDEBUGFUNC(${ARGV})
	## search up to 4 levels deep
	file(GLOB children RELATIVE ${DIGITALKNOB}/ 
		${DIGITALKNOB}/${target}/DKMAKE.cmake 
		${DIGITALKNOB}/**/${target}/DKMAKE.cmake 
		${DIGITALKNOB}/**/**/${target}/DKMAKE.cmake 
		${DIGITALKNOB}/**/**/**/${target}/DKMAKE.cmake
		${DIGITALKNOB}/**/**/**/**/${target}/DKMAKE.cmake)
	foreach(child ${children})
		dk_info("FOUND: ${DIGITALKNOB}/${child}")
		string(REPLACE "/DKMAKE.cmake" "" path ${DIGITALKNOB}/${child})
		set(${result_path} ${path} PARENT_SCOPE)
		
		file(STRINGS ${path}/DKMAKE.cmake dkmake_string)
		string(FIND "${dkmake_string}" "DKAPP" index)
		if(${index} GREATER -1)
			set(${result_type} APP PARENT_SCOPE) 
		else()
			set(${result_type} LIBRARY PARENT_SCOPE)	#LIBRARY is default, we need to label executables to detect them
		endif()
		return()
	endforeach()
endfunction()


###############################################################################
# dk_setReadOnly(VAR)
#
#	@VAR:
#	 
macro(dk_setReadOnly VAR)
	DKDEBUGFUNC(${ARGV})
	set("${VAR}" "${ARGN}")						# Set the variable itself
	set("_${VAR}_readonly_val" "${ARGN}")		# Store the variable's value for restore it upon modifications.
	variable_watch("${VAR}" dk_readOnlyCallback)	# Register a watcher for a variable
endmacro()


###############################################################################
# dk_readOnlyCallback(VAR access value current_list_file stack)
#
#	@VAR:
#	@access:
# 	@value:
#	@current_list_file:
#	@stack:
#	 
macro(dk_readOnlyCallback VAR access value current_list_file stack)   # Watcher for readonly property.
	DKDEBUGFUNC(${ARGV})
	if ("${access}" STREQUAL "MODIFIED_ACCESS")
		dk_warn("'${VAR}' is READONLY")
		set(${VAR} "${_${VAR}_readonly_val}")	# Restore a value of the variable to the initial one.
	endif()
endmacro()


###############################################################################
# dk_prependFile(path string)
#
#	@path:
#	@string:
# 
function(dk_prependFile path string)
	DKDEBUGFUNC(${ARGV})
	file(READ "${path}" file_data)
	file(write "${pah}" "${string}\n${filedata}")
endfunction()


###############################################################################
# dk_addRegistryKey(key value data)
#
#	@key:
#	@value:
#	@data:
#
function(dk_addRegistryKey key value data)
	DKDEBUGFUNC(${ARGV})
	if(WIN_HOST)
		string(REPLACE "/" "\\" key   ${key})
		string(REPLACE "/" "\\" value ${value})
		string(REPLACE "/" "\\" data  ${data})
		execute_process(COMMAND reg add "${key}" /v "${value}" /t REG_SZ /d "${data}" /f /reg:64 OUTPUT_VARIABLE _output ERROR_VARIABLE _output RESULT_VARIABLE _failed)
		#dk_debug("_output = ${_output}")
		dk_debug(output)
		#dk_debug("_failed = ${_failed}")
		dk_debug(_failed)
	endif()
endfunction()


###############################################################################
# dk_import(url) #args
#  
#	github GIT:	https://github.com/orginization/library.git		dk_importGit(url) #branch #PATCH
#	github DL:	https://github.com/orginization/library			dk_importGit(url) #lib #id #PATCH
#	lib url DL:	https://website.com/library.zip					dk_importDownload(url) #lib #id #PATCH
#	exe url DL:	https://website.com/executable.exe 				dk_importDownload(url) #lib #id #PATCH
#
#	@url: The online path the .git or file to import
#
#	TODO: https://cmake.org/cmake/help/latest/module/FetchContent.html 
#
function(dk_import) #url #Lib #ID #Patch
	set(url ${ARGV0})
	DKDEBUGFUNC(${ARGV})
	string(FIND ${url} ".git" dotgit)
	if(${dotgit} GREATER -1)
		dk_importGit(${ARGV})
	else()
		dk_importDownload(${ARGV})
	endif()
endfunction()
dk_aliasFunctions("dk_import")


###############################################################################
# dk_importGit(url)
#
function(dk_importGit url) #branch #PATCH
	DKDEBUGFUNC(${ARGV})
	string(REPLACE "/" ";" url_list ${url})  #split url path into list
	foreach(item ${url_list})
		dk_debug(item)
	endforeach()
	
	list(LENGTH url_list url_list_size)
	dk_debug(url_list_size)

	# GITHUB
	if(${url_list_size} LESS 5)
		dk_assert("url_list doesn't contain enough elements to have a 'orginization/library'")
		return()
	endif()	
	
	set(branch "master")
	if(${ARGC} GREATER 1)
		if(NOT "${ARGV1}" STREQUAL "PATCH")
			set(branch "${ARGV1}")
		endif()
	endif()
	
	if(NOT Lib)
		string(FIND ${url} "github.com" result)
		if(${result} EQUAL -1)
			string(FIND ${url} "gitlab.com" result)
			if(${result} EQUAL -1)
				dk_assert("The url does not contain 'github.com' OR 'gitlab.com'")
				return()
			endif()
		endif()
	
		list(GET url_list 3 org)
		dk_debug(org)
	
		list(GET url_list 4 Lib)
		dk_debug(Lib)
		
		string(FIND ${Lib} ".git" index)
		if(${index} GREATER -1)
			string(SUBSTRING ${Lib} 0 ${index} Lib)
		endif()
	endif()
	
	string(TOLOWER ${Lib} Lib)
	dk_debug(Lib)
	
	math(EXPR last "${url_list_size}-1")  #OUTPUT_FORMAT DECIMAL)")  CMake 3.13+
	list(GET url_list ${last} url${last})
	
	string(FIND ${url${last}} ".git" index)
	if(${index} GREATER -1)
		if(NOT ID)
			string(SUBSTRING ${url${last}} 0 ${index} ID)
			string(TOLOWER ${ID} FOLDER)
			dk_debug(FOLDER)
		endif()
	endif()
	
	# check current folder name
	if(NOT "${DKIMPORTS}/${FOLDER}" STREQUAL "${CMAKE_CURRENT_LIST_DIR}")
		dk_assert("\n\nThe Imports folder is named inncorrectly. \n CURRENTLY: ${CMAKE_CURRENT_LIST_DIR} \n SHOULD BE: ${DKIMPORTS}/${FOLDER}\n\n")
		return()
	endif()
	
	string(TOUPPER ${Lib} LIBVAR)
	if(NOT LIBVAR)
		dk_assert("$(LIBVAR) is invalid")
		return()
	endif()
	dk_debug(LIBVAR)
	
	dk_set(${LIBVAR}_FOLDER ${FOLDER})
	if(NOT ${LIBVAR}_FOLDER)
		dk_assert("${LIBVAR}_FOLDER is invalid")
		return()
	endif()
	dk_debug(${LIBVAR}_FOLDER)
	
	dk_set(${LIBVAR}_BRANCH ${branch})
	if(NOT ${LIBVAR}_BRANCH)
		dk_assert("${LIBVAR}_BRANCH is invalid")
		return()
	endif()
	dk_debug(${LIBVAR}_BRANCH)
	
	dk_set(${LIBVAR}_NAME ${FOLDER}-${${LIBVAR}_BRANCH})
	if(NOT ${LIBVAR}_NAME)
		dk_assert("${LIBVAR}_NAME is invalid")
		return()
	endif()
	dk_debug(${LIBVAR}_NAME)
	
	dk_set(${LIBVAR} ${3RDPARTY}/${${LIBVAR}_NAME})
	if(NOT ${LIBVAR})
		dk_assert("${${LIBVAR}} is invalid")
		return()
	endif()
	dk_debug(${${LIBVAR}})
	
	if(NOT EXISTS ${${LIBVAR}}/.git)
		dk_set(CURRENT_DIR ${DIGITALKNOB})
		if(EXISTS ${${LIBVAR}})
			file(REMOVE ${${LIBVAR}})
		endif()
		if(NOT EXISTS ${${LIBVAR}})
			dk_makeDirectory(${${LIBVAR}})
		endif()
		dk_set(CURRENT_DIR ${${LIBVAR}})
		dk_command(${GIT_EXE} clone ${url} ${${LIBVAR}})
	endif()
	dk_set(CURRENT_DIR ${${LIBVAR}})
	dk_command(${GIT_EXE} checkout -- .)
	dk_command(${GIT_EXE} checkout ${branch})
	dk_command(${GIT_EXE} pull)
	
	set(arg_list "${ARGN}")
	foreach(arg IN LISTS arg_list)
		if("${arg}" STREQUAL "PATCH")
			dk_patch(${Lib} ${${LIBVAR}})
		endif()
	endforeach()
endfunction()


###############################################################################
# dk_importDownload(url)
# 
function(dk_importDownload url) #Lib #ID #Patch
	DKDEBUGFUNC(${ARGV})
	# IS THE URL VALID           Example https://github.com/aquawicket/DigitalKnob/archive/01c17f6a9cd66068f7890ea887ab3b9a673f0434.zip)
	# must contain https://github.com/
	# split into list converting / to divider ;
	string(REPLACE "/" ";" url_list ${url})
	foreach(item ${url_list})
		dk_debug(item)
	endforeach()

	list(LENGTH url_list url_length)
	dk_debug(url_length)
	
#	if(${url_length} LESS 5)
#		dk_assert("url_list doesn't contain enough elements to have a 'orginization/library'")
#		return()
#	endif()	
	
	if(${ARGC} GREATER 1)
		if(NOT "${ARGV1}" STREQUAL "PATCH")
			set(Lib ${ARGV1})
			dk_debug(Lib)
		endif()
	endif()
	
	if(${ARGC} GREATER 2)
		if(NOT "${ARGV2}" STREQUAL "PATCH")
			set(ID ${ARGV2})
			dk_debug(ID)
		endif()
	endif()
	
	if(NOT Lib)
		dk_debug(CMAKE_CURRENT_LIST_DIR)
		get_filename_component(Lib ${CMAKE_CURRENT_LIST_DIR} NAME)
		dk_debug(Lib)
#		dk_assert("Lib invalid")
		
#		string(FIND ${url} "github.com" result)
#		if(${result} EQUAL -1)
#			string(FIND ${url} "gitlab.com" result)
#			if(${result} EQUAL -1)
#				dk_assert("Lib invalid and The url does not contain 'github.com' OR 'gitlab.com'")
#				return()
#			endif()
#		endif()
#		list(GET url_list 3 org)
#		dk_debug(org)
#		list(GET url_list 4 Lib)
#		dk_debug(Lib)
	endif()
	
	string(TOUPPER ${Lib} LIB)
	dk_set(LIBVAR ${LIB})
	dk_debug(LIBVAR)
	
	string(TOLOWER ${Lib} FOLDER)
	dk_set(${LIBVAR}_FOLDER ${FOLDER})
	dk_debug(${LIBVAR}_FOLDER)
	
	# check current folder name
	dk_debug("\${DKIMPORTS}/\${${LIBVAR}_FOLDER}} = ${DKIMPORTS}/${${LIBVAR}_FOLDER}}")
	if(NOT "${DKIMPORTS}/${FOLDER}" STREQUAL "${CMAKE_CURRENT_LIST_DIR}")
		dk_assert("The Imports folder is named inncorrectly. \n CURRENTLY: ${CMAKE_CURRENT_LIST_DIR} \n SHOULD BE: ${DKIMPORTS}/${${LIBVAR}_FOLDER}}")
		return()
	endif()
	
	math(EXPR last "${url_length}-1")  #OUTPUT_FORMAT DECIMAL)")  CMake 3.13+
	list(GET url_list ${last} url${last})
	
	######### add recognizable file extensions ##########
	string(FIND ${url${last}} ".7z" index)
	if(${index} GREATER -1)
		if(NOT ID)
			string(SUBSTRING ${url${last}} 0 ${index} ID)
		endif()
		dk_set(${LIBVAR}_DL ${url})
	endif()
	
	string(FIND ${url${last}} ".js" index)
	if(${index} GREATER -1)
		if(NOT ID)
			string(SUBSTRING ${url${last}} 0 ${index} ID)
		endif()
		dk_set(${LIBVAR}_DL ${url})
	endif()
	
	string(FIND ${url${last}} ".tar.bz2" index)
	if(${index} GREATER -1)
		if(NOT ID)
			string(SUBSTRING ${url${last}} 0 ${index} ID)
		endif()
		dk_set(${LIBVAR}_DL ${url})
	endif()
	
	string(FIND ${url${last}} ".tar.gz" index)
	if(${index} GREATER -1)
		if(NOT ID)
			string(SUBSTRING ${url${last}} 0 ${index} ID)
		endif()
		dk_set(${LIBVAR}_DL ${url})
	endif()

	string(FIND ${url${last}} ".zip" index)
	if(${index} GREATER -1)
		if(NOT ID)
			string(SUBSTRING ${url${last}} 0 ${index} ID)
		endif()
		dk_set(${LIBVAR}_DL ${url})
	endif()
	######################################################
	
	
	if(NOT ${LIBVAR}_DL)
		string(FIND ${url} "github.com" result)
		if(${result} EQUAL -1)
#			string(FIND ${url} "gitlab.com" result)
#			if(${result} EQUAL -1)
				dk_assert("The url is not a 'github.com' address")
				return()
#			endif()
		endif()
		
		dk_error("The url doesn't end in .zip or .tar.gz")
		dk_info("We will try to get the master commit id from the page")
		dk_download(${url} ${DKDOWNLOAD}/TEMP/${FOLDER}.html)
		file(READ ${DKDOWNLOAD}/TEMP/${FOLDER}.html PAGE)
#		file(REMOVE ${DKDOWNLOAD}/TEMP/${FOLDER}.html)
		string(FIND "${PAGE}" "spoofed_commit_check" index)
		if(${index} EQUAL -1)
			dk_assert("The page doesn't contain a 'spoofed_commit_check' variable")
			return()
		endif()
		math(EXPR value "${index} + 21") #OUTPUT_FORMAT DECIMAL) # CMake 3.13+
		string(SUBSTRING "${PAGE}" ${value} 40 ID)
		set(ZIP ${ID}.zip)
#		string(SUBSTRING ${ZIP} 0 7 TAG)
		dk_set(${LIBVAR}_DL https://github.com/${org}/${Lib}/archive/${ZIP})
		dk_debug(ID)
		
		## update DKMAKE.cmake file
		dk_copy(${CMAKE_CURRENT_LIST_FILE} ${CMAKE_CURRENT_LIST_FILE}.BACKUP TRUE)
		file(READ ${CMAKE_CURRENT_LIST_FILE} DKMAKE_FILE)
		string(REPLACE "dk_import(${url})" "#dk_import(${url})\ndk_import(${${LIBVAR}_DL})" DKMAKE_FILE ${DKMAKE_FILE})
		string(REPLACE "dk_import(${url} PATCH)" "#dk_import(${url} PATCH)\ndk_import(${${LIBVAR}_DL} PATCH)" DKMAKE_FILE ${DKMAKE_FILE})
        file(WRITE ${CMAKE_CURRENT_LIST_FILE} ${DKMAKE_FILE})
	endif()
	
	if(NOT ${LIBVAR}_DL)
		dk_assert("The url is not a valid .zip or .tar.gz download from github.com and we could not get the master commit ID")
		return()
	endif()
		
	dk_set(${LIBVAR}_BRANCH ${ID})
	dk_set(${LIBVAR}_NAME ${FOLDER}-${${LIBVAR}_BRANCH})
	dk_set(${LIBVAR} ${3RDPARTY}/${${LIBVAR}_NAME})
	
	if(${LIBVAR} AND ${LIBVAR}_BRANCH AND ${LIBVAR}_NAME AND ${LIBVAR}_DL)
		dk_debug(${LIBVAR}_BRANCH)
		dk_debug(${LIBVAR}_DL)
		dk_debug(${LIBVAR}_NAME)
		dk_debug(${LIBVAR})
		dk_install(${${LIBVAR}_DL} ${FOLDER} ${${LIBVAR}} ${ARGN})
	else()
		dk_assert("One of the required LIBVAR:(${LIBVAR}) variables vas not satisfied")
		return()
	endif()
endfunction()


###############################################################################
# dk_DownloadAll3rdParty()
#
function(dk_DownloadAll3rdParty)
	DKDEBUGFUNC(${ARGV})
	dk_dependAll()
	
	# Get a list of all /3rdParty/DKMAKE.cmake paths
	file(GLOB All3rdParty ${DKIMPORTS}/*)
	foreach(item ${All3rdParty})
		if(EXISTS ${item}/DKMAKE.cmake)
			#dk_info("item = ${item}")
			dk_info(item)
			file(STRINGS ${item}/DKMAKE.cmake lines)
			unset(temp_import_script)
			unset(index)
			unset(indexB)
			set(KEEPLINE 0)
	
			foreach(line ${lines})
				string(FIND "${line}" "set(" index)
				if(${index} GREATER -1)
					set(KEEPLINE 1)
				endif()
				string(FIND "${line}" "SET(" index)
				if(${index} GREATER -1)
					set(KEEPLINE 1)
				endif()
				string(FIND "${line}" "dk_download(" index)
				if(${index} GREATER -1)
					set(KEEPLINE 1)
				endif()
				string(FIND "${line}" "dk_install(" index)
				if(${index} GREATER -1)
					set(KEEPLINE 1)
				endif()
				string(FIND "${line}" "dk_import(" index)
				if(${index} GREATER -1)
					set(KEEPLINE 1)
				endif()
				if(KEEPLINE)
					set(dl_import_script "${dl_import_script}${line}\n")
				endif()
				string(FIND "${line}" ")" indexB) 
				if(${indexB} GREATER -1)
					set(KEEPLINE 0)
				endif()
			endforeach()
			
			if(dl_import_script)
				file(WRITE ${DKDOWNLOAD}/TEMP/dl_import.TMP "${dl_import_script}")
				INCLUDE(${DKDOWNLOAD}/TEMP/dl_import.TMP)
				file(REMOVE ${DKDOWNLOAD}/TEMP/dl_import.TMP)
			endif()
		endif()
	endforeach()
endfunction()


######################################################################
# dk_getFileType(path result)
#  
# Takes a path and checks the extension to return the file type.
#
#	@path: A string value of the path to identify
#	@result: returns a string representing the  type of file.
#           Possible results are ARCHIVE, EXECUTABLE, IMAGE, SCRIPT,
#           UNKNOWN, WEB, ...TODO
# Reference: https://en.wikipedia.org/wiki/List_of_file_formats
#
function(dk_getFileType path rtn-type)
	DKDEBUGFUNC(${ARGV})
	dk_getExtension(${path} ext)
	if(NOT ext)
		dk_assert("The path does not contain an extension")
		set(${rtn-type} ERROR PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".app")
		set(${rtn-type} EXECUTABLE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".bash")
		set(${rtn-type} SCRIPT PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".bat")
		set(${rtn-type} SCRIPT PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".bz")
		set(${rtn-type} ARCHIVE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".bz2")
		set(${rtn-type} ARCHIVE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".com")
		set(${rtn-type} WEB PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".exe")
		set(${rtn-type} EXECUTABLE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".gif")
		set(${rtn-type} IMAGE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".gz")
		set(${rtn-type} ARCHIVE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".htm")
		set(${rtn-type} SCRIPT PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".html")
		set(${rtn-type} SCRIPT PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".jpeg")
		set(${rtn-type} IMAGE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".jpg")
		set(${rtn-type} IMAGE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".js")
		set(${rtn-type} SCRIPT PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".png")
		set(${rtn-type} IMAGE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".rar")
		set(${rtn-type} ARCHIVE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".sh")
		set(${rtn-type} SCRIPT PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".tar")
		set(${rtn-type} ARCHIVE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".tif")
		set(${rtn-type} IMAGE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".tiff")
		set(${rtn-type} IMAGE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".xz")
		set(${rtn-type} ARCHIVE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".zip")
		set(${rtn-type} ARCHIVE PARENT_SCOPE)
	else()
		set(${rtn-type} UNKNOWN PARENT_SCOPE)
	endif()
endfunction()


###############################################################################
# dk_import2(url)
#
#	Rework of dk_import()
#
function(dk_import2 url)
	DKDEBUGFUNC(${ARGV})
	dk_debug("DKIMPORT2(${ARGV})")
	#dk_debug("     ARGC = ${ARGC}")
	#dk_debug("     ARGN = ${ARGN}")
	#dk_debug("     ARGV = ${ARGV}")	
	#dk_debug("    ARGV0 = ${ARGV0}")
	#dk_debug("    ARGV1 = ${ARGV1}")
	dk_debug(ARGC)
	dk_debug(ARGN)
	dk_debug(ARGV)	
	dk_debug(ARGV0)
	dk_debug(ARGV1)
	math(EXPR ARGC_LAST "${ARGC}-1") # OUTPUT_FORMAT DECIMAL) #CMake 3.13+
	#dk_debug("ARGC_LAST = ${ARGC_LAST}")
	dk_debug(ARGC_LAST)
	set(ARGV_LAST ${ARGV${ARGC_LAST}})
	#dk_debug("ARGV_LAST = ${ARGV_LAST}")
	dk_debug(ARGV_LAST)
	dk_debug("Is ${url} a file download link or a local path to a container?  archive, .zip, .tar.gz, .7z, .rar, folder, package, etc?")
	string(REPLACE "/" ";" url_list ${url})
	set(n -1)
	foreach(item ${url_list})
		math(EXPR n "${n}+1") # OUTPUT_FORMAT DECIMAL) #CMake 3.13+
		set(url${n} ${item})
		#dk_debug("url${n} = ${url${n}}")
		dk_debug(url${n})
		set(url_end ${n})
	endforeach()
	list(LENGTH url_list url_length)
	#dk_debug("url_length = ${url_length}")
	dk_debug(url_length)
	#dk_debug("url_end = ${url_end}")
	dk_debug(url_end)
	#dk_debug("url{url_end} = ${url${url_end}}")
	dk_debug(url{url_end})
	dk_getFileType(${url} type)
	if(NOT ${type} STREQUAL ARCHIVE) 
	dk_debug("NO")
		dk_debug("Is the url a website we can determine a download file link from?")
			string(FIND ${url} "github.com" hasGithub)
			if(hasGithub)
				dk_debug(hasGithub)
			else()
				dk_debug(hasGithub)
			endif()
			#YES - github, gitlab, etc
				#determin the download link. and goto B ->
			#NO
				#dk_assert("Not a valid download link")
	endif()
	dk_debug("YES")
		dk_debug("Can the LIB_NAME be extracted from the url?")
			#YES
			#Do we have a LIB_NAME locally to compair it with?
				#YES - (directory and or arg2)
				#Do the LIB_NAME's match?
					#YES - #use the LIB_NAME and goto C ->
					#NO - dk_assert("LIB_NAME's do not match")
				#NO
				#use the extracted LIB_NAME and goto C ->
			#NO
			#Do we have a LIB_NAME locally 
				#YES - (directory and or arg2) - #use the local LIB_NAME and goto C ->
				#NO - dk_assert("cannot determine a LIB_NAME")
		#Can the VERSION be extracted from the url? 
			#YES
			#Do we have a VERSION locally to compair it with?
				#YES - (arg3)
				#Does the compair match
					#YES - use VERSION and goto D ->
					#NO - ERROR("LIB_NAME's do not match")
				#NO 
				#use the extracted VERSION and goto D ->
					#NO 
					#Do we have a VERSION locally 
						#YES - (arg3) - #use the local VERSION and goto D ->
						#NO
						#Cam we just use a generated version (time)
							#YES - use generated version and goto D ->
							#NO - dk_assert("Con not determin the version")
		#We have DL, NAME and VERSION
		#Goto dk_install(DL, name, VERSION)
endfunction()


###############################################################################
# dk_getAppDirectory(result)
#
#	Get the OS default app directory
#
function(dk_getAppDirectory result)
	set(USE_32BIT 1)
	if(WIN_HOST)
		set(appDirectory "C:/Program Files")
		if(${USE_32BIT} AND ${WIN64_HOST})
			set(appDirectory "C:/Program Files (x86)")
		endif()
	elseif(MAC_HOST)
		dk_todo() #TODO
		set(appDirectory "/")
	elseif(IOS_HOST)
		dk_todo() #TODO
		set(appDirectory "/")
	elseif(LINUX_HOST)
		dk_todo() #TODO
		set(appDirectory "/")
	elseif(RASPBERRY_HOST)
		dk_todo() #TODO
		set(appDirectory "/")
	elseif(ANDROID_ANDROID)
		dk_todo() #TODO
		set(appDirectory "/")
	endif()
	set(${result} ${appDirectory} PARENT_SCOPE)
endfunction()


###############################################################################
# toLower(str result)
#
#	Convert a string to lower case
#
function(toLower str result)
	string(TOLOWER "${str}" upper)
	set(${result} ${out} PARENT_SCOPE)
endfunction()


###############################################################################
# toUpper(str result)
#
#	Convert a string to upper case
#
function(toUpper str result)
	string(TOUPPER "${str}" upper)
	set(${result} ${upper} PARENT_SCOPE)
endfunction()


###############################################################################
# dk_removeExtension(path result)
#
#	Remove the extension from a file path
#
function(dk_removeExtension path result)
	dk_todo() #TODO
	set(${result} ${out} PARENT_SCOPE)
endfunction()


###############################################################################
# dk_getAppName(path result)
#
#	Get the app name from a file path
#
function(dk_getAppName path result)
	dk_getFilename(${path} fileName)
	dk_removeExtension(${fileName} fileNameNoExt)
	#dk_debug(fileNameNoExt = ${fileNameNoExt})
	dk_debug(fileNameNoExt)
	set(${result} ${fileNameNoExt} PARENT_SCOPE)
endfunction()


###############################################################################
# dk_createPlugin(url)
#
#	Generate a folder/DKMAKE.cmake for a new plugin
#
function(dk_createPlugin url)
	dk_todo() #TODO
	dk_getAppName(${url} App_Name)
	dk_debug(App_Name)					# My_App
	dk_toLower(${App_Name} app_name)
	dk_debug(app_name)					# my_app
	dk_toUpper(${APP_NAME} APP_NAME)
	dk_debug(APP_NAME)					# MY_APP
	dk_getAppDirectory(appDirectory)
	if(NOT exe_path)
		dk_set(exe_path ${appDirectory}/${App_Name}/${App_Name}.exe)
	endif()
endfunction()



include(${DKFunctions_ext})
#dk_watch(dk_getExtension)

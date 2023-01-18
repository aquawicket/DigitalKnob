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


# Extra Documentation
# https://asitdhal.medium.com/cmake-functions-and-macros-22293041519f
# https://foonathan.net/2016/03/cmake-install/ 

if(EXISTS $ENV{DKCMAKE})
	set(ENV{DKCMAKE} "$ENV{DKCMAKE}/")
endif()
include("$ENV{DKCMAKE}DK.cmake")


##################################################################################
# dk_Call(func) parameters
#
#	load a ${func}.cmake file located in the DKCMake path amd call the function and pass arguments
#
#	@func	- TODO
#
macro(dk_call func) #parameters
	#DKDEBUGFUNC(${ARGV})
	dk_load(${func})
	dk_cmakeLanguage("${func}($ARGN)")
endmacro()


###############################################################################
# dk_listReplace(LIST old_value new_value)
#  
#	Replace a list item with a new value
#
#	@LIST		- TODO
#	@old_value	- The value to replace
#	@new_value	- The new value to replace with
#
macro(dk_listReplace LIST old_value new_value)
	#DKDEBUGFUNC(${ARGV})
    list(FIND ${LIST} ${old_value} old_value_INDEX)
    if(old_value_INDEX GREATER_EQUAL 0)
        list(REMOVE_AT ${LIST} ${old_value_INDEX})
        list(INSERT ${LIST} ${old_value_INDEX} ${new_value})
    endif()
endmacro()


###############################################################################
# dk_getArgIdentifiers(ARGV)
#  
#	Get the variable names from function parameters
#
#	@ARGV	- The ARGV data within a function that contains the parameter values
#
function(dk_getArgIdentifiers ARGV)
	#DKDEBUGFUNC(${ARGV})
	#message(STATUS "dk_getArgIdentifiers(${ARGV})")
	list(LENGTH ARGV ARGV_LENGTH)
	if(ARGV_LENGTH LESS 1)
		return()
	endif()
	get_cmake_property(varNames VARIABLES)
	set(index 0)
	unset(names)
	unset(ARGI)
	while(${index} LESS ${ARGV_LENGTH})
		list(APPEND names ARGV${index})
		set(ARGI${index} ARGV${index} CACHE INTERNAL "")
		foreach(varName ${varNames} REVERSE)
			if(ARGV${index} STREQUAL ${varName})
				if("ARGV${index}" STREQUAL "${varName}") #exclude variables with the same name like ARGV0
					continue()
				endif()
				if("ARGN" STREQUAL "${varName}")
					continue()
				endif()
				#if("CMAKE_CURRENT_FUNCTION" STREQUAL "${varName}")
				#	continue()
				#endif()
				dk_listReplace(names ARGV${index} ${varName})
				set(ARGI${index} ${varName} CACHE INTERNAL "")
				#message(STATUS "ARGI${index} == ${ARGI${index}}")
				break()
			endif()
		endforeach()
		math(EXPR index "${index}+1")
	endwhile()
	set(ARGI ${names} CACHE INTERNAL "")
endfunction()


##################################################################################
# dk_debugFunc(${ARGV})
#
#	Prints the current file name, line number, function or macro and arguments
#	Place this at the first line of every function you want to see debug output for.
# 
#	Example:
#		function(MyFunction myArg1 myArg2)
#			dk_debugFunc(${ARGV}) 
#			## user code
#		endfunction()
#
macro(dk_debugFunc)
	#DKDEBUGFUNC(${ARGV})
	if(DKDEBUGFUNC_ENABLED)
		if(NOT CMAKE_CURRENT_FUNCTION_LIST_FILE)
			set(CMAKE_CURRENT_FUNCTION_LIST_FILE "unknown")
		endif()
		get_filename_component(FILENAME ${CMAKE_CURRENT_FUNCTION_LIST_FILE} NAME)
		#dk_getFilename(${CMAKE_CURRENT_FUNCTION_LIST_FILE} FILENAME)
		if(${ARGC} LESS 1)
			dk_updateLogInfo()
			message(STATUS "${H_black}${FILENAME}:${CMAKE_CURRENT_FUNCTION_LIST_LINE}->${CLR}${cyan}${CMAKE_CURRENT_FUNCTION}()${CLR}")
		else()
			set(argIndex 1)
			set(argString " {")
			dk_getArgIdentifiers(${ARGV})
			foreach(arg ${ARGV})
				set(argString "${argString}\"${ARGI${argIndex}}\":\"${arg}\"")
				if(${argIndex} LESS ${ARGC})
					set(argString "${argString},  ")
				endif()
				math(EXPR argIndex "${argIndex}+1")
			endforeach()
			set(argString "${argString}} ")
			message(STATUS "${H_black}${FILENAME}:${CMAKE_CURRENT_FUNCTION_LIST_LINE}->${CLR}${cyan}${CMAKE_CURRENT_FUNCTION}(${argString})${CLR}")
		endif()
	endif()
endmacro()
macro(DKDEBUGFUNC)
	dk_debugFunc(${ARGV})
endmacro()


##################################################################################
# dk_updateLogInfo()
#
#	Updates the STACK_HEADER variable with the current filename, line number, function name and arguments
#
macro(dk_updateLogInfo)
	#DKDEBUGFUNC(${ARGV})
	if(PRINT_CALL_DETAILS)
		set(STACK_HEADER "")
		if(NOT CMAKE_CURRENT_FUNCTION_LIST_FILE)
			if(PRINT_FILE_NAMES)
				get_filename_component(STACK_FILENAME ${CMAKE_CURRENT_LIST_FILE} NAME)
				set(STACK_HEADER "${STACK_FILENAME}:")
			endif()
			if(PRINT_LINE_NUMBERS)		
				set(STACK_HEADER "${STACK_HEADER}${CMAKE_CURRENT_LIST_LINE}->")
			endif()	
		else()
			if(PRINT_FILE_NAMES)
				get_filename_component(STACK_FILENAME ${CMAKE_CURRENT_FUNCTION_LIST_FILE} NAME)
				set(STACK_HEADER "${STACK_FILENAME}:")
			endif()
			if(PRINT_LINE_NUMBERS)	
				set(STACK_HEADER "${STACK_HEADER}${CMAKE_CURRENT_FUNCTION_LIST_LINE}->")
			endif()
		endif()
		if(PRINT_FUNCTION_NAMES)
			set(STACK_HEADER "${STACK_HEADER}${CMAKE_CURRENT_FUNCTION}")
			if(PRINT_FUNCTION_ARGUMENTS)
				set(STACK_HEADER "${STACK_HEADER}(${ARGV}): ")
			else()
				set(STACK_HEADER "${STACK_HEADER}(): ")
			endif()
		endif()
	endif()
endmacro()


##################################################################################
# dk_assert(msg)
#
#	Print an assert message to the console and halts execution
#
#	@msg	- The message to print
#
macro(dk_assert msg)
	#DKDEBUGFUNC(${ARGV})
	#message(STATUS "dk_assert(${ARGV})")
	string(REPLACE " " "" var ${msg})
	dk_updateLogInfo()
	if(${var})
		message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${BG_red} { \"${var}\" : \"${${var}}\" } ${CLR}")
	else()
		message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${BG_red} ${msg} ${CLR}")
	endif()
	dk_exit() #FIXME:  is this needed?
endmacro()


##################################################################################
# dk_error(msg)
#
#	Print a error message to the console
#
#	@msg	- The message to print
#
macro(dk_error msg)
	#DKDEBUGFUNC(${ARGV})
	#message(STATUS "dk_error(${ARGV})")
	dk_updateLogInfo()
	if(${HALT_ON_ERRORS})
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${red} *** HALT_ON_ERRORS *** ${CLR}")
		message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${red} ${msg} ${CLR}")
		dk_exit()
	endif()
	
	string(REPLACE " " "" var ${msg})
	if(${var})
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${red} { \"${var}\" : \"${${var}}\" } ${CLR}")
	else()
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${red} ${msg} ${CLR}")
	endif()
	
	if(${WAIT_ON_ERRORS})
		dk_wait(10)
	endif()
endmacro()


##################################################################################
# dk_warn(msg)
#
#	Print a warning message to the console
#
#	@msg	- The message to print
#
macro(dk_warn msg)
	#DKDEBUGFUNC(${ARGV})
	#message(STATUS "dk_warn(${ARGV})")
	dk_updateLogInfo()
	if(${HALT_ON_WARNINGS})
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${yellow} *** HALT_ON_WARNINGS *** ${CLR}")
		message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${yellow} ${msg} ${CLR}")
		dk_exit()
	endif()
	
	string(REPLACE " " "" var ${msg})
	if(${var})
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${yellow} { \"${var}\" : \"${${var}}\" } ${CLR}")
	else()
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${yellow} ${msg} ${CLR}")
	endif()
	
	if(${WAIT_ON_WARNINGS})
		dk_wait(10)
	endif()
endmacro()


##################################################################################
# dk_info(msg)
#
#	Print a info message to the console
#
#	@msg	- The message to print
#
macro(dk_info msg)
	#DKDEBUGFUNC(${ARGV})
	#message(STATUS "dk_info(${ARGV})")
	string(REPLACE " " "" var ${msg})
	dk_updateLogInfo()
	if(${var})
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${white} { \"${var}\" : \"${${var}}\" } ${CLR}")
	else()
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${white} ${msg} ${CLR}")
	endif()
endmacro()


##################################################################################
# dk_debug(msg)
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
macro(dk_debug msg)
	#DKDEBUGFUNC(${ARGV})
	if(DKDEBUG_ENABLED)
		#message(STATUS "dk_debug(${ARGV})")
		string(REPLACE " " "" var ${msg})
		dk_updateLogInfo()
		if(${var})
			message(STATUS "${H_black}${STACK_HEADER}${CLR}${cyan} { \"${var}\" : \"${${var}}\" } ${CLR}")
		else()
			message(STATUS "${H_black}${STACK_HEADER}${CLR}${cyan} ${msg} ${CLR}")
		endif()
	endif()
endmacro()


##################################################################################
# dk_verbose(msg)
#
#	Print a verbose message to the console
#
#	@msg	- The message to print
#
macro(dk_verbose msg)
	#DKDEBUGFUNC(${ARGV})
	if(DKVERBOSE_ENABLED)
		#message(STATUS "dk_verbose(${ARGV})")
		string(REPLACE " " "" var ${msg})
		dk_updateLogInfo()
		if(${var})
			message(STATUS "${H_black}${STACK_HEADER}${CLR}${blue} { \"${var}\" : \"${${var}}\" } ${CLR}")
		else()
			message(STATUS "${H_black}${STACK_HEADER}${CLR}${blue} ${msg} ${CLR}")
		endif()
	endif()
endmacro()


##################################################################################
# dk_trace(msg)
#
#	Print the trace stack with a message to the console
#
#	@msg	- The message to print
#
macro(dk_trace msg)
	#DKDEBUGFUNC(${ARGV})
	#message(STATUS "dk_trace(${ARGV})")
	dk_updateLogInfo()
	string(REPLACE " " "" var ${msg})
	if(${var})
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${B_blue} { \"${var}\" : \"${${var}}\" } ${CLR}")
	else()
		message(STATUS "${H_black}${STACK_HEADER}${CLR}${B_blue} ${msg} ${CLR}")
	endif()
endmacro()


###############################################################################
# dk_todo(msg)
#
#	print a TODO message and wait 10 seconds
#
#	@msg (optional)	- A header message to print
#
macro(dk_todo)
	#DKDEBUGFUNC(${ARGV})
	if(NOT DKTODO_ENABLED)
		return()
	endif()
	if(${ARGV})
		set(msg "TODO: ${ARGV0}")
	else()
		set(msg "TODO:")
	endif()
	dk_debug(msg)
	#dk_wait(10)
endmacro()


###############################################################################
# dk_pad(str padchar length RESULT)
#
#	Pad the end of a string to length with a given character
#
#   @str		- The string to pad
#   @padchar	- The fill character to use
#	@length		- The number of spaces to pad
#	@RESULT		- The returned string w/padding
#
function(dk_pad str padchar length RESULT)
	#DKDEBUGFUNC(${ARGV})
	string(LENGTH "${str}" _strlen)
	math(EXPR _strlen "${length} - ${_strlen}")

	if(_strlen GREATER 0)
		if(${CMAKE_VERSION} VERSION_LESS "3.14")
			unset(_pad)
			foreach(_i RANGE 1 ${_strlen}) # inclusive
				string(APPEND _pad ${padchar})
			endforeach()
		else()
			string(REPEAT ${padchar} ${_strlen} _pad)
		endif()
    string(APPEND str ${_pad})
  endif()

  set(${RESULT} "${str}" PARENT_SCOPE)
endfunction()


###############################################################################
# dk_includes(variable find RESULT)
#
#	Check if a string contains a substring
#
#	@variable	- The variable
#	@find		- The substring to search for
#	@RESULT		- Returns true if the str contains the substr. Otherwise returns false
#
function(dk_includes variable find RESULT)
	#DKDEBUGFUNC(${ARGV})
	string(FIND "${variable}" "${find}" index)
	if(${index} GREATER -1)
		set(${RESULT} true PARENT_SCOPE)
	else()
		set(${RESULT} false PARENT_SCOPE)
	endif()
endfunction()


###############################################################################
# dk_getParameter(name RESULT ${ARGV})
#
#	get a parameter by name from within a function
#
#	@name		-The input MARKER name for the parameter
#	@RESULT		-The value of the next parameter after the MARKER
#	${ARGV}		-The arg list from the calling function
#
macro(dk_getParameter name RESULT)
	#DKDEBUGFUNC(${ARGV})
	#dk_debug("ARGV = ${ARGV}")
	#dk_debug("ARGN = ${ARGN}")
	set(index 0)
	foreach(arg ${ARGN})
		#dk_debug("index = ${index}")
		#dk_debug("arg = ${arg}")
		#dk_debug("ARGV${index} = ${ARGV${index}}")
		if("${ARGV${index}}" STREQUAL "${name}")
		#if("${arg}" STREQUAL "${name}")
			math(EXPR value "${index}+1")
			set(${RESULT} ${ARGV${value}})
			#dk_debug("dk_getParameter(${name}) = ${${RESULT}}")
		endif()
		math(EXPR index "${index}+1")
	endforeach()
	#dk_debug("dk_getParameter(${name}) = ${${RESULT}}")
endmacro()


###############################################################################
# dk_remove(path [NOERROR])
#
#	Remove a file or directory
#
#	@path		- The full path to the file or direcotory to remove
#   NOERROR     - if NOERROR is specified in the parameters, dk_error() messages will not be displayed
#
function(dk_remove path)
	DKDEBUGFUNC(${ARGV})
	dk_includes("${ARGN}" "NOERROR" has_NOERROR)
	if(${has_NOERROR})
		set(noerror true)
	endif()
	if(NOT EXISTS ${path})
		if(NOT noerror)
			dk_error("${path} does not exist")
		endif()
		return()
	endif()
	file(REMOVE ${path})
	if(EXISTS ${path})
		dk_error("failed to remove ${path}")
	endif()
#	if(IS_DIRECTORY ${path})
#		execute_process(COMMAND ${CMAKE_COMMAND} -E remove_directory ${path})
#	else()
#		execute_process(COMMAND ${CMAKE_COMMAND} -E remove ${path})
#	endif()
endfunction()


###############################################################################
# dk_createOsMacros(func)
#
#	Prefix a function with OS_ macros. Calling the OS_function will only be called if the current OS or OS_HOST is true
#
#	@func	- The func of the function to create aliases for
#
function(dk_createOsMacros func)
	DKDEBUGFUNC(${ARGV})
	if(NOT EXISTS ${DKFunctions_ext})
		file(APPEND ${DKFunctions_ext} "### Don't make changes in this file. They will be overwritten. ###\n")
		file(APPEND ${DKFunctions_ext} "### This file was automatically generated from DKFunctions.cmake ###\n")
	endif()
	file(APPEND ${DKFunctions_ext} "\n## ${func} ##\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN_HOST_${func})\n   if(WIN_HOST)\n      ${func}(\${ARGV})\n  endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN32_HOST_${func})\n   if(WIN_HOST AND X86)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN64_HOST_${func})\n   if(WIN_HOST AND X64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(UNIX_HOST_${func})\n   if(UNIX_HOST)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC_HOST_${func})\n   if(MAC_HOST)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC32_HOST_${func})\n   if(MAC_HOST AND X86)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC64_HOST_${func})\n   if(MAC_HOST AND X64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX_HOST_${func})\n   if(LINUX_HOST)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX32_HOST_${func})\n   if(LINUX_HOST AND X86)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX64_HOST_${func})\n   if(LINUX_HOST AND X64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	
	file(APPEND ${DKFunctions_ext} "macro(WIN_${func})\n   if(WIN)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN32_${func})\n   if(WIN_32)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN64_${func})\n   if(WIN_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(UNIX_${func})\n   if(NOT WIN)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(APPLE_${func})\n   if(MAC OR IOS OR IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(APPLE32_${func})\n   if(MAC_32 OR IOS_32 OR IOSSIM_32)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(APPLE64_${func})\n   if(MAC_64 OR IOS_64 OR IOSSIM_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC_${func})\n   if(MAC)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC32_${func})\n   if(MAC_32)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC64_${func})\n   if(MAC_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS_${func})\n   if(IOS AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS32_${func})\n   if(IOS_32 AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS64_${func})\n   if(IOS_64 AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_${func})\n   if(IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM32_${func})\n   if(IOSSIM_32)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM64_${func})\n   if(IOSSIM_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX_${func})\n   if(LINUX)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX32_${func})\n   if(LINUX_32)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX64_${func})\n   if(LINUX_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_${func})\n   if(RASPBERRY)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY32_${func})\n   if(RASPBERRY_32)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY64_${func})\n   if(RASPBERRY_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID_${func})\n   if(ANDROID)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID32_${func})\n   if(ANDROID_32)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID64_${func})\n   if(ANDROID_64)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(EMSCRIPTEN_${func})\n   if(EMSCRIPTEN)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	
	if("${ARGN}" STREQUAL "NO_DEBUG_RELEASE_TAGS")
		return()
	endif()
	file(APPEND ${DKFunctions_ext} "macro(DEBUG_${func})\n   if(DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN_DEBUG_${func})\n   if(WIN AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN32_DEBUG_${func})\n   if(WIN_32 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN64_DEBUG_${func})\n   if(WIN_64 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(UNIX_DEBUG_${func})\n   if(NOT WIN AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(APPLE_DEBUG_${func})\n   if(MAC OR IOS OR IOSSIM AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC_DEBUG_${func})\n   if(MAC AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC32_DEBUG_${func})\n   if(MAC_32 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC64_DEBUG_${func})\n   if(MAC_64 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS_DEBUG_${func})\n   if(IOS AND DEBUG AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS32_DEBUG_${func})\n   if(IOS_32 AND DEBUG AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS64_DEBUG_${func})\n   if(IOS_64 AND DEBUG AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_DEBUG_${func})\n   if(IOSSIM AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM32_DEBUG_${func})\n   if(IOSSIM_32 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM64_DEBUG_${func})\n   if(IOSSIM_64 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX_DEBUG_${func})\n   if(LINUX AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX32_DEBUG_${func})\n   if(LINUX_32 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX64_DEBUG_${func})\n   if(LINUX_64 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_DEBUG_${func})\n   if(RASPBERRY AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY32_DEBUG_${func})\n   if(RASPBERRY_32 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY64_DEBUG_${func})\n   if(RASPBERRY_64 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID_DEBUG_${func})\n   if(ANDROID AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID32_DEBUG_${func})\n   if(ANDROID_32 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID64_DEBUG_${func})\n   if(ANDROID_64 AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(EMSCRIPTEN_DEBUG_${func})\n   if(EMSCRIPTEN AND DEBUG)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	
	file(APPEND ${DKFunctions_ext} "macro(RELEASE_${func})\n   if(RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN_RELEASE_${func})\n   if(WIN AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN32_RELEASE_${func})\n   if(WIN_32 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(WIN64_RELEASE_${func})\n   if(WIN_64 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(UNIX_RELEASE_${func})\n   if(NOT WIN AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(APPLE_RELEASE_${func})\n   if(MAC OR IOS OR IOSSIM AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC_RELEASE_${func})\n   if(MAC AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC32_RELEASE_${func})\n   if(MAC_32 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(MAC64_RELEASE_${func})\n   if(MAC_64 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS_RELEASE_${func})\n   if(IOS AND RELEASE AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS32_RELEASE_${func})\n   if(IOS_32 AND RELEASE AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOS64_RELEASE_${func})\n   if(IOS_64 AND RELEASE AND NOT IOSSIM)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM_RELEASE_${func})\n   if(IOSSIM AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM32_RELEASE_${func})\n   if(IOSSIM_32 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(IOSSIM64_RELEASE_${func})\n   if(IOSSIM_64 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX_RELEASE_${func})\n   if(LINUX AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX32_RELEASE_${func})\n   if(LINUX_32 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(LINUX64_RELEASE_${func})\n   if(LINUX_64 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY_RELEASE_${func})\n   if(RASPBERRY AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY32_RELEASE_${func})\n   if(RASPBERRY_32 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(RASPBERRY64_RELEASE_${func})\n   if(RASPBERRY_64 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID_RELEASE_${func})\n   if(ANDROID AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID32_RELEASE_${func})\n   if(ANDROID_32 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(ANDROID64_RELEASE_${func})\n   if(ANDROID_64 AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
	file(APPEND ${DKFunctions_ext} "macro(EMSCRIPTEN_RELEASE_${func})\n   if(EMSCRIPTEN AND RELEASE)\n      ${func}(\${ARGV})\n   endif()\nendmacro()\n")
endfunction()
set(dk_disabled_list ""	CACHE INTERNAL "")
set(DKFunctions_ext ${DKCMAKE}/DKFunctions_ext.cmake)
dk_remove(${DKFunctions_ext} NOERROR)


###############################################################################
# dk_return()
#
#	Print the CMAKE_CURRENT_LIST_DIR and return.
#
macro(dk_return)
	#DKDEBUGFUNC(${ARGV})
	message(STATUS "${CMAKE_CURRENT_LIST_DIR} -> dk_return()")
	return()
endmacro()
dk_createOsMacros("dk_return")


###############################################################################
# dk_printAllVariables()
#
#	Print all cmake varibles and save to /cmake_variables.temp 
#
macro(dk_printAllVariables)
	DKDEBUGFUNC(${ARGV})
	get_cmake_property(varNames VARIABLES)
	list(SORT varNames)
	foreach(varName ${varNames})
		dk_info(varName)
		file(APPEND ${CMAKE_BINARY_DIR}/cmake_variables.temp "${varName}				==				${${varName}}\n")
	endforeach()
endmacro()


###############################################################################
# dk_set(variable value)
#	
#	https://stackoverflow.com/a/29250496/688352
#
#	@variable	- The name of a variable to declair
#	@value		- The value to set the variable to. 
#
function(dk_set variable value)
	DKDEBUGFUNC(${ARGV})
	set(${variable} ${value} ${ARGN} CACHE INTERNAL "")
#	###### print library versions ############
#	dk_includes(${variable} "_VERSION" includes)
#	if(${includes})
#		dk_info("${variable}: ${value}")
#	endif()
#	##########################################
endfunction()
dk_createOsMacros("dk_set")


###############################################################################
# dk_append(variable value)
#
#	@variable	- The name of a variable to declaire
#	@value		- The value to add to the variable.
#
function(dk_append variable value)
	DKDEBUGFUNC(${ARGV})
	set(${variable} "${${variable}} ${value} ${ARGN}" CACHE INTERNAL "")
endfunction()
dk_createOsMacros("dk_append")


###############################################################################
# dk_unset(variable)
#
#	Remove a variable definition. will become undefined. 
#
#	@variable	- The name of the variable to unset
#
function(dk_unset variable)
	DKDEBUGFUNC(${ARGV})
	set(${variable} "" CACHE INTERNAL "")
	unset(${variable})
	#set(${variable} "" CACHE INTERNAL "")
	#set(variable "" CACHE INTERNAL "")
	#unset(${variable} CACHE)
	#unset(variable CACHE)
endfunction()
dk_createOsMacros("dk_unset")


###############################################################################
# dk_exit()
#
#	Exit cmake
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
# dk_isNumber(variable RESULT)
# 
#	Test if a varaible is a number
#
#	@variable	- The variable to test
#	@RESULT: 	- True if the variable is a number, False if otherwise.
#
macro(dk_isNumber variable RESULT)
	DKDEBUGFUNC(${ARGV})
	if(variable MATCHES "^[0-9]+$")
		set(${RESULT} TRUE)
	else()
		set(${RESULT} FALSE)
	endif()
endmacro()


##############################################################################
# dk_wait([timeout] [msg])
# 
#	Wait until a keypress or timeout has elapsed in seconds
#
#	@timeout:(Optional)	- default = 60
#	@msg:(Optional)		- default = "press and key to continue."
#
macro(dk_wait) 
	DKDEBUGFUNC(${ARGV})
	set(timeout ${ARGV0})
	set(msg ${ARGV1})
	
	dk_isNumber(timeout isNumber)
	if(NOT isNumber)
		set(timeout 60) # default
	endif()
	
	if(NOT msg)
		set(msg "press and key to continue.") # default
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
#	@variable	- The variable to print to the screen. Without variable brackets ${ }'
#
macro(dk_dump variable)
	DKDEBUGFUNC(${ARGV})
	message(STATUS "\n${cyan}############################### Variable DUMP ##############################################${CLR}")	
	if(CMAKE_CURRENT_FUNCTION_LIST_FILE)
		dk_getFilename(${CMAKE_CURRENT_FUNCTION_LIST_FILE} FILENAME)
	endif()
	if(NOT DEFINED ${variable})
		dk_error("variable not defined. The syntax may be incorrect if using brackets - > \$ { variable } ")
		dk_info("${CLR}${green} dk_dump(variable): <- CORRECT SYNTAX")
	else()
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
	endif()
	#dk_wait()
endmacro()


##############################################################################
# dk_watch(variable)
# 
#	Watch a varible reading and writing access events
#
#	@variable	- The variable to watch
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
#	@variable	- The variable to watch
#	@access 	- TODO
#	@val 		- TODO
#   @1st 		- TODO
#	@stack 		- TODO
#
macro(dk_watchCallback variable access val lst stack)
	DKDEBUGFUNC(${ARGV})
	message(STATUS "${cyan}##################################################################################################${CLR}")
	message(STATUS "${cyan}   Variable watch: variable=${${variable}} access=${access} val=${val} 1st=${1st} stack=${stack}  ${CLR}")
	message(STATUS "${cyan}##################################################################################################${CLR}")
	dk_wait()
endmacro()


##############################################################################
# dk_setXcodeProperty(TARGET property value)
# 
#	Set a XCode specific property
#
#   @TARGET		- The project target name to set the property for
#	@property	- The name of the property to set
#   @value		- The value to set the property to
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
#	@path	- The path to search for empty folders to delete
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
# dk_getEnv(name RESULT)
#
#	Get a system environment variable
#
#	@name		- The name of the system environment variable to get
#	@RESULT		- Returns the value of the system environment vairable
#
function(dk_getEnv name RESULT)
	DKDEBUGFUNC(${ARGV})
	dk_debug(ENV{${name}})
	set(${RESULT} $ENV{${name}} PARENT_SCOPE)
endfunction()


###############################################################################
# dk_download(src_path dest_path) #NOERROR
#
#	Download a file
#
#	@src_path	- The url of the file to download
#	@dest_path	- The path to download the file to
#   NOERROR     - if any of the parameters equals NOERROR, dk_error() messages will not be displayed
#
#	Notes: https://cmake.org/pipermail/cmake/2012-September/052205.html/
#
function(dk_download src_path) # ARGV1 = dest_path #NOERROR
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

	set(dest_path ${ARGV1})
	
	dk_includes("${ARGN}" "NOERROR" includes)
	if(${includes})
		set(noerror true)
	endif()
	
	# Setup all src_path variables
	if(NOT src_path)
		dk_assert("src_path is invalid")
	endif()
	dk_debug(src_path)
	
	get_filename_component(src_dir ${src_path} DIRECTORY)
	if(NOT src_dir)
		dk_assert("src_dir is invalid")
	endif()
	dk_debug(src_dir)
	
	get_filename_component(src_filename ${src_path} NAME)
	if(NOT src_filename)
		dk_assert("src_filename is invalid")
	endif()
	dk_debug(src_filename)
	
	dk_getExtension(${src_path} src_ext)	
	if(NOT src_ext)
		dk_assert("src_ext is invalid")
	endif()
	dk_debug(src_ext)
	
	# Setup all dest_path variables
	if(NOT dest_path)
		set(dest_path ${DKDOWNLOAD})
	endif()
	if(NOT dest_path)
		dk_assert("dest_path is invalid")
	endif()	
	if(IS_DIRECTORY ${dest_path})
		set(dest_path "${dest_path}/${src_filename}")
	endif()
	dk_debug(dest_path)
	
	get_filename_component(dest_dir ${dest_path} DIRECTORY)
	if(NOT dest_dir)
		dk_assert("dest_dir is invalid")
	endif()
	if(NOT EXISTS ${dest_dir})
		dk_warn("dest_dir:(${dest_dir}) does not exists. It will be created")
		dk_makeDirectory(${dest_dir})
	endif()
	dk_set(CURRENT_DIR ${dest_dir})
	dk_debug(dest_dir)
	
	get_filename_component(dest_filename ${dest_path} NAME)
	if(NOT dest_filename)
		dk_assert("dest_filename is invalid")
		return()
	endif()
	dk_debug(dest_filename)
	
	dk_getExtension(${dest_path} dest_ext)
	if(NOT dest_ext)
		dk_assert("dest_ext is invalid")
	endif()
	dk_debug(dest_ext)
	
	if(EXISTS ${dest_path})
		if(NOT noerror)
			dk_error("dest_path:(${dest_path}) already exists")
		endif()
		return()
	endif()
	
	dk_debug("Downloading ${src_path}")
	dk_debug("      To -> ${dest_path}")
	
	# setup temp_path variables
	set(temp_filename "${dest_filename}.downloading")
	set(temp_path ${dest_dir}/${temp_filename})
	dk_debug(temp_path)
	if(EXISTS ${temp_path})
		dk_remove(${temp_path})
	endif()
	if(EXISTS ${temp_path})
		dk_assert("temp_path:(${temp_path}) could not be removed")
	endif()
	
	dk_info("Downloading ${src_filename}. . . please wait")
	file(DOWNLOAD ${src_path} ${temp_path} 
		SHOW_PROGRESS 
		INACTIVITY_TIMEOUT 70
		STATUS status 
	)
	list(GET status 0 status_code) 
	list(GET status 1 status_string)
	if(NOT status_code EQUAL 0)
		dk_remove(${temp_path})
		dk_assert("error: downloading ${src_path} \nstatus_code: ${status_code} \nstatus_string: ${status_string}")
	else()
		if(NOT EXISTS ${temp_path})
			dk_assert("temp_path:(${temp_path}) could not locate temporary download file")
		endif()
		dk_rename(${temp_path} ${dest_path})
		if(NOT EXISTS ${dest_path})
			dk_assert("dest_path:(${dest_path}) Could not locate downloaded file")
		endif()
		dk_info("${CLR}${green} Finnished downloading ${dest_filename}")
	endif() 
endfunction()
dk_createOsMacros("dk_download")


###############################################################################
# dk_extract(src dest)
#
#	Extract a archive file
#
#	@src	- The full path of the archive file
#	@dest	- The folder path to extract the archive to
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
#	Compress a path to a assets.zip archive
#
#	@path	- The full path to add to the archive file
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
# dk_copy(from to) OVERWRITE NOERROR
#
#	Copy a file or directory to another location
#
#	@from		- The source path to copy
#	@to			- The destination path to copy to
#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing files is enabled
#   NOERROR     - if any of the parameters equals NOERROR, dk_error() messages will not be displayed
#
function(dk_copy from to) # OVERWRITE NOERROR
	DKDEBUGFUNC(${ARGV})
	
	dk_includes("${ARGN}" "OVERWRITE" includes)
	if(${includes})
		set(overwrite true)
	endif()
	
	dk_includes("${ARGN}" "NOERROR" includes)
	if(${includes})
		set(noerror true)
	endif()
	
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
						dk_error( "dk_copy(${from} ${to} ${overwrite}): \n ERROR: compare_result = ${compare_result}")
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
		if(NOT noerror)
			dk_error("from:(${from}) The source path does not exist")
		endif()
	endif()
endfunction()
dk_createOsMacros("dk_copy")


###############################################################################
# dk_filesMatch(fileA fileB)
#
#	TODO
#
#	@fileA	- TODO
#	@fileB	- TODO
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
# dk_rename(from to) OVERWRITE NOERROR
#
#	Rename file or directory or move a file or directory to another location
#
#	@from		- The source path to copy
#	@to			- The destination path to copy to
#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing files is enabled
#   NOERROR     - if any of the parameters equals NOERROR, dk_error() messages will not be displayed
#
function(dk_rename from to) # FLAGS: OVERWRITE, NOERROR
	DKDEBUGFUNC(${ARGV})
	dk_includes("${ARGN}" "OVERWRITE" includes)
	if(${includes})
		set(overwrite true)
	endif()
	dk_includes("${ARGN}" "NOERROR" includes)
	if(${includes})
		set(noerror true)
	endif()
	dk_info("Renameing ${from} to ${to}")
	if(NOT EXISTS ${from})
		if(NOT noerror)
			dk_error("from:${from} not found")
		endif()
		return()
	endif()
	if(EXISTS ${to})
		if(NOT ${overwrite})
			dk_assert("Cannot rename file. Destiantion exists and not set to overwrite")
		endif()
		dk_remove(${to})
	endif()
	file(RENAME ${from} ${to})
endfunction()
dk_createOsMacros("dk_rename")

###############################################################################
# dk_upxCompress(path)
#
#	UPX compress an executable or dynamic library file
#
#	@path		- The full path to the binary file to compress with UPX
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
#	TODO
#
#	@plugin		- TODO
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
# dk_disable(plugin) #target
#
#	TODO
#
#	@plugin				- TODO
#	@target:(optional)	- TODO
#
function(dk_disable plugin)
	DKDEBUGFUNC(${ARGV})
	set(target ${ARGV1})
	
	if(BYPASS_DISABLE)
		dk_info("* dk_disable(${plugin}) ignored.  BYPASS_DISABLE is set to ON. ${plugin} will not be disabled *")
		return()
	endif()
	
	if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKCMAKE})
		if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKPROJECT})
			if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKIMPORTS}/${plugin})
				if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKPLUGINS}/${plugin})
					dk_assert("dk_disable() Can only be used from the DKCMake/DKDisabled.cmake file. This is to avoid having disabled libraries hideing everywhere")
				endif()
			endif()
		endif()
	endif()
	
	if(NOT EXISTS ${DKIMPORTS}/${plugin}/DKMAKE.cmake)
		if(NOT EXISTS ${DKPLUGINS}/${plugin}/DKMAKE.cmake)
			dk_warn("dk_disable(${plugin}):  unable to locate plugin in /3rdParty/_DKIMPORTS  or /DKPlugins")
			return()
		endif()
	endif()
	
	if(${ARGC} GREATER 1)
	#if(target)
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
#	TODO
#
#	@str	- TODO
#
function(dk_define str)
	DKDEBUGFUNC(${ARGV})
	if(CMAKE_SCRIPT_MODE_FILE)
		return()
	endif()
	list(FIND DKDEFINES_LIST "${str}" index)
	if(${index} GREATER -1)
		return() # already in the list
	endif()
	dk_set(DKDEFINES_LIST ${DKDEFINES_LIST} ${str})
	add_definitions(-D${str})
endfunction()
dk_createOsMacros("dk_define")


###############################################################################
# dk_undefine(str)
#
#	TODO
#
#	@str	- TODO
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
#	@path	- The path to add to the compiler include paths
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
dk_createOsMacros("dk_include")


###############################################################################
# dk_linkDir(path)
#
#	Add a directory to the compiler library paths
#
#	@path	The path to add to the compiler library paths
#
function(dk_linkDir path)
	DKDEBUGFUNC(${ARGV})
	foreach(item ${ARGV})
		list(FIND DKLINKDIRS_LIST "${item}" index)
		if(${index} GREATER -1)
			continue()  # already in the list
		endif()
		dk_set(DKLINKDIRS_LIST ${DKLINKDIRS_LIST} ${item})
		link_directories(${item})
	endforeach()
endfunction()
dk_createOsMacros("dk_linkDir")


###############################################################################
# dk_getCurrentDirectory(RESULT)
#
#	Retrieve the current working directory
#
#	@RESULT: returns the current working directory upon success. False upon error
#
#function(dk_getCurrentDirectory RESULT)
#	DKDEBUGFUNC(${ARGV})
#	if(WIN_HOST)
#		execute_process(COMMAND echo "hello world" ECHO_OUTPUT_VARIABLE output WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
#	else()
#		execute_process(COMMAND pwd ECHO_OUTPUT_VARIABLE output WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
#	endif()
#	execute_process(COMMAND timeout /t 2 /nobreak WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})  ##wait 2 seconds for the stdout to flush
#	#dk_info("output = ${output}")
#	dk_info(output)
#	set(${RESULT} ${output} PARENT_SCOPE)
#endfunction()


###############################################################################
# dk_makeDirectory(path)
#
#	Create a directory 
#
#	@path	- The full path to the direcotory to be created
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
dk_createOsMacros("dk_makeDirectory")

###############################################################################
# dk_getDirectory(path RESULT)
#
#	Get the directory portion of a path
#
#	@path		- The path to use
#	@RESULT		- Returns the directory upon success: False upon error
#
function(dk_getDirectory path RESULT)
	DKDEBUGFUNC(${ARGV})
	string(FIND ${path} "/" index REVERSE)
	if(${index} EQUAL -1)
	#dk_includes(${path} "/" index REVERSE)
	#if(NOT ${index})
		return() # no path dividers found
	endif()
	string(SUBSTRING ${path} 0 ${index} directory) 
    set(${RESULT} ${directory} PARENT_SCOPE)
endfunction()


# FIXME:  not working
###############################################################################
# dk_getFilename(path RESULT)
#
#	Get the filename portion of a path
#
#	@path		- The path to use
#	@RESULT:	- Returns the file name upon success: False upon error
#
function(dk_getFilename path RESULT)
	DKDEBUGFUNC(${ARGV})
	string(FIND ${path} "/" index REVERSE)
	if(${index} EQUAL -1)
	#dk_includes(${path} "/" index REVERSE)
	#if(NOT ${index})
		dk_error("No Path Dividers found")
	endif()
	MATH(EXPR index "${index}+1")
	string(SUBSTRING ${path} ${index} -1 filename) 
    set(${RESULT} ${filename} PARENT_SCOPE)
endfunction()


###############################################################################
# dk_getExtension(path RESULT)
#
#	Get the extension portion of a path
#
#	@path		- The path to use
#	@RESULT:	- Returns the extension upon success: False upon error
#
function(dk_getExtension path RESULT)
	DKDEBUGFUNC(${ARGV})
	# WHY A NEW GET EXTENSION FUNCTION ?
#	get_filename_component(extension ${url} EXT)       #Gets the large part of the extension of everything after the first .
#	get_filename_component(extension ${url} LAST_EXT)  #LAST_EXT only available with cmake 3.14+ 
#	cmake_path(GET url EXTENSION LAST_ONLY extension)  #LAST_ONLY only available with cmake 3.19+
	string(FIND ${path} "." index REVERSE)
	if(${index} EQUAL -1)
	#dk_includes(${path} "." index REVERSE)
	#if(NOT ${index})
		return() # no extension found
	endif()
	string(SUBSTRING ${path} ${index} -1 ext)

	#look for .tar
	math(EXPR tar ${index}-4)
	if(${tar} GREATER -1)
		string(SUBSTRING ${path} ${tar} -1 tarext)
		if("${tarext}" STREQUAL ".tar${ext}")
			set(ext ${tarext})
		endif()
	endif()
    set(${RESULT} ${ext} PARENT_SCOPE)
endfunction()

###############################################################################
# dk_dirIsEmpty(path RESULT)
#
#	Get weather or not a directory is empty
#
#	@path		- The full path to the directory to check
#	@RESULT		- Returns true if the directory is empty. False if the directory is not empty
#
function(dk_dirIsEmpty path RESULT)
	DKDEBUGFUNC(${ARGV})
	if(EXISTS ${path})
		file(GLOB items RELATIVE "${path}/" "${path}/*")
		list(LENGTH items count)
		if(${count} GREATER 0)
			set(${RESULT} false PARENT_SCOPE)
			return()
		endif()
	endif()
	set(${RESULT} true PARENT_SCOPE)
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
#	@import_name	- The name of the 3rdParty DKIMPORT library
#	@dest_path		- The location of the installed library under /3rdParty
#
function(dk_patch import_name dest_path)
	DKDEBUGFUNC(${ARGV})
	dk_warn("COPYING PATCH FILES FROM _IMPORTS/${import_name} TO ${dest_path}")
	dk_warn("To stop patch files from overwriting install files, remove the \"PATCH\" argument from the end of the dk_import or dk_install command")
	dk_warn("located in ${DKIMPORTS}/${import_name}/DKMAKE.cmake")
	dk_copy(${DKIMPORTS}/${import_name}/ ${dest_path}/ OVERWRITE)
endfunction()


###############################################################################
# dk_install(plugin)
#
#	Install a 3rdParty library, executable or package
#	For archive files such as libraries and assets, the arguments are:  The download url_path, the name of its _DKIMPORTS folder, The name given to the installed 3rdParty/folder  
#	For executable files such as software amd IDE's the arguments are:  The download url_path, the name of the final name of the dl file, The installation path to check for installation.
#
#	@url_path			-The download url or local path to an install file. May be .zip, .exe, .msi, .tar.gz etc. 
#	@dest_path			-The path to the install location under DK/3rdParty
#	@plugin (optional)	-The name of the 3rdParty package being installed
#	PATCH				-Patch the install directory with files from the DKIMPORTS path
#
function(dk_install plugin) #PATCH
	DKDEBUGFUNC(${ARGV})
	
	# set PLUGIN_URL variable
	string(TOUPPER ${plugin} plugin_var)	
	set(dest_path ${${plugin_var}})			
	set(url_path ${${plugin_var}_URL})
	
	#if(NOT "${ARGV2}" STREQUAL "PATCH")
	#	set(plugin ${ARGV2})
	#endif()
	
	#if(NOT plugin)
	#	get_filename_component(plugin ${CMAKE_CURRENT_LIST_DIR} NAME)
	#else()
	#	get_filename_component(plugin ${plugin} NAME)
	#endif()
	
	#string(TOLOWER ${plugin} plugin_lower)
	#if(NOT ${plugin} STREQUAL ${plugin_lower})
	#	dk_error("ERROR:  dk_install() (${plugin}) must be all lowercase")
	#endif()
	
	if(NOT EXISTS ${DKIMPORTS}/${plugin})
		dk_assert("ERROR: dk_install() (${DKIMPORTS}/${plugin}) does not exist")
	endif()
	
	if(EXISTS ${dest_path}/installed)
		dk_info("${plugin} already installed")
		dk_includes("${ARGN}" "PATCH" hasPATCH)
		if(${hasPATCH})
			dk_patch(${plugin} ${dest_path})
		endif()
		return()
	endif()
	dk_debug(" ")
	dk_debug(url_path)
	dk_getDirectory(${url_path} url_directory)
	dk_debug(url_directory)
	dk_getFilename(${url_path} url_filename)
	dk_debug(url_filename)
	dk_getExtension(${url_filename} url_extension)
	dk_debug(url_extension)
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
	string(TOLOWER ${url_filename} url_filename_lower)
	string(FIND ${url_filename_lower} ${plugin} index)
	if(${index} EQUAL -1)
	#dk_includes(${url_filename_lower} ${plugin} result)
	#if(NOT ${result})
		dk_debug("The download filename ${url_filename} does not contaian the import name ${plugin}")
		string(TOLOWER ${dest_filename} dest_filename_lower)
		string(FIND ${dest_filename_lower} ${plugin} index)
		if(${index} EQUAL -1)
		#dk_includes(${dest_filename_lower} ${plugin} result)
		#if(NOT ${result})
			set(dl_filename "${plugin}-${dest_filename}${url_extension}") 
		else()
			set(dl_filename "${dest_filename}${url_extension}")
		endif()
	elseif(NOT ${url_filename} MATCHES "[0-9]")
		dk_debug("The download filename ${url_filename} does not contain any numbers to identify it's version")
		dk_debug("Normally we would rename the downloaded filename to ${dest_filename}${url_extension}, but we'll let it pass.")
# 		set(dl_filename "${dest_filename}${url_extension}")
		set(dl_filename ${url_filename})
	else()
		set(dl_filename ${url_filename})
	endif()
	
	dk_download(${url_path} ${DKDOWNLOAD}/${dl_filename} NOERROR)
	# TODO: delete downloaded file after extraction to conserve disk space
	
	if(NOT EXISTS ${DKDOWNLOAD}/${dl_filename})
		dk_assert("The download files does not exist")
	endif()
	
	set(FILETYPE "UNKNOWN")
	if(NOT ${url_extension} STREQUAL "")
		if(${url_extension} STREQUAL ".bz")
			set(FILETYPE "Archive")
		elseif(${url_extension} STREQUAL ".bz2")
			set(FILETYPE "Archive")
		elseif(${url_extension} STREQUAL ".exe")
			dk_includes(${url_filename} ".sfx.exe" result)
			if(${result})
				set(FILETYPE "Archive")
			else()
				set(FILETYPE "Executable")
			endif()
		elseif(${url_extension} STREQUAL ".dmg")
			set(FILETYPE "BYPASS")
		elseif(${url_extension} STREQUAL ".gz")
			set(FILETYPE "Archive")
		elseif(${url_extension} STREQUAL ".js")
			set(FILETYPE "Javascript")
		elseif(${url_extension} STREQUAL ".rar")
			set(FILETYPE "Archive")
		elseif(${url_extension} STREQUAL ".tar")
			set(FILETYPE "Archive")
		elseif(${url_extension} STREQUAL ".tgz")
			set(FILETYPE "Archive")
		elseif(${url_extension} STREQUAL ".xz")
			set(FILETYPE "Archive")
		elseif(${url_extension} STREQUAL ".zip")
			set(FILETYPE "Archive")
		elseif(${url_extension} STREQUAL ".AppImage")
			set(FILETYPE "Executable")
		endif()
	endif()
	# If the file type is unknown, we'll still try to extract it like a compressed file anyway
	# It's better the have a chance at success.
	dk_debug("The Downloaded file ${${dl_filename}} is a ${FILETYPE} file ${url_extension}")
	if(${FILETYPE} STREQUAL "UNKNOWN")
		set(FILETYPE "Archive")
		dk_debug("We will try to extract it in case it's an archive, but it may fail.")
	endif()
	if(${FILETYPE} STREQUAL "Archive")
		dk_info("Extracting ${dl_filename}")
		dk_remove(${DKDOWNLOAD}/UNZIPPED NOERROR)
		dk_extract(${DKDOWNLOAD}/${dl_filename} ${DKDOWNLOAD}/UNZIPPED)
		# We either have a root folder in /UNZIPPED, or multiple files without a root folder
		file(GLOB items RELATIVE "${DKDOWNLOAD}/UNZIPPED/" "${DKDOWNLOAD}/UNZIPPED/*")
		list(LENGTH items count)
		if(${count} GREATER 2) ##NOTE: This should be "${count} GREATER 1" but msys has a readme file in it next to the inner msys folder and that messes things up for more than 1
			#vZip extracted with no root folder, Rename UNZIPPED and move to 3rdParty
			dk_rename(${DKDOWNLOAD}/UNZIPPED ${dest_path} OVERWRITE)
		else()
			if(EXISTS ${DKDOWNLOAD}/UNZIPPED/${dest_filename}) ##Zip extracted to expected folder. Move the folder to 3rdParty
				dk_rename(${DKDOWNLOAD}/UNZIPPED/${dest_filename} ${dest_path} OVERWRITE)
				dk_remove(${DKDOWNLOAD}/UNZIPPED)
			else() #vZip extracted to a root folder, but not named what we expected. Rename and move folder to 3rdParty
				foreach(item ${items})
					if(NOT IS_DIRECTORY ${DKDOWNLOAD}/UNZIPPED/${item})
						list(REMOVE_ITEM items ${item}) #remove any readme.txt or other non-directory items
					endif()
				endforeach()
				dk_rename(${DKDOWNLOAD}/UNZIPPED/${items} ${dest_path} OVERWRITE)
				dk_remove(${DKDOWNLOAD}/UNZIPPED)
			endif() 
		endif()
	elseif(${FILETYPE} STREQUAL "Executable")
		dk_setPath(${DKDOWNLOAD})
		dk_set(QUEUE_BUILD ON)
		dk_executeProcess(${DKDOWNLOAD}/${dl_filename})
	elseif(${FILETYPE} STREQUAL "BYPASS")
		# (BYPASS) do nothing
	else() #NOT ARCHIVE, just copy the file into it's 3rdParty folder
		dk_copy(${DKDOWNLOAD}/${dl_filename} ${dest_path}/${dl_filename} OVERWRITE)
		dk_debug("dk_copy(${DKDOWNLOAD}/${dl_filename} ${dest_path}/${dl_filename} OVERWRITE)")
	endif()
	
	string(FIND "${ARGN}" "PATCH" index)
	if(${index} GREATER -1)
	#dk_includes("${ARGN}" "PATCH" index)
	#if(${index})
		dk_patch(${plugin} ${dest_path})
	else()
		file(GLOB ITEMS ${DKIMPORTS}/${plugin}/*)
		list(LENGTH ITEMS count)
		if(${count} GREATER 1)
			dk_warn(" Found ${count} items in the ${plugin} import folder. dk_install has not requested to PATCH the installed files. If needed, add PATCH as the last argument to the dk_install or dk_import command in ${DKIMPORTS}/${plugin}/DKMAKE.cmake ")
		endif()
	endif()
	
	file(WRITE ${dest_path}/installed "${dest_filename} ")
	
	dk_set(DK_DELETE_EXTRACTED_DOWNLOADS ON) # FIXME: move to global dk settings
	if(DK_DELETE_EXTRACTED_DOWNLOADS) # conserve disk space 
		dk_info("deleting ${DKDOWNLOAD}/${dl_filename}. . .")
		dk_remove(${DKDOWNLOAD}/${dl_filename})
	endif()
endfunction()
dk_createOsMacros("dk_install" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_validatePath(path RESULT)
#
#	TODO
#
#	@path		- TODO
#	@RESULT		- TODO
#
function(dk_validatePath path RESULT)
	DKDEBUGFUNC(${ARGV})
	get_filename_component(path ${path} ABSOLUTE)
	set(${RESULT} ${path} PARENT_SCOPE)
endfunction()


###############################################################################
# dk_getShortPath(path RESULT)
#
#	TODO
#
#	@path		- TODO
#	@RESULT		- TODO
#
function(dk_getShortPath path RESULT)
	DKDEBUGFUNC(${ARGV})
	if(WIN_HOST)
		file(WRITE ${DKCMAKE}/dk_getShortPath.cmd "@ECHO OFF \necho %~s1")
		execute_process(COMMAND ${DKCMAKE}/dk_getShortPath.cmd ${path} OUTPUT_VARIABLE path WORKING_DIRECTORY ${DIGITALKNOB})
		string(REPLACE "\\" "/" path ${path})
		string(REPLACE "\n" "" path ${path})
		set(${RESULT} ${path} PARENT_SCOPE)
	endif()
endfunction()


###############################################################################
# dk_executeProcess(commands) NOASSERT
#
#	TODO
#
#	@commands	- TODO
#
function(dk_executeProcess commands) #NOASSERT
	DKDEBUGFUNC(${ARGV})
	set(commands ${ARGV})
	
	dk_includes("${ARGN}" "NOASSERT" includes)
	if(${includes})
		set(noassert true)
	endif()
	
	list(REMOVE_ITEM commands NOASSERT)
	list(REMOVE_ITEM commands COMMAND)
	list(REMOVE_ITEM commands "cmd /c ")
	list(FIND commands "WORKING_DIRECTORY" index)
	if(index EQUAL -1)
		set(command ${commands} WORKING_DIRECTORY ${CURRENT_DIR}) # add WORKING_DIRECTORY if missing
	endif()	
	
	dk_info("\n${CLR}${magenta} $ ${commands}\n")
	
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
		if(${noassert})
			dk_error(" ")
			dk_error("   command: ${commands}")
			dk_error("    result: ${result}")
			dk_error("     error: ${error}")
			dk_error(" ")
		else()
			dk_assert("\n     command=${commands}\n       result=${result}\n       error=${error}\n")
		endif()
	endif()
endfunction()
dk_createOsMacros("dk_executeProcess")

###############################################################################
# dk_setEnv(name value)
#
#	Set a system environment variable
#
#	@name	- The name of the system environment variable to set
#	@value	- The value to set the system environment vairable to
#
function(dk_setEnv name value)
	DKDEBUGFUNC(${ARGV})
	dk_debug(ENV{${name}})
	dk_debug(value)
	if(ENV{${name}})
		string(FIND $ENV{${name}} ${value} index)
	else()
		set(index -1)
	endif()
	if(${index} EQUAL -1)
#		if(NOT "$ENV{${name}}" STREQUAL "${value}")
		if(WIN_HOST)
			dk_info("Setting %${name}% environment variable to ${value}")
			set(ENV{${name}} ${value})
			#dk_executeProcess(setx ${name} ${value}) # https://stackoverflow.com/a/69246810		#FIXME
			#execute_process(COMMAND cmd /c setx ${name} ${value}) # https://stackoverflow.com/a/69246810
		else()
			dk_error("dk_setEnv() not implemented on this system")
		endif()
	endif()
endfunction()


###############################################################################
# dk_setPath(path)
#
#	TODO
#
#	@path	- TODO
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
#			#if(${index} GREATER -1)
#			dk_includes("${item}" "-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY=" result)
#			if(${result})
#				list(REMOVE_ITEM DKCMAKE_BUILD ${item})
#			endif()
#	
#			#string(FIND "${item}" "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=" index)
#			#if(${index} GREATER -1)
#			dk_includes("${item}" "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=" result)
#			if(${result})
#				list(REMOVE_ITEM DKCMAKE_BUILD ${item})
#			endif()
#		
#			#string(FIND "${item}" "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=" index)
#			#if(${index} GREATER -1)
#			dk_includes("${item}" "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=" result)
#			if(${result})
#				list(REMOVE_ITEM DKCMAKE_BUILD ${item})
#			endif()
#		endforeach()
#		dk_set(DKCMAKE_BUILD ${DKCMAKE_BUILD} -DCMAKE_ARCHIVE_OUTPUT_DIRECTORY=${CURRENT_DIR} -DCMAKE_LIBRARY_OUTPUT_DIRECTORY=${CURRENT_DIR} -DCMAKE_RUNTIME_OUTPUT_DIRECTORY=${CURRENT_DIR})
#	endif()
endfunction()
dk_createOsMacros("dk_setPath")


###############################################################################
# dk_msys(args)
#
#	TODO
#
#	@args	- TODO
#
function(dk_msys)
	DKDEBUGFUNC(${ARGV})
	if(QUEUE_BUILD)
		string(REPLACE ";" " " str "${ARGV}")
		set(bash "#!/bin/bash")
		list(APPEND bash "cd ${CURRENT_DIR}")
		if(WIN_32 OR ANDROID_32) # OR EMSCRIPTEN)
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
		dk_info("dk_msys $ ${bash}")
		dk_executeProcess(${MSYS}/bin/bash ${MSYS}/dkscript.tmp)
	endif()
endfunction()
dk_createOsMacros("dk_msys")


###############################################################################
# dk_queueMsys(args)
#
#	TODO
#
#	@args	- TODO
#
function(dk_queueMsys)
	DKDEBUGFUNC(${ARGV})
	if(QUEUE_BUILD)
		dk_msys(${ARGV})
	endif()	
endfunction()
dk_createOsMacros("dk_queueMsys")


###############################################################################
# dk_msys2(args)
#
#	TODO
#
#	@args	- TODO
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
		dk_info("dk_msys2 $ ${bash}")
		dk_executeProcess(${MSYS2}/usr/bin/bash ${MSYS2}/dkscript.tmp)
	endif()
endfunction()
dk_createOsMacros("dk_msys2")


###############################################################################
# dk_mergeFlags(args RESULT)
#
#	TODO
#
#	@args		- TODO
#	@RESULT		- TODO
#
function(dk_mergeFlags args RESULT)
	DKDEBUGFUNC(${ARGV})
	set(args ${args} ${RESULT} ${ARGN})
	list(GET args -1 RESULT)
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
			#dk_includes(${arg} ${word} hasWord)
			#if(${hasWord})
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
	set(${RESULT} ${args} PARENT_SCOPE)
endfunction()


###############################################################################
# dk_command(args)
#
#	TODO
#
#	@args	- TODO
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
dk_createOsMacros("dk_command")



###############################################################################
# dk_queueCommand(args)
#
#	TODO
#
#	@args	- TODO
#
function(dk_queueCommand)
	DKDEBUGFUNC(${ARGV})
	if(QUEUE_BUILD)
		dk_command(${ARGV})
	endif()	
endfunction()
dk_createOsMacros("dk_queueCommand")


###############################################################################
# dk_visualStudioDebug(path) #target #arch
#
#	TODO
#
#	@path		- TODO
#
function(dk_visualStudioDebug path) #target #arch
	DKDEBUGFUNC(${ARGV})
	if(NOT WIN_HOST)
		return()
	endif()
	
	if(NOT EXISTS ${path})
		dk_assert("dk_visualStudioDebug(${path}) path does not exist")
	endif()
	
	#dk_findFiles(${3RDPARTY}/${folder}/${OS} *.sln sln_file)
	dk_findFiles(${path}/${OS} *.sln sln_file)
	dk_getFilename(${sln_file} sln_file)
	dk_getExtension(${sln_file} extension)
	if(NOT ${extension} STREQUAL ".sln")
		dk_assert("extension does not equal .sln")
	endif()
	
	if(DEBUG AND QUEUE_BUILD)
		#if(NOT EXISTS ${3RDPARTY}/${folder}/${OS}/${sln_file})
		if(NOT EXISTS ${path}/${OS}/${sln_file})
			#dk_assert("CANNOT FIND: ${3RDPARTY}/${folder}/${OS}/${sln_file}" )
			dk_assert("CANNOT FIND: ${path}/${OS}/${sln_file}" )
		endif()
		if(${ARGC} GREATER 2)
			#set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /t:${ARGV1} /p:Configuration=Debug /p:Platform=${ARGV2})
			set(EXECUTE_COMMAND ${MSBUILD} ${path}/${OS}/${sln_file} /t:${ARGV1} /p:Configuration=Debug /p:Platform=${ARGV2})
		elseif(${ARGC} GREATER 1)
			#set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /t:${ARGV1} /p:Configuration=Debug)
			set(EXECUTE_COMMAND ${MSBUILD} ${path}/${OS}/${sln_file} /t:${ARGV1} /p:Configuration=Debug)
		else()
			#set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /p:Configuration=Debug)
			set(EXECUTE_COMMAND ${MSBUILD} ${path}/${OS}/${sln_file} /p:Configuration=Debug)
		endif()
		#dk_executeProcess(${EXECUTE_COMMAND} WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		dk_executeProcess(${EXECUTE_COMMAND} WORKING_DIRECTORY ${path}/${OS})
	endif()
endfunction()
dk_createOsMacros("dk_visualStudioDebug" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_visualStudioRelease(path) #target #arch
#
#	TODO
#
#	@path		- TODO
#
function(dk_visualStudioRelease path) #target #arch
	DKDEBUGFUNC(${ARGV})
	if(NOT WIN_HOST)
		return()
	endif()
	
	if(NOT EXISTS ${path})
		dk_assert("dk_visualStudioRelease(${path}) path does not exist")
	endif()
	
	#dk_findFiles(${3RDPARTY}/${folder}/${OS} *.sln sln_file)
	dk_findFiles(${path}/${OS} *.sln sln_file)
	dk_getFilename(${sln_file} sln_file)
	
	dk_getExtension(${sln_file} extension)
	if(NOT ${extension} STREQUAL ".sln")
		dk_assert("extension does not equal .sln")
	endif()
	
	if(RELEASE AND QUEUE_BUILD)
		#if(NOT EXISTS ${3RDPARTY}/${folder}/${OS}/${sln_file})
		if(NOT EXISTS ${path}/${OS}/${sln_file})
			#dk_assert("CANNOT FIND: ${3RDPARTY}/${folder}/${OS}/${sln_file}" )
			dk_assert("CANNOT FIND: ${path}/${OS}/${sln_file}")
		endif()
		if(${ARGC} GREATER 2)
			#set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /t:${ARGV1} /p:Configuration=Release /p:Platform=${ARGV2})
			set(EXECUTE_COMMAND ${MSBUILD} ${path}/${OS}/${sln_file} /t:${ARGV1} /p:Configuration=Release /p:Platform=${ARGV2})
		elseif(${ARGC} GREATER 1)
			#set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /t:${ARGV1} /p:Configuration=Release)
			set(EXECUTE_COMMAND ${MSBUILD} ${path}/${OS}/${sln_file} /t:${ARGV1} /p:Configuration=Release)
		else()
			#set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /p:Configuration=Release)
			set(EXECUTE_COMMAND ${MSBUILD} ${path}/${OS}/${sln_file} /p:Configuration=Release)
		endif()
		#dk_executeProcess(${EXECUTE_COMMAND} WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		dk_executeProcess(${EXECUTE_COMMAND} WORKING_DIRECTORY ${path}/${OS})
	endif()
endfunction()
dk_createOsMacros("dk_visualStudioRelease" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_visualStudio(path sln_file)
#
#	TODO
#
#	@args	- TODO
#
function(dk_visualStudio)
	DKDEBUGFUNC(${ARGV})
	dk_visualStudioDebug(${ARGV})
	dk_visualStudioRelease(${ARGV})
endfunction()
dk_createOsMacros("dk_visualStudio" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_xcodeDebug(path) #target
#
#	TODO
#
#	@path				- TODO
#	@target:(optional)	- TODO
#
function(dk_xcodeDebug path)
	DKDEBUGFUNC(${ARGV})
	if(NOT MAC_HOST)
		return()
	endif()
	
	if(NOT EXISTS ${path})
		dk_assert("dk_xcodeDebug(${path}) path does not exist")
	endif()
	
	if(DEBUG AND QUEUE_BUILD)
		if(${ARGC} GREATER 1)
			#dk_executeProcess(xcodebuild -target ${ARGV1} -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
			dk_executeProcess(xcodebuild -target ${ARGV1} -configuration Debug build WORKING_DIRECTORY ${path}/${OS})
		else()
			#dk_executeProcess(xcodebuild -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
			dk_executeProcess(xcodebuild -configuration Debug build WORKING_DIRECTORY ${path}/${OS})
		endif()
	endif()
endfunction()
dk_createOsMacros("dk_xcodeDebug" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_xcodeRelease(path) #target
#
#	TODO
#
#	@path				- TODO
#	@target:(optional)	- TODO
#
function(dk_xcodeRelease path)
	DKDEBUGFUNC(${ARGV})
	if(NOT MAC_HOST)
		return()
	endif()
	
	if(NOT EXISTS ${path})
		dk_assert("dk_xcodeDebug(${path}) path does not exist")
	endif()
	
	if(RELEASE AND QUEUE_BUILD)
		if(${ARGC} GREATER 1)
			#dk_executeProcess(xcodebuild -target ${ARGV1} -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
			dk_executeProcess(xcodebuild -target ${ARGV1} -configuration Release build WORKING_DIRECTORY ${path}/${OS})
		else()
			#dk_executeProcess(xcodebuild -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
			dk_executeProcess(xcodebuild -configuration Release build WORKING_DIRECTORY ${path}/${OS})
		endif()
	endif()
endfunction()
dk_createOsMacros("dk_xcodeRelease" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_xcode(args) #target
#
#	TODO
#
#	@args				- TODO
#	@target:(optional)	- TODO
#
function(dk_xcode)
	DKDEBUGFUNC(${ARGV})
	dk_xcodeDebug(${ARGV})
	dk_xcodeRelease(${ARGV})
endfunction()
dk_createOsMacros("dk_xcode" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_ndkDebug(path)
#
#	TODO
#
#	@path		- TODO
#
function(dk_ndkDebug path)
	DKDEBUGFUNC(${ARGV})
	
	if(NOT EXISTS ${path})
		dk_assert("dk_ndkDebug(${path}) path does not exist")
	endif()
	
	if(DEBUG AND QUEUE_BUILD)
		if(WIN_HOST)
			#dk_executeProcess(${ANDROID-NDK}/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS}/Debug)
			dk_executeProcess(${ANDROID-NDK}/ndk-build.cmd WORKING_DIRECTORY ${path}/${OS}/Debug)
		endif()
		if(UNIX_HOST)
			#dk_executeProcess(${ANDROID-NDK}/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS}/Debug)
			dk_executeProcess(${ANDROID-NDK}/ndk-build WORKING_DIRECTORY ${path}/${OS}/Debug)
		endif()
	endif()
endfunction()
dk_createOsMacros("dk_ndkDebug" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_ndkRelease(path)
#
#	TODO
#
#	@path		- TODO
#
function(dk_ndkRelease path)
	DKDEBUGFUNC(${ARGV})
	
	if(NOT EXISTS ${path})
		dk_assert("dk_ndkRelease(${path}) path does not exist")
	endif()
	
	if(RELEASE AND QUEUE_BUILD)
		if(WIN_HOST)
			#dk_executeProcess(${ANDROID-NDK}/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS}/Release)
			dk_executeProcess(${ANDROID-NDK}/ndk-build.cmd WORKING_DIRECTORY ${path}/${OS}/Release)
		endif()
		if(UNIX_HOST)
			#dk_executeProcess(${ANDROID-NDK}/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS}/Release)
			dk_executeProcess(${ANDROID-NDK}/ndk-build WORKING_DIRECTORY ${path}/${OS}/Release)
		endif()
	endif()
endfunction()
dk_createOsMacros("dk_ndkRelease" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_ndk(path)
#
#	TODO
#
#	@path		- TODO
#
function(dk_ndk)
	DKDEBUGFUNC(${ARGV})
	dk_ndkDebug(${ARGV})
	dk_ndkRelease(${ARGV})
endfunction()
dk_createOsMacros("dk_ndk" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_make(path lib)
#
#	TODO
#
#	@path 				- TODO
#	@lib (optional)		- TODO
#
function(dk_make path) #lib
	DKDEBUGFUNC(${ARGV})
	
	if(NOT EXISTS ${path})
		dk_assert("dk_make(${path}) path does not exist")
	endif()
	
	if(EMSCRIPTEN)
		dk_set(EMMAKE ${3RDPARTY}/emsdk-main/upstream/emscripten/emmake)
		set(lib ${ARGV1})
		#dk_set(CURRENT_DIR ${3RDPARTY}/${folder}/${BUILD_DIR})
		dk_set(CURRENT_DIR ${path}/${BUILD_DIR})
		#if(${ARGC} GREATER 1)
		#	dk_queueCommand(${EMMAKE} make ${lib})
		#else()
		#	dk_queueCommand(${EMMAKE} make)
		#endif()
		DEBUG_dk_queueCommand(${CMAKE_COMMAND} --build . --config Debug)
		RELEASE_dk_queueCommand(${CMAKE_COMMAND} --build . --config Release)
	else()
		set(lib ${ARGV1})
		#dk_set(CURRENT_DIR ${3RDPARTY}/${folder}/${BUILD_DIR})
		dk_set(CURRENT_DIR ${path}/${BUILD_DIR})
		if(${ARGC} GREATER 1)
			dk_queueCommand(make ${lib})
		else()
			dk_queueCommand(make)
		endif()
	endif()
endfunction()


###############################################################################
# dk_build(path target)
#
#	TODO
#
#	@path 				- TODO
#	@target (optional)	- TODO
#
function(dk_build path)
	DKDEBUGFUNC(${ARGV})
	
	if(NOT EXISTS ${path})
		dk_assert("dk_build(${path}) path does not exist")
	endif()
	
	set(target ${ARGV1})
	dk_setPath(${path}/${BUILD_DIR})
	
	# Build with CMake
	if(EXISTS ${path}/${BUILD_DIR}/cmake_install.cmake)
		dk_info("Building with CMake")
		if(${ARGC} GREATER 1)
			DEBUG_dk_queueCommand(${CMAKE_COMMAND} --build . --config Debug --target ${target})
			RELEASE_dk_queueCommand(${CMAKE_COMMAND} --build . --config Release --target ${target})
		else()
			DEBUG_dk_queueCommand(${CMAKE_COMMAND} --build . --config Debug)
			RELEASE_dk_queueCommand(${CMAKE_COMMAND} --build . --config Release)
		endif()
		return()
	endif()
	
	# Build with MSBuild
	file(GLOB sln "${path}/${BUILD_DIR}/*.sln")
	if(sln)
		dk_info("Building with MSBuild")
		dk_visualStudio(${ARGV})
		return()
	endif()
	
	# Build with XCode
	file(GLOB xcodeproj "${path}/${BUILD_DIR}/*.xcodeproj")
	if(xcodeproj)
		dk_info("Building with XCode")
		dk_xcode(${ARGV})
		return()
	endif()
	
	# Build with make
	if(EXISTS ${path}/${BUILD_DIR}/Makefile)
		dk_info("Building with make")
		dk_make(${ARGV})
		return()
	endif()
	
	# Build with Android NDK
	if(EXISTS ${path}/${BUILD_DIR}/AndroidManifest.xml)
		dk_info("Building with Android NDK")
		dk_ndk(${ARGV})
		return()
	endif()
	
	dk_assert("dk_build(): ${path}/${BUILD_DIR} has no buildable files")
endfunction()
dk_createOsMacros("dk_build")


###############################################################################
# dk_lib(lib_path)
#
#	TODO
#
#	@lib_path	- TODO
#
function(dk_lib lib_path)
	DKDEBUGFUNC(${ARGV})
	foreach(item ${ARGV})
#		dk_set(LIBLIST "${LIBLIST} ${lib_path}") ## used for double checking
		dk_includes("${LIBS}" "${item}" result)
		if(${result})
			continue() # item is already in the list
		endif()
		dk_set(LIBS "${LIBS};${item}")

		if(INSTALL_DKLIBS)
			if(EXISTS ${lib_path})
				dk_getFilename(${CMAKE_CURRENT_LIST_DIR} LIB_NAME)
				file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/${LIB_NAME}/lib/${OS})
			else()
				dk_error("Could not locate ${lib_path}")
			endif()
		endif()
		
	endforeach()
endfunction()
dk_createOsMacros("dk_lib" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_libDebug(lib_path)
#
#	TODO
#
#	@lib_path	- TODO
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
	
	string(FIND "${DEBUG_LIBS}" "${lib_path}" index)
	if(${index} GREATER -1)
	#dk_includes("${DEBUG_LIBS}" "${lib_path}" result)
	#if(${result})
		return() # The library is already in the list
	endif()
	
	if(LINUX OR RASPBERRY OR ANDROID OR EMSCRIPTEN)
		dk_set(DEBUG_LIBS debug ${lib_path} ${DEBUG_LIBS})  # Add to beginning of list
	else()
		dk_set(DEBUG_LIBS ${DEBUG_LIBS} debug ${lib_path})  # Add to end of list
	endif()

	if(INSTALL_DKLIBS)
		dk_getFilename(${CMAKE_CURRENT_LIST_DIR} LIB_NAME)
		file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/${LIB_NAME}/lib/${OS}/Debug)
	endif()
	
endfunction()
dk_createOsMacros("dk_libDebug" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_libRelease(lib_path)
#
#	TODO
#
#	@lib_path		- TODO
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
	
	string(FIND "${RELEASE_LIBS}" "${lib_path}" index)
	if(${index} GREATER -1)
	#dk_includes("${RELEASE_LIBS}" "${lib_path}" result)
	#if(${result})
		return() # The library is already in the list
	endif()	
	
	if(LINUX OR RASPBERRY OR ANDROID OR EMSCRIPTEN)
		dk_set(RELEASE_LIBS optimized ${lib_path} ${RELEASE_LIBS})  # Add to beginning of list
	else()
		dk_set(RELEASE_LIBS ${RELEASE_LIBS} optimized ${lib_path})  # Add to end of list
	endif()
	
	if(INSTALL_DKLIBS)
		dk_getFilename(${CMAKE_CURRENT_LIST_DIR} LIB_NAME)
		file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/${LIB_NAME}/lib/${OS}/Release)
	endif()
	
endfunction()
dk_createOsMacros("dk_libRelease" "NO_DEBUG_RELEASE_TAGS")


###############################################################################
# dk_generateCmake(plugin_name)
#
#	TODO
#
#	@plugin_name	- TODO
#
function(dk_generateCmake plugin_name)
	DKDEBUGFUNC(${ARGV})
	dk_getPathToPlugin(${plugin_name} plugin_path)
	if(NOT EXISTS "${plugin_path}")
		dk_assert("dk_generateCmake(${plugin_name}): plugin not found")
	endif()
	# Create CmakeLists.txt file
	dk_remove(${plugin_path}/CMakeLists.txt NOERROR)
	file(APPEND ${plugin_path}/CMakeLists.txt "### This file is generated by DKCMake. Any Changes here, will be overwritten. ###\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "### ${plugin_name} ###\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "cmake_minimum_required(VERSION 3.10)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "cmake_policy(SET CMP0054 NEW)\n")
#	file(APPEND ${plugin_path}/CMakeLists.txt "cmake_policy(SET CMP0002 OLD)\n")
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
	file(APPEND ${plugin_path}/CMakeLists.txt "if(VISUAL_STUDIO_IDE)\n")
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
			dk_includes("${PLUGINS_FILE}" "${header}" result)
			if(NOT ${result})
				dk_info("Adding ${header} to header file.")
				dk_set(PLUGINS_FILE ${PLUGINS_FILE} "#include \"${header}\"\\n")
			endif()
#			dk_includes("${PLUGINS_FILE}" "DKHAVE_${plugin_name}" result)
#			if(NOT ${result})
#				dk_info("Adding #define DKHAVE_${plugin_name} 1 to header file.")
#				dk_set(PLUGINS_FILE ${PLUGINS_FILE} "#define DKHAVE_${plugin_name} 1\\n")
#			endif()
		endforeach()
	endif()
	dk_enable				(${plugin_name})
	WIN_dk_libDebug			(${plugin_path}/${OS}/${DEBUG_DIR}/${plugin_name}.lib)
	WIN_dk_libRelease		(${plugin_path}/${OS}/${RELEASE_DIR}/${plugin_name}.lib)
	MAC_dk_libDebug			(${plugin_path}/${OS}/${DEBUG_DIR}/lib${plugin_name}.a)
	MAC_dk_libRelease		(${plugin_path}/${OS}/${RELEASE_DIR}/lib${plugin_name}.a)
	IOS_dk_libDebug			(${plugin_path}/${OS}/Debug-iphoneos/lib${plugin_name}.a)
	IOS_dk_libRelease		(${plugin_path}/${OS}/Release-iphoneos/lib${plugin_name}.a)
	IOSSIM_dk_libDebug		(${plugin_path}/${OS}/Debug-iphonesimulator/lib${plugin_name}.a)
	IOSSIM_dk_libRelease	(${plugin_path}/${OS}/Release-iphonesimulator/lib${plugin_name}.a)
	LINUX_dk_libDebug		(${plugin_path}/${OS}/${DEBUG_DIR}/lib${plugin_name}.a)
	LINUX_dk_libRelease		(${plugin_path}/${OS}/${RELEASE_DIR}/lib${plugin_name}.a)
	RASPBERRY_dk_libDebug	(${plugin_path}/${OS}/${DEBUG_DIR}/lib${plugin_name}.a)
	RASPBERRY_dk_libRelease	(${plugin_path}/${OS}/${RELEASE_DIR}/lib${plugin_name}.a)
	ANDROID_dk_libDebug		(${plugin_path}/${OS}/${DEBUG_DIR}/lib${plugin_name}.a)
	ANDROID_dk_libRelease	(${plugin_path}/${OS}/${RELEASE_DIR}/lib${plugin_name}.a)
	EMSCRIPTEN_dk_libDebug		(${plugin_path}/${OS}/${DEBUG_DIR}/lib${plugin_name}.a)
	EMSCRIPTEN_dk_libRelease		(${plugin_path}/${OS}/${RELEASE_DIR}/lib${plugin_name}.a)
	if(REBUILD OR REBUILDALL)
		dk_set(QUEUE_BUILD ON)
	endif()
	dk_set(DKPLUGIN_LIST ${DKPLUGIN_LIST} ${plugin_name})  #Add to list
endfunction()


###############################################################################
# dk_dll(plugin_name)
#
#	TODO
#
#	@plugin_name	- TODO
#
function(dk_dll plugin_name)
	DKDEBUGFUNC(${ARGV})
	dk_getPathToPlugin(${plugin_name} plugin_path)
	if(NOT EXISTS "${plugin_path}")
		dk_assert("${plugin_name} plugin not found")
	endif()
	dk_include(${plugin_path})
	# Create CmakeLists.txt file
	dk_remove(${plugin_path}/CMakeLists.txt NOERROR)
	if(NOT EXISTS "${plugin_path}/CMakeLists.txt")
	file(APPEND ${plugin_path}/CMakeLists.txt "### ${plugin_name} ###\n")
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
	file(APPEND ${plugin_path}/CMakeLists.txt "project(${plugin_name})\n")
	foreach(each_include ${DKINCLUDES_LIST})
		file(APPEND ${plugin_path}/CMakeLists.txt "include_directories(${each_include})\n")
	endforeach()
	foreach(each_define ${DKDEFINES_LIST})
		file(APPEND ${plugin_path}/CMakeLists.txt "add_definitions(-D${each_define})\n")
	endforeach()
	foreach(each_linkdir ${DKLINKDIRS_LIST})
		file(APPEND ${plugin_path}/CMakeLists.txt "link_directories(${each_linkdir})\n")
	endforeach()
	file(APPEND ${plugin_path}/CMakeLists.txt "file(GLOB ${plugin_name}_SRC \n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		${plugin_path}/*.h\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "    	${plugin_path}/*.c\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "    	${plugin_path}/*.cpp\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "    	${plugin_path}/*.rc\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "    	${plugin_path}/*.manifest\n")
	if(IOS OR IOSSIM)
		file(APPEND ${plugin_path}/CMakeLists.txt "		${plugin_path}/*.mm\n")
	endif()
	file(APPEND ${plugin_path}/CMakeLists.txt ")\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "add_library(${plugin_name} SHARED \${${plugin_name}_SRC})\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "add_definitions(-D_WIN32_WINNT=0x0600)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "set_target_properties(${plugin_name} PROPERTIES LINK_FLAGS_DEBUG \"/NODEFAULTLIB:libc.lib /NODEFAULTLIB:LIBCMTD.lib /SAFESEH:NO\" LINK_FLAGS \"/NODEFAULTLIB:libc.lib /NODEFAULTLIB:LIBCMT.lib /SAFESEH:NO\") \n")
	file(APPEND ${plugin_path}/CMakeLists.txt "target_compile_options(${plugin_name} PRIVATE $<$<CONFIG:Debug>:/MDd /Od /Ob0 /EHsc /Zi /RTC1 /DDEBUG /D_DEBUG> $<$<CONFIG:Release>:/MD /O2 /Ob2 /EHsc /DNDEBUG>)\n")
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
#		file(APPEND ${plugin_path}/CMakeLists.txt "target_link_libraries(${plugin_name} debug ${DKPLUGINS}/DK/${OS}/${DEBUG_DIR}/DK.lib optimized ${DKPLUGINS}/DK/${OS}/${RELEASE_DIR}/DK.lib) \n")
		file(APPEND ${plugin_path}/CMakeLists.txt "target_link_libraries(${plugin_name} ${DLL_DEBUG_LIBS} ${DLL_RELEASE_LIBS} ${DLL_LIBS}) \n")
	endif()
	file(APPEND ${plugin_path}/CMakeLists.txt "if(WIN_HOST)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		set_target_properties(${plugin_name} PROPERTIES LINKER_LANGUAGE CPP)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "endif()\n")
	endif()
	dk_addToPluginList(${plugin_name})
endfunction()


###############################################################################
# dk_executable(plugin_name)
#
#	TODO
#
#	@plugin_name	- TODO
#
function(dk_executable plugin_name)
	DKDEBUGFUNC(${ARGV})
	dk_getPathToPlugin(${plugin_name} plugin_path)
	if(NOT EXISTS "${plugin_path}")
		dk_assert("${plugin_name} plugin not found")
	endif()
	dk_include(${plugin_path})
	dk_remove(${plugin_path}/CMakeLists.txt)
	if(NOT EXISTS "${plugin_path}/CMakeLists.txt")
#	file(APPEND ${plugin_path}/CMakeLists.txt "### ${plugin_name} ###\n")
#	file(APPEND ${plugin_path}/CMakeLists.txt "cmake_minimum_required(VERSION 3.10)\n")
#	file(APPEND ${plugin_path}/CMakeLists.txt "cmake_policy(SET CMP0054 NEW)\n")
#	file(APPEND ${plugin_path}/CMakeLists.txt "include(${DKCMAKE}/DKFunctions.cmake)\n")
#	file(APPEND ${plugin_path}/CMakeLists.txt "include(${DKCMAKE}/DKVariables.cmake)\n")
#	file(APPEND ${plugin_path}/CMakeLists.txt "project(${plugin_name})\n")
	endif()
	dk_addToPluginList(${plugin_name})
endfunction()


###############################################################################
# dk_testApp(plugin_name)
#
#	TODO
#
#	@plugin_name	- TODO
#
function(dk_testApp plugin_name)
	DKDEBUGFUNC(${ARGV})
	dk_getPathToPlugin(${plugin_name} plugin_path)
	if(NOT EXISTS "${plugin_path}/test")
		dk_info("dk_testApp(): ${plugin_name}_test app not found")
		return()
	endif()
	dk_info("building ${plugin_name}_test app")
	dk_set(test_path "${plugin_path}/test")
	
	# Create CmakeLists.txt file
	dk_remove("${test_path}/CMakeLists.txt")
	file(APPEND ${test_path}/CMakeLists.txt "### This file is generated by DKCMake. Any Changes here, will be overwritten. ###\n")
	file(APPEND ${test_path}/CMakeLists.txt "### ${plugin_name} ###\n")
	file(APPEND ${test_path}/CMakeLists.txt "cmake_minimum_required(VERSION 3.10)\n")
	file(APPEND ${test_path}/CMakeLists.txt "cmake_policy(SET CMP0054 NEW)\n")
	file(APPEND ${test_path}/CMakeLists.txt "include(${DKCMAKE}/DKFunctions.cmake)\n")
	file(APPEND ${test_path}/CMakeLists.txt "include(${DKCMAKE}/DKVariables.cmake)\n")
	dk_appendCmake("project(${plugin_name}_test)\n")
	dk_appendCmake("include_directories(${DKPLUGINS})\n")
		
	# TODO		
	dk_addToPluginList(${plugin_name})
endfunction()


###############################################################################
# dk_addToPluginList(plugin_name)
#
#	TODO
#
#	@plugin_name	- TODO
#
function(dk_addToPluginList plugin_name)
	DKDEBUGFUNC(${ARGV})
	dk_getPathToPlugin(${plugin_name} plugin_path)
	if(NOT EXISTS "${plugin_path}")
		dk_assert("${plugin_name} plugin not found")
	endif()
	dk_include(${plugin_path})
	dk_set(DKPLUGIN_LIST ${DKPLUGIN_LIST} ${plugin_name})
endfunction()


###############################################################################
# dk_appendCmake(str)
#
#	TODO
#
#	@str	- TODO
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
	PATTERN emscripten EXCLUDE
	PATTERN dktest EXCLUDE)


###############################################################################
# dk_assets(plugin)
#
#	Add a library's files to the App's assets
#
#	@plugin		- TODO
#
function(dk_assets plugin)
	DKDEBUGFUNC(${ARGV})
	if(NOT DKAPP)
		return()
	endif()	
	dk_getPathToPlugin(${plugin} plugin_path)
	if(NOT plugin_path)
		dk_assert("${plugin} plugin not found")
	endif()
	dk_info("Importing ${plugin} assets...")
	file(COPY ${plugin_path} DESTINATION ${DKPROJECT}/assets ${ASSETS})
#	file(COPY ${plugin_path}/${OS}/${DEBUG_DIR}/*.exe DESTINATION ${DKPROJECT}/assets/${OS}/Debug)
endfunction()


###############################################################################
# dk_getPathToPlugin(plugin RESULT)
#
#	@plugin		- TODO
#	@RESULT		- TODO
#
function(dk_getPathToPlugin plugin RESULT)
	DKDEBUGFUNC(${ARGV})
	list(FIND dk_disabled_list "${ARGV}" index)
	if(${index} GREATER -1)
		dk_info("${ARGV} IS DISABLED")
		return()
	endif()
	file(GLOB children RELATIVE ${DIGITALKNOB} ${DIGITALKNOB}/*)
 	foreach(child ${children})
		if(EXISTS ${DIGITALKNOB}/${child}/3rdParty/_DKIMPORTS/${plugin}/DKMAKE.cmake)
			set(${RESULT} "${DIGITALKNOB}/${child}/3rdParty/_DKIMPORTS/${plugin}" PARENT_SCOPE)
			return()
    	endif()
		if(EXISTS ${DIGITALKNOB}/${child}/DKPlugins/${plugin}/DKMAKE.cmake)
			set(${RESULT} "${DIGITALKNOB}/${child}/DKPlugins/${plugin}" PARENT_SCOPE)
			return()
    	endif()
  	endforeach()
	set(${RESULT} "")
	dk_assert("Could not find ${plugin} Plugin.")
endfunction()


###############################################################################
# dk_depend(plugin)
#
#	Add a library or plugin to the dependency list
#
#	@plugin		- TODO
#
function(dk_depend plugin)
	DKDEBUGFUNC(${ARGV})
#	dk_debug(CMAKE_CURRENT_LIST_DIR)
	
#	if(${ARGC} GREATER 1)
#		dk_info(ARGV)
#		dk_dump(ARGV) # FIXME: DUMP not working here, show 2 for the ARGC count, but only shows variable plugin ARGV, no value
#	endif()

	list(FIND dk_disabled_list ${plugin} index)
	if(${index} GREATER -1)
		dk_warn("${plugin} IS DISABLED")
		return()
	endif()
	
# 	TODO TODO TODO TODO 
# 	dk_createSmartObject(${plugin}) #TODO:  automatically determin plugin, create variables, setup auto compiles, etc 
# 	TODO TODO TODO TODO 
	
#	If dk_depend had second variable (a sub library), set that variable to ON
#	if(${ARGC} GREATER 1)
#	list(FIND dkdepend_list "${plugin} ${args}" index)
#	if(${index} GREATER -1) #library is already in the list
#		return()
#	endif()
#	else()
#		list(FIND dkdepend_list "${plugin}" index)
#		if(${index} GREATER -1)
#			return() #library is already in the list
#		endif()
#	endif()
		
	list(FIND dkdepend_list ${plugin} index)
	if(${index} GREATER -1)
		return()  #library is already in the list
	endif()
	
	dk_enable(${plugin})
	dk_runDepends(${plugin}) # strip everything from the file except if() else() elseif() endif() and dk_depend() before sorting.
#	else()
#		list(FIND dkdepend_list "${plugin}" index)
#		if(${index} GREATER -1)
#			return() #library is already in the list
#		endif()
#		dk_runDepends(${plugin}) # strip everything from the file except if() else() elseif() endif() and dk_depend() before sorting.
#	endif()
endfunction()
dk_createOsMacros("dk_depend")


###############################################################################
# dk_undepend(plugin)
#
#	Remove a library or plugin from the dependency list
#
#	@plugin				- TODO
#	@target (optional)	- TODO
#
function(dk_undepend plugin)
	DKDEBUGFUNC(${ARGV})
	set(target ${ARGV1})
	
	# Only allow dk_undepend command from these filters	
	if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKCMAKE})
		if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKPROJECT})
			if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKIMPORTS}/${plugin})
				if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKPLUGINS}/${plugin})
					dk_assert("dk_undepend() Can only be used from a plugin directory. This is to avoid having disabled libraries hideing everywhere")
				endif()
			endif()
		endif()
	endif()
	
	dk_info("DISABLING ${ARGV}")
	dk_set(dk_disabled_list ${dk_disabled_list} "${ARGV}")
	if(${ARGC} GREATER 1)
		dk_removeTarget(${plugin} ${ARGV1})
	endif()	   
endfunction()


###############################################################################
# dk_runDepends(plugin)
#
#	Strip everything from the library's DKMAKE.cmake file except dk_depend() commands AND conditionals.
#	Conditionals such as if(), else(), elseif(), endif(), return() will remain included during the sorting process. 
#	WARNING: BE CAREFULL WRITING NEW VARIABLES TO USE WITH CONDITIONALS, AS THEY MIGHT BE IGNORED 
#
#	@plugin		- TODO
#
function(dk_runDepends plugin)
	DKDEBUGFUNC(${ARGV})
	dk_getPathToPlugin(${plugin} plugin_path)
	if(NOT plugin_path)
		dk_assert("${plugin} plugin not found")
	endif()
	dk_verbose("FOUND ${plugin} DK makefile at ${plugin_path}")
	
	file(STRINGS ${plugin_path}/DKMAKE.cmake lines)
	unset(disable_script)
	unset(depends_script)
	unset(index)
	
	set(keepCommands "if;IF;else;ELSE;find_library;FIND_LIBRARY;return;RETURN;dk_disable;dk_set;dk_makeDirectory;dk_findLibrary;dk_require")
	set(KEEPLINE 0)
	foreach(line ${lines})
		
		foreach(keepCommand ${keepCommands})
			dk_includes("${line}" "${keepCommand}(" hasCommand) # trailing (
			if(${hasCommand})
				set(KEEPLINE 1)
			endif()
			dk_includes("${line}" "${keepCommand} " hasCommand) # trailing space
			if(${hasCommand})
				set(KEEPLINE 1)
			endif()
			dk_includes("${line}" "${keepCommand}	" hasCommand) # trailing tab
			if(${hasCommand})
				set(KEEPLINE 1)
			endif()
		endforeach()
		
		if(KEEPLINE)
			set(disable_script "${disable_script}${line}\n")
		endif()
		
		# FIXME: we need to get a proper count of openeing (  before we can determine that we have actually reached the closing )
		dk_includes("${line}" ")" includes)
		if(${includes})
			set(KEEPLINE 0)
		endif()
	endforeach()
	
	set(keepCommands "if;IF;else;ELSE;find_library;FIND_LIBRARY;return;RETURN;dk_enable;dk_disable;dk_depend;dk_set;message;dk_error;dk_warn;dk_info;dk_debug;dk_verbose;dk_trace;dk_makeDirectory;dk_findLibrary;dk_require") #dk_assert
	set(KEEPLINE 0)
	foreach(line ${lines})
	
		foreach(keepCommand ${keepCommands})
			dk_includes("${line}" "${keepCommand}(" hasCommand) # trailing (
			if(${hasCommand})
				set(KEEPLINE 1)
			endif()
			dk_includes("${line}" "${keepCommand} " hasCommand) # trailing space
			if(${hasCommand})
				set(KEEPLINE 1)
			endif()
			dk_includes("${line}" "${keepCommand}	" hasCommand) # trailing tab
			if(${hasCommand})
				set(KEEPLINE 1)
			endif()
		endforeach()
		
		if(KEEPLINE)
			set(depends_script "${depends_script}${line}\n")
		endif()
		
		# FIXME: we need to get a proper count of openeing (  before we can determine that we have actually reached the closing )
		dk_includes("${line}" ")" includes)
		if(${includes})
			set(KEEPLINE 0)
		endif()
	endforeach()
	
	if(disable_script)
		file(WRITE ${plugin_path}/DISABLES.TMP "${disable_script}")
		INCLUDE(${plugin_path}/DISABLES.TMP)
		dk_remove(${plugin_path}/DISABLES.TMP)
	endif()
	
	if(depends_script)
		if(${ARGC} GREATER 1)
			dk_enable(${ARGV1})
		else()
			dk_set(${ARGV0}_all 1)
		endif()
		file(WRITE ${plugin_path}/DEPENDS.TMP "${depends_script}")
		INCLUDE(${plugin_path}/DEPENDS.TMP)
		dk_remove(${plugin_path}/DEPENDS.TMP)
		if(${ARGC} GREATER 1)
			dk_set(${ARGV1} OFF)
		endif()
	endif()
	
	if(${ARGC} GREATER 1)
		list(FIND dkdepend_list "${plugin} ${ARGV1}" index)
		if(${index} GREATER -1)
			return()
		endif()
	else()
		list(FIND dkdepend_list "${plugin}" index)
		if(${index} GREATER -1)
			return() # already on the list
		endif()
	endif()
	
	dk_set(dkdepend_list ${dkdepend_list} "${ARGV}")  #Add target to list
#	if(${ARGC} GREATER 1)
#		dk_set(dkdepend_list ${dkdepend_list} "${plugin} ${ARGV1}")  #Add target to list
#	else()
#		dk_set(dkdepend_list ${dkdepend_list} ${plugin})  #Add library to list
#	endif()	
	list(REMOVE_DUPLICATES dkdepend_list)
endfunction()


###############################################################################
# dk_require(plugin)
#
#	Require a plugin, return if plugin unavailable
#
#	@plugin				- TODO
#	@target (optional)	- TODO
#
# FIXME
macro(dk_require plugin)
	list(FIND dk_disabled_list ${plugin} index)
	if(${index} GREATER -1)
		get_filename_component(Lib ${CMAKE_CURRENT_LIST_DIR} NAME)
		dk_warn("${Lib} requires ${plugin} which is DISABLED")
		dk_warn("DISABLING ${Lib}")
		dk_disable(${Lib})
		return()
	endif()
	dk_depend(${plugin})
endmacro()


###############################################################################
# dk_dependAll()
#
#	TODO
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
#	TODO
#
#	@filePath	- TODO
#	@find		- TODO
#	@replace	- TODO
#
function(dkFileReplace filePath find replace)
	DKDEBUGFUNC(${ARGV})
	file(READ ${filePath} fileString)
	string(FIND "${fileString}" "${find}" index)
	if(${index} GREATER -1)
#	dk_includes("${fileString}" "${find}" index)
#	if(${index})
		string(REPLACE "${find}" "${replace}" fileString "${fileString}")
		file(WRITE ${filePath} "${fileString}")
	else()
		dk_error("cannot find \"${find}\"  in  (${filePath})")
	endif()
endfunction()


###############################################################################
# dk_updateAndroidName(app_name)
#
#	TODO
#
#	@app_name	- TODO
#
function(dk_updateAndroidName app_name)
	DKDEBUGFUNC(${ARGV})
	string(TOLOWER ${app_name} app_name)
	if(ANDROID)
		# update all files and folders recursivley
		file(GLOB_RECURSE allfiles LIST_DIRECTORIES true RELATIVE "${DKPROJECT}/${OS}/" "${DKPROJECT}/${OS}/*")
		dk_verbose("Getting a list of files in ${DKPROJECT}/${OS}")
		list(REVERSE allfiles)
		foreach(each_file ${allfiles})
			dk_verbose(each_file)
			set(filepath "${DKPROJECT}/${OS}/${each_file}")
			dk_verbose(each_file)
			if(NOT IS_DIRECTORY ${filepath})
				string(FIND "${each_file}" "opendb" indexD)
				if(${indexD} GREATER -1)
				#dk_includes( "${each_file}" "opendb" includes_A)
				#if(${includes_A})
					continue()
				endif()
				string(FIND "${each_file}" ".log" indexD)
				if(${indexD} GREATER -1)
				#dk_includes("${each_file}" ".log" includes_B)
				#if(${includes_B})
					continue()
				endif()
				file(READ ${filepath} filestring)
				string(FIND "${filestring}" "dkapp" index)
				if(${index} GREATER -1)
				#dk_includes("${filestring}" "dkapp" includes_C)
				#if(${includes_C})
					dk_info("Replacing 'dkapp' with '${app_name}' in ${filepath}")
					string(REPLACE "dkapp" "${app_name}" filestring "${filestring}")
					file(WRITE ${filepath} "${filestring}")
				endif()
			endif()
			get_filename_component(fname ${each_file} NAME)
			string(FIND "${fname}" "dkapp" indexB)
			if(${indexB} GREATER -1)
			#dk_includes("${fname}" "dkapp" includes_D)
			#if(${includes_D})
				set(new_name ${each_file})
				string(REPLACE "dkapp" "${app_name}" new_name "${new_name}")
				dk_info("Renaming ${each_file} to ${new_name}")
				dk_rename(${DKPROJECT}/${OS}/${each_file} ${DKPROJECT}/${OS}/${new_name} OVERWRITE)
			endif()
		endforeach()
	endif()
endfunction()


###############################################################################
# dk_updateInfoPlist(app_name)
#
#	TODO
#
#	@app_name	- TODO
#
function(dk_updateInfoPlist app_name)
	DKDEBUGFUNC(${ARGV})
	if(MAC)
		# FIXME
		dk_info("Updating MAC info.plist . . .")
		if(DEBUG)
			if(EXISTS ${DKPROJECT}/${OS}/${DEBUG_DIR}/${app_name}.app/Contents/info.plist)
				file(READ ${DKPROJECT}/${OS}/${DEBUG_DIR}/${app_name}.app/Contents/info.plist plist)
				string(REPLACE "<key>CFBundleIconFile</key>" "" plist ${plist})
				string(REPLACE "<string>logo</string>" "" plist ${plist})
				string(REPLACE "<dict>" "<dict><key>CFBundleIconFile</key><string>logo</string>" plist ${plist})
				file(WRITE "${plist}" ${DKPROJECT}/${OS}/${DEBUG_DIR}/${app_name}.app/Contents/info.plist)
			endif()
		endif()
		if(RELEASE)
			if(EXISTS ${DKPROJECT}/${OS}/${RELEASE_DIR}/${app_name}.app/Contents/info.plist)
				file(READ ${DKPROJECT}/${OS}/${RELEASE_DIR}/${app_name}.app/Contents/info.plist plist)
				string(REPLACE "<key>CFBundleIconFile</key>" "" plist ${plist})
				string(REPLACE "<string>logo</string>" "" plist ${plist})
				string(REPLACE "<dict>" "<dict><key>CFBundleIconFile</key><string>logo</string>" plist ${plist})
				file(WRITE "${plist}" ${DKPROJECT}/${OS}/${RELEASE_DIR}/${app_name}.app/Contents/info.plist)
			endif()	
		endif()
	endif()
	if(IOS OR IOSSIM)
		dk_info("Updating IOS Info.plist . . .")
		dk_info("CHECKING FOR... ${DKPROJECT}/${OS}/${DEBUG_DIR}/${app_name}.app/Info.plist")
		if(EXISTS ${DKPROJECT}/${OS}/${DEBUG_DIR}/${app_name}.app/Info.plist)
			dk_info("Updating IOS Debug Info.plist . . .")
			file(READ ${DKPROJECT}/${OS}/${DEBUG_DIR}/${app_name}.app/Info.plist plist)
			string(REPLACE "<dict>" "<dict>\n<key>Icon files</key>\n<array>\n<string>Icon.png</string>\n<string>Icon@2x.png</string>\n<string>Icon-72.png</string>\n<string>Icon-Small-50.png</string>\n<string>Icon-Small.png</string>\n<string>Icon-Small@2x.png</string>\n</array>\n" plist ${plist})
			file(WRITE "${plist}" ${DKPROJECT}/${OS}/${DEBUG_DIR}/${app_name}.app/Info.plist)
		endif()
	endif()
endfunction()


###############################################################################
# dk_buildLog(entry)
#
#	TODO
#
#	@entry	- TODO
#
function(dk_buildLog entry)
	DKDEBUGFUNC(${ARGV})
	dk_info("	${entry}")
	file(APPEND ${DKPROJECT}/${OS}/DKBUILD.log "${entry}\n")
endfunction()


###############################################################################
# dk_addSource(regex)
#
#	TODO
#
#	@regex	- TODO
#
function(dk_addSource regex)
	DKDEBUGFUNC(${ARGV})
	dk_set(SRC_INCLUDE ${SRC_INCLUDE} ${ARGV})
endfunction()


###############################################################################
# dk_removeSource(regex)
#
#	TODO
#
#	@regex	- TODO
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
#	@VARIABLE	- The name of the CMake variable holding the string.
#	@AT_COLUMN	- The column position at which string will be wrapped.
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
# dk_bin2h(SOURCE_FILE arg1 HEADER_FILE arg2 VARIABLE_NAME arg3)
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
#	TODO
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
	if(EMSCRIPTEN)
		dk_buildLog("EMSCRIPTEN:                    ${EMSCRIPTEN}")
	endif()
	dk_buildLog(" ") 
endfunction()


###############################################################################
# dk_addTarget(plugin target)
#
#	TODO
#
#	@plugin		- TODO
#	@target		- TODO
#
function(dk_addTarget plugin target)
	DKDEBUGFUNC(${ARGV})
	dk_verbose("dk_addTarget( ${ARGV} )")
	if(${plugin}_targets_OFF)
		list(REMOVE_ITEM ${plugin}_targets_OFF ${target})
	endif()
	if(${plugin}_targets)
		dk_set(${plugin}_targets ${${plugin}_targets} ${target})
	else()
		dk_set(${plugin}_targets ${target})
	endif()
	if(${plugin}_all)
		dk_set(${plugin}_${target} 1)
#		dk_set(${plugin}::${target} 1) # TESTME
	endif()
endfunction()


###############################################################################
# dk_removeTarget(plugin target)
#
#	TODO
#
#	@plugin		- TODO
#	@target		- TODO
#
function(dk_removeTarget plugin target)
	DKDEBUGFUNC(${ARGV})
	dk_verbose("dk_removeTarget( ${ARGV} )")
	if(${plugin}_targets)
		list(REMOVE_ITEM ${plugin}_targets ${target})
	endif()
	if(${plugin}_targets_OFF)
		dk_set(${plugin}_targets_OFF ${${plugin}_targets_OFF} ${target})
	else()
		dk_set(${plugin}_targets_OFF ${target})
	endif()
	dk_set(${plugin}_${target} 0)
	dk_unset(${plugin}_${target})
#	dk_unset(${plugin}::${target}) # TESTME
endfunction()


###############################################################################
# dk_createSmartObject(object)
#
#	TODO
#	We can scan each plugin and attempt to create it's variable and infomation manually here
#
#	@object		- TODO
#
function(dk_createSmartObject object)
	DKDEBUGFUNC(${ARGV})
	dk_todo()
	dk_verbose("dk_createSmartObject(${object})")
	# We require something that can resolve to a full, valid path containing a DKMAKE.cmake file 
endfunction()


###############################################################################
# dk_log(args)
#
#	A simple, quick and easy logger
#
#	@args		- TODO
#
function(dk_log args)
	DKDEBUGFUNC(${ARGV})
	dk_verbose("${ARGV}")
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
# dk_removeSubstring(removethis fromthis RESULT)
#
#	TODO
#
#	@removethis		- TODO
#	@fromthis		- TODO
#	@RESULT			- TODO
#
function(dk_removeSubstring removethis fromthis RESULT)
	DKDEBUGFUNC(${ARGV})
	dk_dump(removethis)
	dk_dump(fromthis)
	#foreach(item ${fromthis})
	#	string(REPLACE ${removethis} "" item ${item})
	#	list(APPEND rtn ${item})
	#endforeach()
	string(REPLACE ${removethis} "" rtn "${fromthis}")
	string(REPLACE "  " " " rtn "${rtn}") #replace doube spaces with single space
	set(${RESULT} "${rtn}" PARENT_SCOPE) #return RESULT
	dk_dump(rtn)
	#dk_wait()
endfunction()
dk_createOsMacros("dk_removeSubstring")


###############################################################################
# dk_findTarget(target RESULT_PATH RESULT_TYPE)
#
#	TODO
#
#	@target			- TODO
#	@RESULT_PATH	- TODO
#	@RESULT_TYPE	- TODO
#
function(dk_findTarget target RESULT_PATH RESULT_TYPE)
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
		set(${RESULT_PATH} ${path} PARENT_SCOPE)
		
		file(STRINGS ${path}/DKMAKE.cmake dkmake_string)
		string(FIND "${dkmake_string}" "DKAPP" index)
		if(${index} GREATER -1)
		#dk_includes("${dkmake_string}" "DKAPP" index)
		#if(${index})
			set(${RESULT_TYPE} APP PARENT_SCOPE) 
		else()
			set(${RESULT_TYPE} LIBRARY PARENT_SCOPE)	#LIBRARY is default, we need to label executables to detect them
		endif()
		return()
	endforeach()
endfunction()


###############################################################################
# dk_setReadOnly(VAR)
#
#	TODO
#
#	@VAR	- TODO
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
#	TODO
#
#	@VAR				- TODO
#	@access:			- TODO
# 	@value:				- TODO
#	@current_list_file:	- TODO
#	@stack:				- TODO
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
#	TODO
#
#	@path	- TODO
#	@string	- TODO
# 
function(dk_prependFile path string)
	DKDEBUGFUNC(${ARGV})
	file(READ "${path}" file_data)
	file(write "${pah}" "${string}\n${filedata}")
endfunction()


###############################################################################
# dk_addRegistryKey(key value data)
#
#	TODO
#
#	@key	- TODO
#	@value	- TODO
#	@data	- TODO
#
function(dk_addRegistryKey key value data)
	DKDEBUGFUNC(${ARGV})
	if(WIN_HOST)
		string(REPLACE "/" "\\" key   ${key})
		string(REPLACE "/" "\\" value ${value})
		string(REPLACE "/" "\\" data  ${data})
		execute_process(COMMAND reg add "${key}" /v "${value}" /t REG_SZ /d "${data}" /f /reg:64 OUTPUT_VARIABLE _output ERROR_VARIABLE _output RESULT_VARIABLE _failed)
		dk_verbose(output)
		dk_verbose(_failed)
	endif()
endfunction()


###############################################################################
# dk_import(url) #args
#
#	This is a flexable super function for importing just about anything into digitalknob
#	The idea is to provide a url or path and dk_import will do the rest. 
#
#	@url	- The online path the .git or file to import
#
#	github GIT:	https://github.com/orginization/library.git		dk_importGit(url) #branch/tag #PATCH
#	github DL:	https://github.com/orginization/library			dk_importGit(url) #branch/tag #PATCH
#	lib url DL:	https://website.com/library.zip					dk_importDownload(url) #PATCH
#	exe url DL:	https://website.com/executable.exe 				dk_importDownload(url) #PATCH
#
#	TODO: https://cmake.org/cmake/help/latest/module/FetchContent.html 
#
#function(dk_import url) #Lib #tag #Patch
#	DKDEBUGFUNC(${ARGV})
#	dk_import2(${ARGV})
	#dk_getExtension(${url} extension)
	#if("${extension}" STREQUAL ".git")
	#	dk_importGit2(${ARGV})
	#else()
	#	dk_importDownload2(${ARGV})
	#endif()
#endfunction()
#dk_createOsMacros("dk_import")


###############################################################################
# dk_importGit(url) #tag #PATCH
#
#	TODO
#
#	@url			- The git url to clone
# 	BRANCH @branch	- OPTIONAL: The branch name to checkout
#   ID @id			- OPTIONAL: The commit-id to checkout
#
function(dk_importGit url) #branch #id #PATCH
	DKDEBUGFUNC(${ARGV})
	string(REPLACE "/" ";" url_list ${url})  #split url path into list
	foreach(item ${url_list})
		dk_verbose(item)
	endforeach()
	
	list(LENGTH url_list url_list_size)
	dk_verbose(url_list_size)

	# GITHUB
	if(${url_list_size} LESS 5)
		dk_assert("url_list doesn't contain enough elements to have a 'orginization/library'")
	endif()	
	
	set(branch "master")
	if(${ARGC} GREATER 1)
		if(NOT "${ARGV1}" STREQUAL "PATCH")
			set(branch "${ARGV1}")
		endif()
	endif()
	
	if(NOT Lib)
		string(FIND ${url} "github.com" includes)
		if(${includes} EQUAL -1)
		#dk_includes(${url} "github.com" includes)
		#if(NOT ${includes})
			string(FIND ${url} "gitlab.com" includes)
			if(${includes} EQUAL -1)
			#dk_includes(${url} "gitlab.com" includes)
			#if(NOT ${includes})
				dk_assert("The url does not contain 'github.com' OR 'gitlab.com'")
			endif()
		endif()
	
		list(GET url_list 3 org)
		dk_verbose(org)
	
		list(GET url_list 4 Lib)
		dk_verbose(Lib)
		
		string(FIND ${Lib} ".git" index)
		if(${index} GREATER -1)
		#dk_includes(${Lib} ".git" index)
		#if(${index})
			string(SUBSTRING ${Lib} 0 ${index} Lib)
		endif()
	endif()
	
	string(TOLOWER ${Lib} Lib)
	dk_verbose(Lib)
	
	math(EXPR last "${url_list_size}-1")  #OUTPUT_FORMAT DECIMAL)")  CMake 3.13+
	list(GET url_list ${last} url${last})
	
	string(FIND ${url${last}} ".git" index)
	if(${index} GREATER -1)
	#dk_includes(${url${last}} ".git" index)
	#if(${index})
		if(NOT ID)
			string(SUBSTRING ${url${last}} 0 ${index} ID)
			string(TOLOWER ${ID} FOLDER)
			dk_verbose(FOLDER)
		endif()
	endif()
	
	# check current folder name
	if(NOT "${DKIMPORTS}/${FOLDER}" STREQUAL "${CMAKE_CURRENT_LIST_DIR}")
		dk_assert("\n\nThe Imports folder is named incorrectly. \n CURRENTLY: ${CMAKE_CURRENT_LIST_DIR} \n SHOULD BE: ${DKIMPORTS}/${FOLDER}\n\n")
	endif()
	
	string(TOUPPER ${Lib} LIBVAR)
	if(NOT LIBVAR)
		dk_assert("$(LIBVAR) is invalid")
	endif()
	dk_verbose(LIBVAR)
	
	dk_set(${LIBVAR}_FOLDER ${FOLDER})
	if(NOT ${LIBVAR}_FOLDER)
		dk_assert("${LIBVAR}_FOLDER is invalid")
	endif()
	dk_verbose(${LIBVAR}_FOLDER)
	
	dk_set(${LIBVAR}_BRANCH ${branch})
	if(NOT ${LIBVAR}_BRANCH)
		dk_assert("${LIBVAR}_BRANCH is invalid")
	endif()
	dk_verbose(${LIBVAR}_BRANCH)
	
	dk_set(${LIBVAR}_NAME ${FOLDER}-${${LIBVAR}_BRANCH})
	if(NOT ${LIBVAR}_NAME)
		dk_assert("${LIBVAR}_NAME is invalid")
	endif()
	dk_verbose(${LIBVAR}_NAME)
	
	dk_set(${LIBVAR} ${3RDPARTY}/${${LIBVAR}_NAME})
	if(NOT ${LIBVAR})
		dk_assert("${${LIBVAR}} is invalid")
	endif()
	dk_verbose(${${LIBVAR}})	
	
	if(NOT EXISTS ${${LIBVAR}}/.git)
		dk_set(CURRENT_DIR ${DIGITALKNOB}/${3RDPARTY})
		if(EXISTS ${${LIBVAR}})
			dk_remove(${${LIBVAR}})
		endif()
		if(NOT EXISTS ${${LIBVAR}})
			dk_makeDirectory(${${LIBVAR}})
		endif()
		dk_set(CURRENT_DIR ${${LIBVAR}})
		dk_command(${GIT_EXE} clone ${url} ${${LIBVAR}})
	endif()
	dk_set(CURRENT_DIR ${${LIBVAR}})
	dk_command(${GIT_EXE} checkout -- .)
	dk_command(${GIT_EXE} checkout ${branch} ${id})
	dk_command(${GIT_EXE} pull)
	
	#set(arg_list "${ARGN}")
	#foreach(arg IN LISTS arg_list)
	#	if("${arg}" STREQUAL "PATCH")
	#		dk_patch(${Lib} ${${LIBVAR}})
	#	endif()
	#endforeach()
	
	dk_includes("${ARGN}" "PATCH" includes)
	if(${includes})
		dk_patch(${Lib} ${${LIBVAR}})
	endif()	
endfunction()


###############################################################################
# dk_importDownload(url) install_path PATCH
#
#	TODO
#
#	@url						- TODO
#	@install_path (optional)	- TODO 
#
function(dk_importDownload url) #install_path #PATCH
	DKDEBUGFUNC(${ARGV})
	string(REPLACE "/" ";" url_list ${url}) # split into list converting / to divider ;
	#foreach(item ${url_list})
	#	dk_verbose(item)
	#endforeach()
	list(LENGTH url_list url_length)
	#dk_verbose(url_length)
	
	if(${ARGC} GREATER 1)
		if(NOT "${ARGV1}" STREQUAL "PATCH")
			set(install_path ${ARGV1})
			dk_verbose(install_path)
		endif()
	endif()
	
	if(${ARGC} GREATER 2)
		if(NOT "${ARGV2}" STREQUAL "PATCH")
			set(tag ${ARGV2})
			dk_verbose(tag)
		endif()
	endif()
	
	dk_verbose(CMAKE_CURRENT_LIST_DIR)
	get_filename_component(Lib ${CMAKE_CURRENT_LIST_DIR} NAME)
	dk_verbose(Lib)
	
	string(TOUPPER ${Lib} LIB)
	dk_set(LIBVAR ${LIB})
	dk_verbose(LIBVAR)
	
	string(TOLOWER ${Lib} FOLDER)
	dk_set(${LIBVAR}_FOLDER ${FOLDER})
	if(NOT ${LIBVAR}_FOLDER)
		dk_assert("${LIBVAR}_FOLDER invalid")
	endif()
	dk_verbose(${LIBVAR}_FOLDER)
	
	# check current folder name
	dk_verbose("\${DKIMPORTS}/\${${LIBVAR}_FOLDER}} = ${DKIMPORTS}/${${LIBVAR}_FOLDER}}")
	if(NOT "${DKIMPORTS}/${FOLDER}" STREQUAL "${CMAKE_CURRENT_LIST_DIR}")
		dk_assert("The Imports folder is named inncorrectly. \n CURRENTLY: ${CMAKE_CURRENT_LIST_DIR} \n SHOULD BE: ${DKIMPORTS}/${${LIBVAR}_FOLDER}}")
	endif()
	
	math(EXPR last "${url_length}-1")
	list(GET url_list ${last} url${last})
	
#	dk_set(${LIBVAR}_DL ${url})
#	dk_removeExtension(${url${last}} tag)
	######### add recognizable file extensions ########## 
	string(FIND ${url${last}} ".7z" index)
	if(${index} GREATER -1)
	#dk_includes(${url${last}} ".7z" index)
	#if(${index})
		if(NOT tag)
			string(SUBSTRING ${url${last}} 0 ${index} tag)
		endif()
		dk_set(${LIBVAR}_DL ${url})
	endif()
	string(FIND ${url${last}} ".js" index)
	if(${index} GREATER -1)
	#dk_includes(${url${last}} ".js" index)
	#if(${index})
		if(NOT tag)
			string(SUBSTRING ${url${last}} 0 ${index} tag)
		endif()
		dk_set(${LIBVAR}_DL ${url})
	endif()
	string(FIND ${url${last}} ".tar.bz2" index)
	if(${index} GREATER -1)
	#dk_includes(${url${last}} ".tar.bz2" index)
	#if(${index})
		if(NOT tag)
			string(SUBSTRING ${url${last}} 0 ${index} tag)
		endif()
		dk_set(${LIBVAR}_DL ${url})
	endif()
	string(FIND ${url${last}} ".tar.gz" index)
	if(${index} GREATER -1)
	#dk_includes(${url${last}} ".tar.gz" index)
	#if(${index})
		if(NOT tag)
			string(SUBSTRING ${url${last}} 0 ${index} tag)
		endif()
		dk_set(${LIBVAR}_DL ${url})
	endif()
	string(FIND ${url${last}} ".zip" index)
	if(${index} GREATER -1)
	#dk_includes(${url${last}} ".zip" index)
	#if(${index})
		if(NOT tag)
			string(SUBSTRING ${url${last}} 0 ${index} tag)
		endif()
		dk_set(${LIBVAR}_DL ${url})
	endif()
	string(FIND ${url${last}} ".tar.xz" index)
	if(${index} GREATER -1)
	#dk_includes(${url${last}} ".tar.xz" index)
	#if(${index})
		if(NOT tag)
			string(SUBSTRING ${url${last}} 0 ${index} tag)
		endif()
		dk_set(${LIBVAR}_DL ${url})
	endif()
	######################################################

	if(tag)
		dk_set(${LIBVAR}_BRANCH ${tag})
	endif()
	
	if(FOLDER AND LIBVAR AND ${LIBVAR}_BRANCH)
		dk_set(${LIBVAR}_NAME ${FOLDER}-${${LIBVAR}_BRANCH})
	endif()
	
	if(install_path)
		dk_set(${LIBVAR} ${install_path})
	else()
		dk_set(${LIBVAR} ${3RDPARTY}/${${LIBVAR}_NAME})
	endif()
	
	if(NOT ${LIBVAR})
		dk_assert("LIBVAR invalid")
	endif()
	
	if(NOT ${LIBVAR}_BRANCH)
		dk_error("${LIBVAR}_BRANCH invalid")
	endif()
	
	if(NOT ${LIBVAR}_NAME)
		dk_assert("${LIBVAR}_NAME invalid")
	endif()
	
	if(NOT ${LIBVAR}_DL)
		dk_assert("${LIBVAR}_DL invalid")
	endif()
	
	dk_install(${${LIBVAR}_DL} ${${LIBVAR}} ${${LIBVAR}_FOLDER} ${ARGN})
endfunction()

###############################################################################
# dk_import(url) #args
#
#	This is a flexable super function for importing just about anything into digitalknob
#	The idea is to provide a url or path and dk_import will do the rest. 
#
#	@url	- The online path the .git or file to import
#
#	github GIT:	https://github.com/orginization/library.git		dk_importGit(url) #branch/tag #PATCH
#	github DL:	https://github.com/orginization/library			dk_importGit(url) #branch/tag #PATCH
#	lib url DL:	https://website.com/library.zip					dk_importDownload(url) #PATCH
#	exe url DL:	https://website.com/executable.exe 				dk_importDownload(url) #PATCH
#
#	TODO: https://cmake.org/cmake/help/latest/module/FetchContent.html 
#
function(dk_import url)
	DKDEBUGFUNC(${ARGV})
	dk_importVariables(${ARGV} plugin)
	string(TOUPPER ${plugin} plugin_var)
	
	dk_verbose("\${${plugin_var}}] =			${${plugin_var}}")
	dk_verbose("[${plugin_var}_URL] =			${${plugin_var}_URL}")
	dk_verbose("[${plugin_var}_VERSION] =		${${plugin_var}_VERSION}")
	dk_verbose("[${plugin_var}_FOLDER] =		${${plugin_var}_FOLDER}")
	dk_verbose("[${plugin_var}_BRANCH] =		${${plugin_var}_BRANCH}")
	dk_verbose("[${plugin_var}_TAG] =			${${plugin_var}_TAG}")
	
	### .git
	dk_getExtension(${url} extension)
	if("${extension}" STREQUAL ".git")
		if(NOT EXISTS ${${plugin_var}}/.git)
			dk_set(CURRENT_DIR ${DIGITALKNOB}/${3RDPARTY})
			if(EXISTS ${${plugin_var}})
				dk_remove(${${plugin_var}})
			endif()
			if(NOT EXISTS ${${plugin_var}})
				dk_makeDirectory(${${plugin_var}})
			endif()
			dk_set(CURRENT_DIR ${${plugin_var}})
			dk_command(${GIT_EXE} clone ${${plugin_var}_URL} ${${plugin_var}})
		endif()
		dk_set(CURRENT_DIR ${${plugin_var}})
		dk_command(${GIT_EXE} checkout -- .)
		dk_command(${GIT_EXE} checkout ${${plugin_var}_BRANCH})
		dk_command(${GIT_EXE} pull)
		if(${plugin_var}_TAG)
			dk_command(${GIT_EXE} checkout ${${plugin_var}_TAG})
		endif()
	### download
	else()
		dk_verbose("dk_install(${plugin} ${ARGN})")
		dk_install(${plugin} ${ARGN})
	endif()
	
	dk_includes("${ARGN}" "PATCH" has_patch)
	if(${has_patch})
		dk_patch(${plugin} ${${plugin_var}})
	endif()
	
	# Set the current build output directory
	dk_verbose("setting current build directory to ${${plugin_var}}/${BUILD_DIR}")
	dk_setPath(${${plugin_var}}/${BUILD_DIR})
	
endfunction()
dk_createOsMacros("dk_import")


###############################################################################
# dk_DownloadAll3rdParty()
#
#	TODO
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
			
			set(keepCommands "set;SET;dk_download;dk_install;dk_import")
			set(KEEPLINE 0)
			foreach(line ${lines})
			
				foreach(keepCommand ${keepCommands})
					dk_includes("${line}" "${keepCommand}(" hasCommand) # trailing (
					if(${hasCommand})
						set(KEEPLINE 1)
					endif()
					dk_includes("${line}" "${keepCommand} " hasCommand) # trailing space
					if(${hasCommand})
						set(KEEPLINE 1)
					endif()
					dk_includes("${line}" "${keepCommand}	" hasCommand) # trailing tab
					if(${hasCommand})
						set(KEEPLINE 1)
					endif()
				endforeach()
			
				if(KEEPLINE)
					set(dl_import_script "${dl_import_script}${line}\n")
				endif()
				string(FIND "${line}" ")" indexB) 
				if(${indexB} GREATER -1)
				#dk_includes("${line}" ")" indexB)
				#if(${indexB})
					set(KEEPLINE 0)
				endif()
			endforeach()
			
			if(dl_import_script)
				file(WRITE ${DKDOWNLOAD}/TEMP/dl_import.TMP "${dl_import_script}")
				INCLUDE(${DKDOWNLOAD}/TEMP/dl_import.TMP)
				dk_remove(${DKDOWNLOAD}/TEMP/dl_import.TMP)
			endif()
		endif()
	endforeach()
endfunction()


######################################################################
# dk_getFileType(path RESULT)
#  
#	Takes a path and checks the extension to return the file type.
#
#	@path		- A string value of the path to identify
#	@RESULT		- returns a string representing the  type of file.
#           	  Possible results are ARCHIVE, EXECUTABLE, IMAGE, SCRIPT, UNKNOWN, WEB, ...TODO
#
#	Reference: https://en.wikipedia.org/wiki/List_of_file_formats
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
# dk_getAppDirectory(RESULT)
#
#	Get the OS default app directory
#
#	@RESULT		- TODO
#
function(dk_getAppDirectory RESULT)
	DKDEBUGFUNC(${ARGV})
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
	set(${RESULT} ${appDirectory} PARENT_SCOPE)
endfunction()


###############################################################################
# toLower(str RESULT)
#
#	Convert a string to lower case
#
#	@str	- The input string to convert
#	@RESULT	- Returns the converted output string
#
function(toLower str RESULT)
	DKDEBUGFUNC(${ARGV})
	string(TOLOWER "${str}" upper)
	set(${RESULT} ${out} PARENT_SCOPE)
endfunction()


###############################################################################
# toUpper(str RESULT)
#
#	Convert a string to upper case
#
#	@str	- The input string to convert
#	@RESULT	- Returns the converted output string
#
function(toUpper str RESULT)
	#DKDEBUGFUNC(${ARGV})
	string(TOUPPER "${str}" upper)
	set(${RESULT} ${upper} PARENT_SCOPE)
endfunction()


###############################################################################
# dk_removeExtension(path RESULT) NOERROR
#
#	Remove the extension from a file path
#
#	@path				- TODO
#	@RESULT				- TODO
#   NOERROR (optional)	- if any of the parameters equals NOERROR, dk_error() messages will not be displayed
#
function(dk_removeExtension path RESULT)
	DKDEBUGFUNC(${ARGV})
	string(FIND ${path} "." includes REVERSE)
	if(${includes} EQUAL -1)
	#dk_includes(${path} "." includes REVERSE)
	#if(NOT includes)
		dk_includes("${ARGN}" "NOERROR" includes)
		if(${includes})
			dk_error("no extension found")
		endif()
		return()
	endif()
	
	dk_getExtension(${path} ext)
	string(REPLACE ${ext} "" fileNameNoExt ${path}) 
	#string(SUBSTRING ${path} 0 ${includes} fileNameNoExt)
    set(${RESULT} ${fileNameNoExt} PARENT_SCOPE)
endfunction()


###############################################################################
# dk_getAppName(path RESULT)
#
#	Get the app name from a file path
#
#	@path		- TODO
#	@RESULT		- TODO
#
function(dk_getAppName path RESULT)
	DKDEBUGFUNC(${ARGV})
	dk_getFilename(${path} fileName)
	dk_removeExtension(${fileName} fileNameNoExt)
	dk_verbose(fileNameNoExt)
	set(${RESULT} ${fileNameNoExt} PARENT_SCOPE)
endfunction()


###############################################################################
# dk_createPlugin(url)
#
#	Generate a folder/DKMAKE.cmake for a new plugin
#
#	@url	- TODO
#
function(dk_createPlugin url)
	DKDEBUGFUNC(${ARGV})
	dk_todo() #TODO
	dk_getAppName(${url} App_Name)
	dk_verbose(App_Name)					# My_App
	dk_toLower(${App_Name} app_name)
	dk_verbose(app_name)					# my_app
	dk_toUpper(${APP_NAME} APP_NAME)
	dk_verbose(APP_NAME)					# MY_APP
	dk_getAppDirectory(appDirectory)
	if(NOT exe_path)
		dk_set(exe_path ${appDirectory}/${App_Name}/${App_Name}.exe)
	endif()
endfunction()


###############################################################################
# dk_getGitBranchName(url RESULT)
#
#	Return the name of the head branch from a git repository
#
#	@url	- The git url
#	@RESULT	- Returns the name of the head branch
#
#	https://stackoverflow.com/a/31919435
#
function(dk_getGitBranchName url RESULT)
	DKDEBUGFUNC(${ARGV})
	execute_process(COMMAND ${GIT_EXE} ls-remote ${url} heads/* RESULT_VARIABLE result OUTPUT_VARIABLE output)
	set(${RESULT} ${output} PARENT_SCOPE)
endfunction()	


###############################################################################
# dk_printArgData()
#
#	Print the current CMake scripte path and ARG* variables
#
macro(dk_printArgData)
	DKDEBUGFUNC(${ARGV})
	dk_debug(" ")
	dk_debug("************************************************************")
	dk_debug(" ")
	dk_debug(CMAKE_CURRENT_LIST_DIR)
	dk_debug("*** ARG Variables ***")
	dk_debug(ARGC)
	dk_debug(ARGN)
	dk_debug(ARGV)	
	dk_debug(ARGV0)
	dk_debug(ARGV1)
	math(EXPR ARGC_LAST "${ARGC}-1")
	dk_debug(ARGC_LAST)
	set(ARGV_LAST ${ARGV${ARGC_LAST}})
	dk_debug(ARGV_LAST)
	dk_debug(" ")
endmacro()


###############################################################################
# dk_printUrlData(url)
#
#	Print url seperated into an array
#
#	@url	- The url to print
#
function(dk_printUrlData url)
	DKDEBUGFUNC(${ARGV})
	if(NOT url)
		dk_assert("url invalid! ")
	endif()
	dk_verbose("*** url Variables ***")
	dk_verbose(url)
	string(REPLACE "/" ";" PLUGIN_URL_LIST ${url}) # seperate the url nodes into a list 
	dk_verbose(PLUGIN_URL_LIST)
	list(LENGTH PLUGIN_URL_LIST PLUGIN_URL_LENGTH)
	dk_verbose(PLUGIN_URL_LENGTH)
	set(n -1)
	foreach(PLUGIN_URL_ITEM ${PLUGIN_URL_LIST})
		math(EXPR n "${n}+1")
		set(url_${n} ${PLUGIN_URL_ITEM})
		dk_verbose(url_${n})
		set(url_last ${url_${n}})
	endforeach()
	dk_verbose(url_last)
	dk_getFileType(${url} url_filetype)
	dk_verbose(url_filetype)
endfunction()


###############################################################################
# dk_killProcess(name)
#
#	Kill a running process by name
#
#	@name		- name of the process to kill
#
function(dk_killProcess name)
	DKDEBUGFUNC(${ARGV})
	dk_executeProcess("taskkill /f /im ${name}" NOASSERT)
endfunction()


###############################################################################
# dk_clearScreen()
#
#	Clear the console
#
function(dk_clearScreen)
	DKDEBUGFUNC(${ARGV})
	dk_debug("clear screen")
	execute_process(COMMAND "cmd /c cls")
endfunction()


###############################################################################
# dk_findLibrary(name)
#
#	Search for a library and include it with dk_lib
#
#	@name	- The name of the library
#
function(dk_findLibrary name)
	DKDEBUGFUNC(${ARGV})
	find_library(${name}_LIBRARY ${name})
	if(NOT WIN)
		if(NOT ${name}_LIBRARY)
			dk_assert("Could not locate ${name} Library")
		endif()
		#dk_debug(${name}_LIBRARY)
		dk_lib(${${name}_LIBRARY})
	else()
		#FIXME: no error control for non-windows library search
		#dk_debug(${name})
		dk_lib(${name})
	endif()
endfunction()
dk_createOsMacros("dk_findLibrary")


###############################################################################
# dk_findFiles(path pattern RESULT) RECURSE
#
#	Search for files within a path matching a pattern
#
#	@path				- The path to search 
#	@pattern			- The pattern to search for
#	@RESULT				- Returns the list of file(s) if found
#   RECURSE (optional) 	- Search the path recursivly 
#
function(dk_findFiles path pattern RESULT)
	DKDEBUGFUNC(${ARGV})
	dk_includes("${ARGN}" "RECURSE" recurse)
	if(${recurse})
		file(GLOB_RECURSE files "${path}/" "${path}/${pattern}")
	else()
		file(GLOB files "${path}/" "${path}/${pattern}")
	endif()
	if(NOT files)
		dk_error("files is invalid")
		return()
	endif()
	dk_debug(files)
	set(${RESULT} ${files} PARENT_SCOPE)
endfunction()


###############################################################################
# dk_shell(args)
#
#	Execute a UNIX style command
#
#	@args	- The command and args to execute
#
macro(dk_shell args)
	DKDEBUGFUNC(${ARGV})
	if(WIN_HOST)
		dk_msys(${ARGV})
	else()
		dk_command(${ARGV})
	endif()
endmacro()
dk_createOsMacros("dk_shell")


###############################################################################
# dk_queueShell(args)
#
#	Queue the execution of a UNIX style command
#
#	@args	- The command and args to execute
#
macro(dk_queueShell args)
	DKDEBUGFUNC(${ARGV})
	if(WIN_HOST)
		dk_queueMsys(${ARGV})
	else()
		dk_queueCommand(${ARGV})
	endif()
endmacro()
dk_createOsMacros("dk_queueShell")


###############################################################################
# dk_resizeImage(inpath width height outpath)
#
#	@inpath		- Full path of the image file to resize
#	@width		- The number of pixels in with to resize to 
#	@height		- The number of pixels in height to resize to
#	@outpath	- Full path of the output file to save to
#
function(dk_resizeImage inpath width height outpath)
	DKDEBUGFUNC(${ARGV})
	get_filename_component(outdir ${outpath} DIRECTORY)
	if(NOT outdir)
		dk_assert("outdir is invalid")
	endif()
	dk_makeDirectory(${outdir})
	if(IMAGEMAGICK_CONVERT)
		dk_executeProcess(${IMAGEMAGICK_CONVERT} ${inpath} -resize ${width}x${height} ${outpath})
	elseif(MAC_HOST)
		dk_executeProcess(sips -z ${width} ${height} ${inpath} --out ${outpath})
	else()
		dk_warn("No method to resize images on this host OS")
	endif()
endfunction()


###############################################################################
# dk_pathContains(expression RESULT)
#
#	@expression	- The search expression to use. Example: "${path}/subfolder/*.exe"
#   @RESULT		- Returns TRUE if the expression is found
#
function(dk_pathContains expression RESULT)
	DKDEBUGFUNC(${ARGV})
	FILE(GLOB contains "${expression}") 
	if(contains)
		set(${RESULT} TRUE PARENT_SCOPE)
		return()
	endif()
endfunction()



include(${DKFunctions_ext})

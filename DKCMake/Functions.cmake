include_guard()
# https://asitdhal.medium.com/cmake-functions-and-macros-22293041519f

########### SETTINGS ##############
###################################
set(DKCMAKE_DEBUG_LINE OFF CACHE INTERNAL "") # ON = DEBUG_LINE prints the File : lineNumber : Function( variables )

# Extra Log Info Variables
set(PRINT_CALL_DETAILS 1)
set(PRINT_FILE_NAMES 0)
set(PRINT_LINE_NUMBERS 0)
set(PRINT_FUNCTION_NAMES 1)
set(PRINT_FUNCTION_ ARGUMENTS 0)



if(CMAKE_HOST_WIN32)
	set(WIN_HOST TRUE CACHE INTERNAL "")
endif()
if(CMAKE_HOST_UNIX)
	set(UNIX_HOST TRUE CACHE INTERNAL "")
endif()
if(CMAKE_HOST_APPLE)
	set(MAC_HOST TRUE CACHE INTERNAL "")
endif()
if(CMAKE_HOST_UNIX AND NOT CMAKE_HOST_APPLE)
	set(LINUX_HOST TRUE CACHE INTERNAL "")
endif()

set(dkdepend_disable_list "" CACHE INTERNAL "")


###################################################################
# dk_FunctionName( ${arg0} ${arg1} rtn-var )
#  
# Description
#
#  ${arg0}: Description
#  rtn-var: Description
#          
# Reference: https://website.com
###################################################################
function(dk_file_getDigitalknobPath result)
	get_filename_component(DIGITALKNOB ${CMAKE_SOURCE_DIR} ABSOLUTE)
	get_filename_component(FOLDER_NAME ${DIGITALKNOB} NAME)
	while(NOT FOLDER_NAME STREQUAL "digitalknob")
		get_filename_component(DIGITALKNOB ${DIGITALKNOB} DIRECTORY)
		get_filename_component(FOLDER_NAME ${DIGITALKNOB} NAME)
		if(NOT FOLDER_NAME)
			DKASSERT("Could not locate digitalknob root path")
		endif()
	endwhile()
	set(${result} ${DIGITALKNOB} PARENT_SCOPE)
endfunction()
dk_file_getDigitalknobPath(DIGITALKNOB)


macro(updateLogInfo)
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


####  message log
include(${DIGITALKNOB}/DK/DKCMake/Color.cmake)
macro(DKASSERT msg)
	updateLogInfo()
	message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${BG_red}${msg}${CLR}")
	#message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${red}${msg}${CLR}")
	dk_exit()
endmacro()
macro(DKERROR msg)
	updateLogInfo()
	message(STATUS "${H_black}${STACK_HEADER}${CLR}${red}${msg}${CLR}")
	#message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${red}${msg}${CLR}")
	#dk_exit()
	#Wait()
endmacro()
macro(DKWARN msg)
	updateLogInfo()
	#message(WARNING "${H_black}${STACK_HEADER}${CLR}${yellow}${msg}${CLR}")
	message(STATUS "${H_black}${STACK_HEADER}${CLR}${yellow}${msg}${CLR}")
endmacro()
macro(DKINFO msg)
	updateLogInfo()
	message(STATUS "${H_black}${STACK_HEADER}${CLR}${white}${msg}${CLR}")
endmacro()
macro(DKDEBUG msg)
	updateLogInfo()
	#message(DEBUG "${H_black}${STACK_HEADER}${CLR}${cyan}${msg}${CLR}")  # DEBUG FLAG NOT WORKING
	message(STATUS "${H_black}${STACK_HEADER}${CLR}${cyan}${msg}${CLR}")
endmacro()
macro(DKVERBOSE msg)
	updateLogInfo()
	#message(VERBOSE "${H_black}${STACK_HEADER}${CLR}${magenta}${msg}${CLR}") # VERBOSE FLAG NOT WORKING
	message(STATUS "${H_black}${STACK_HEADER}${CLR}${magenta}${msg}${CLR}")
endmacro()
macro(DKTRACE msg)
	updateLogInfo()
	#message(TRACE "${H_black}${STACK_HEADER}${CLR}${B_blue}${msg}${CLR}") # TRACE FLAG NOT WORKING
	message(WARNING "${H_black}${STACK_HEADER}${CLR}${B_blue}${msg}${CLR}")
endmacro()

macro(DEBUG_LINE)
	if(DKCMAKE_DEBUG_LINE)
		#dk_getFilename(${CMAKE_CURRENT_FUNCTION_LIST_FILE} FILENAME)
		if(NOT CMAKE_CURRENT_FUNCTION_LIST_FILE)
			set(CMAKE_CURRENT_FUNCTION_LIST_FILE "unknown")
		endif()
		get_filename_component(FILENAME ${CMAKE_CURRENT_FUNCTION_LIST_FILE} NAME) 
		message(STATUS "${cyan}${FILENAME}:${CMAKE_CURRENT_FUNCTION_LIST_LINE} -> ${CMAKE_CURRENT_FUNCTION}(${ARGV})${CLR}")
	endif()
endmacro()

execute_process(COMMAND ${CMAKE_COMMAND} -E remove ${DIGITALKNOB}/DK/DKCMake/Functions_Ext.cmake)
file(APPEND ${DIGITALKNOB}/DK/DKCMake/Functions_Ext.cmake "### Don't make changes in this file. They will not save. ###\n")
file(APPEND ${DIGITALKNOB}/DK/DKCMake/Functions_Ext.cmake "### This file was automatically generated from Functions.cmake ###\n")
function(CreateFunc str)
	if(0)
		cmake_language(EVAL CODE ${str}) # only available on cmake 3.18+
	else()
		file(APPEND ${DIGITALKNOB}/DK/DKCMake/Functions_Ext.cmake "${str}")
	endif()
endfunction()


function(AliasFunctions name)
	CreateFunc("macro(WIN_HOST_${name})\n   if(WIN_HOST)\n      ${name}(\${ARGV})\n  endif()\nendmacro()\n")
	CreateFunc("macro(WIN32_HOST_${name})\n   if(WIN_HOST AND X86)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(WIN64_HOST_${name})\n   if(WIN_HOST AND X64)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(UNIX_HOST_${name})\n   if(UNIX_HOST)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(MAC_HOST_${name})\n   if(MAC_HOST)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(MAC32_HOST_${name})\n   if(MAC_HOST AND X86)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(MAC64_HOST_${name})\n   if(MAC_HOST AND X64)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(LINUX_HOST_${name})\n   if(LINUX_HOST)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(LINUX32_HOST_${name})\n   if(LINUX_HOST AND X86)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(LINUX64_HOST_${name})\n   if(LINUX_HOST AND X64)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	
	CreateFunc("macro(WIN_${name})\n   if(WIN)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(WIN32_${name})\n   if(WIN_32)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(WIN64_${name})\n   if(WIN_64)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(UNIX_${name})\n   if(NOT WIN)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(APPLE_${name})\n   if(MAC OR IOS OR IOSSIM)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(MAC_${name})\n   if(MAC)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(MAC32_${name})\n   if(MAC_32)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(MAC64_${name})\n   if(MAC_64)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(IOS_${name})\n   if(IOS AND NOT IOSSIM)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(IOS32_${name})\n   if(IOS_32 AND NOT IOSSIM)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(IOS64_${name})\n   if(IOS_64 AND NOT IOSSIM)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(IOSSIM_${name})\n   if(IOSSIM)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(IOSSIM32_${name})\n   if(IOSSIM_32)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(IOSSIM64_${name})\n   if(IOSSIM_64)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(LINUX_${name})\n   if(LINUX)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(LINUX32_${name})\n   if(LINUX_32)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(LINUX64_${name})\n   if(LINUX_64)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(RASPBERRY_${name})\n   if(RASPBERRY)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(RASPBERRY32_${name})\n   if(RASPBERRY_32)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(RASPBERRY64_${name})\n   if(RASPBERRY_64)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(ANDROID_${name})\n   if(ANDROID)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(ANDROID32_${name})\n   if(ANDROID_32)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(ANDROID64_${name})\n   if(ANDROID_64)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	
	if("${ARGN}" STREQUAL "NO_DEBUG_RELEASE_TAGS")
		return()
	endif()
	CreateFunc("macro(DEBUG_${name})\n   if(DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(WIN_DEBUG_${name})\n   if(WIN AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(WIN32_DEBUG_${name})\n   if(WIN_32 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(WIN64_DEBUG_${name})\n   if(WIN_64 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(UNIX_DEBUG_${name})\n   if(NOT WIN AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(APPLE_DEBUG_${name})\n   if(MAC OR IOS OR IOSSIM AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(MAC_DEBUG_${name})\n   if(MAC AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(MAC32_DEBUG_${name})\n   if(MAC_32 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(MAC64_DEBUG_${name})\n   if(MAC_64 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(IOS_DEBUG_${name})\n   if(IOS AND DEBUG AND NOT IOSSIM)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(IOS32_DEBUG_${name})\n   if(IOS_32 AND DEBUG AND NOT IOSSIM)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(IOS64_DEBUG_${name})\n   if(IOS_64 AND DEBUG AND NOT IOSSIM)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(IOSSIM_DEBUG_${name})\n   if(IOSSIM AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(IOSSIM32_DEBUG_${name})\n   if(IOSSIM_32 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(IOSSIM64_DEBUG_${name})\n   if(IOSSIM_64 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(LINUX_DEBUG_${name})\n   if(LINUX AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(LINUX32_DEBUG_${name})\n   if(LINUX_32 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(LINUX64_DEBUG_${name})\n   if(LINUX_64 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(RASPBERRY_DEBUG_${name})\n   if(RASPBERRY AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(RASPBERRY32_DEBUG_${name})\n   if(RASPBERRY_32 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(RASPBERRY64_DEBUG_${name})\n   if(RASPBERRY_64 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(ANDROID_DEBUG_${name})\n   if(ANDROID AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(ANDROID32_DEBUG_${name})\n   if(ANDROID_32 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(ANDROID64_DEBUG_${name})\n   if(ANDROID_64 AND DEBUG)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	
	CreateFunc("macro(RELEASE_${name})\n   if(RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(WIN_RELEASE_${name})\n   if(WIN AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(WIN32_RELEASE_${name})\n   if(WIN_32 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(WIN64_RELEASE_${name})\n   if(WIN_64 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(UNIX_RELEASE_${name})\n   if(NOT WIN AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(APPLE_RELEASE_${name})\n   if(MAC OR IOS OR IOSSIM AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(MAC_RELEASE_${name})\n   if(MAC AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(MAC32_RELEASE_${name})\n   if(MAC_32 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(MAC64_RELEASE_${name})\n   if(MAC_64 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(IOS_RELEASE_${name})\n   if(IOS AND RELEASE AND NOT IOSSIM)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(IOS32_RELEASE_${name})\n   if(IOS_32 AND RELEASE AND NOT IOSSIM)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(IOS64_RELEASE_${name})\n   if(IOS_64 AND RELEASE AND NOT IOSSIM)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(IOSSIM_RELEASE_${name})\n   if(IOSSIM AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(IOSSIM32_RELEASE_${name})\n   if(IOSSIM_32 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(IOSSIM64_RELEASE_${name})\n   if(IOSSIM_64 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(LINUX_RELEASE_${name})\n   if(LINUX AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(LINUX32_RELEASE_${name})\n   if(LINUX_32 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(LINUX64_RELEASE_${name})\n   if(LINUX_64 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(RASPBERRY_RELEASE_${name})\n   if(RASPBERRY AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(RASPBERRY32_RELEASE_${name})\n   if(RASPBERRY_32 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(RASPBERRY64_RELEASE_${name})\n   if(RASPBERRY_64 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(ANDROID_RELEASE_${name})\n   if(ANDROID AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(ANDROID32_RELEASE_${name})\n   if(ANDROID_32 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")
	CreateFunc("macro(ANDROID64_RELEASE_${name})\n   if(ANDROID_64 AND RELEASE)\n      ${name}(\${ARGV})\n   endif()\nendmacro()\n")	
endfunction()

### print all variables
function(dk_printAllVariables)
	get_cmake_property(_variableNames VARIABLES)
	list (SORT _variableNames)
	foreach (_variableName ${_variableNames})
		message(STATUS "${_variableName}=${${_variableName}}")
		file(APPEND ${CMAKE_BINARY_DIR}/cmake_variables.txt "${_variableName} ==           ${${_variableName}}\n")
	endforeach()
endfunction()

# dk_string_has
function(dk_includes str substr result)
	string(FIND "${str}" "${substr}" index)
	if(${index} GREATER -1)
		set(${result} true PARENT_SCOPE)
	else()
		set(${result} false PARENT_SCOPE)
	endif()
endfunction()

# https://stackoverflow.com/a/29250496/688352
function(DKSET variable value)
	set(${variable} ${value} ${ARGN} CACHE INTERNAL "")
	#show library versions
	dk_includes(${variable} "_VERSION" result)
	if(${result})
		DKINFO("${variable}: ${value}")
	endif()
endfunction()
AliasFunctions("DKSET")


function(DKUNSET variable)
	set(${variable} "" CACHE INTERNAL "")
	unset(${variable})
endfunction()


macro(dk_exit)
	#DKINFO("dk_exit()")
	DEBUG_LINE()
	if(WIN_HOST)
		execute_process(COMMAND taskkill /IM cmake.exe /F WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})
	else()
		execute_process(COMMAND killall -9 cmake WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})
	endif()
endmacro()

#####################################################################
###################         DKFUNCTIONS           ###################
#####################################################################
## TOREAD:    https://foonathan.net/2016/03/cmake-install/ 

# TestReturnValue(args result)
#####################################################
# 	Example function that uses returns value with a supplied variable 
# Implementation: 
#	function(TestReturnValue args result)
#		set(args ${ARGV})
#		list(GET args -1 result)
#		list(REMOVE_AT args -1)
#		set(${result} ${args} PARENT_SCOPE) #just relay the arguments
#	endfunction()
#
# Usage:
#	TestReturnValue("ABC" "123" 5 myResult)
#	message(STATUS "TestReturnValue() -> myResult = ${myResult}") # should print->  return value = ABC;123;5
#####################################################

# CreateFunction(name contents args)
######################################################
# 	Example that creates functions dynamicaly at run time
# Implementation:	
#	function(CreateFunction name contents) #args)
#		if(CMAKE_VERSION VERSION_LESS 3.18)
#			if(NOT extFileCleared)
#				file(WRITE ext_functions.cmake "")
#				set(extFileCleared 1 CACHE INTERNAL "")
#			endif()
#			file(APPEND ext_functions.cmake "function(${name}) ${contents} \nendfunction() \n")
#			include(ext_functions.cmake)
#		else()
#			cmake_language(EVAL CODE "function(${name}) \n${contents} endfunction()")
#		endif()	
#	endfunction()
	
# Usage:
#	CreateFunction(MyDynamicFunc 
#		"message(STATUS \"Test message\")") 
#		"foreach(arg IN LIST ${ARGN})
#			set(count 0) 
#			message(STATUS \"arg:${count} = ${arg}\")
#			MATH(EXPR count \"${cound}+1\")
#		endforeach()"
#		${ARGN}
#	)
#	
#	set(myVariable "myVariable")
#	MyDynamicFunc("myStringData" "My;List;Data" "${myVariable}" 17 moreData)
##################################################

# Wait(message)  
#############################
# Wait until keypress or timeout (60 seconds). The 'message' parameter is optional
macro(Wait)
	DEBUG_LINE()
	set(msg ${ARGV})
	if(NOT msg)
		set(msg "press and key to continue") #default
	endif()
	if(WIN_HOST)	
		execute_process(COMMAND cmd /c echo ${msg} && timeout /t 60 > nul WORKING_DIRECTORY C:/)
		return()
	endif()
	if(CMAKE_HOST_UNIX)
		execute_process(COMMAND bash -c "read -n 1 -s -r -p \"${msg}\"" OUTPUT_VARIABLE outVar)
		return()
	endif()	
	DKINFO("Wait() Not implemented for this platform")
endmacro()


# DUMP(<variable_name>)
macro(DUMP dmpvar)
	DKINFO(" \n")
	DKINFO("************** DUMP ****************")
	if(CMAKE_CURRENT_FUNCTION_LIST_FILE)
		dk_getFilename(${CMAKE_CURRENT_FUNCTION_LIST_FILE} FILENAME)
	endif()
	DKINFO("${FILENAME}:${CMAKE_CURRENT_FUNCTION_LIST_LINE} -> ${CMAKE_CURRENT_FUNCTION}(${ARGV})")
	DKINFO("${dmpvar} = ${${dmpvar}}")
	DKINFO("${dmpvar} = \"${dmpvar}\"")
	#DKINFO("${dmpvar} = \"${${dmpvar}}\"")
	list(LENGTH ${dmpvar} dmpvar_LENGTH)
	DKINFO("${dmpvar}_LENGTH = ${dmpvar_LENGTH}")
	if(NOT DEFINED ${dmpvar})
		DKINFO("DUMP(${dmpvar}) variable not defined. The correct syntax is \"DUMP(varname)\", using the variable name")
		DKINFO("DUMP(varname): CORRECT        DUMP(\${varname}): INCORRECT")
	endif()
	DKINFO("************************************")
	DKINFO("\n")
endmacro()


# dk_debug_watch(<variable_name>)  "ALIASL WATCH(<variable_name>)"
macro(WATCH var)
	variable_watch(var varwatch)
endmacro()

macro(varwatch var access val lst stack)
    DKINFO("Variable watch: var=${var} access=${access} val=${val} 1st=${1st} stack=${stack}")
	Wait()
endmacro()


# set a XCode specific property
macro(set_xcode_property TARGET XCODE_PROPERTY XCODE_VALUE)
    set_property (TARGET ${TARGET} PROPERTY XCODE_ATTRIBUTE_${XCODE_PROPERTY} ${XCODE_VALUE})
endmacro(set_xcode_property)


function(DELETE_CACHE)
	DKINFO("####### Deleteing CMake cache . . .")
	dk_file_getDigitalknobPath(DIGITALKNOB)
	if(WIN_HOST)
		DKEXECUTE_PROCESS(for /r %%i in (CMakeCache.*) do del "%%i" WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(for /d /r %%i in (*CMakeFiles*) do rd /s /q "%%i" WORKING_DIRECTORY ${DIGITALKNOB})
	else()
		DKEXECUTE_PROCESS(find . -name "CMakeCache.*" -delete WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS("rm -rf `find . -type d -name CMakeFiles`" WORKING_DIRECTORY ${DIGITALKNOB})
	endif()
endfunction()

function(DELETE_TMP_FILES)
	DKINFO("####### Deleteing Temporary files . . .")
	dk_file_getDigitalknobPath(DIGITALKNOB)
	if(WIN_HOST)
		DKEXECUTE_PROCESS(for /r %%i in (*.TMP) do del "%%i" WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(for /r %%i in (*.tmp) do del "%%i" WORKING_DIRECTORY ${DIGITALKNOB})
	else()
		DKEXECUTE_PROCESS("rm -rf `find . -name *.tmp`" WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(find . -name "*.TMP" -delete WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(find . -name "*.tmp" -delete WORKING_DIRECTORY ${DIGITALKNOB})
		
	endif()
endfunction()

function(DeleteEmptyDirectories path)
	if(NOT EXISTS ${path})
		DKINFO("DeleteEmptyDirectories(): path does not exist")
		return()
	endif()
	if(WIN_HOST)
		execute_process(COMMAND for /f "delims=" %d in ('dir /s /b /ad ^| sort /r') do rd "%d" WORKING_DIRECTORY ${path})
	else()
		DKINFO("DeleteEmptyDirectories() Not implemented for this platform")
	endif()
endfunction()

function(DKSETENV name value)
	#DKINFO("DKSETENV(${name} ${value})")
	#DKINFO("ENVname = $ENV{${name}}")
	#DKINFO("value = ${value}")
	if(ENV{${name}})
		string(FIND $ENV{${name}} ${value} index)
	else()
		set(index -1)
	endif()
	
	if(${index} EQUAL -1)
	#if(NOT "$ENV{${name}}" STREQUAL "${value}")
		if(WIN_HOST)
			DKINFO("Setting %${name}% environment variable to ${value}")
			DKEXECUTE_PROCESS(setx ${name} ${value}) # https://stackoverflow.com/a/69246810
		else()
			DKWARN("DKSETENV() not implemented on this system")
		endif()
	endif()
endfunction()


##https://cmake.org/pipermail/cmake/2012-September/052205.html/
# dk_file_download
function(DOWNLOAD src_path dest_path) # ARGV1 = dest_path
	#FIXME: Will not download if only 1 argument
	#TODO: Let's supply the ability to add a primary root address to download from,  for fast downloading from local hard drives or storage 
	#      we will also add a "backup" root address to download from. In case one of the internet download fails.
	#      Also, we will treat the url variable like a list. If it has more one item, treat them as alternative download links
	#if(NOT PrimaryDownloadServer)
	#	DKINFO("TODO: just set PrimaryDownloadServer to your mirror location and all file downoads will attempt that location first")
	#endif()
	#if(NOT SecondaryDownloadServer)
	#	DKINFO("TODO: just set SecondaryDownloadServer to your mirror location and all file downoads that fail will attempt secondary location next")
	#endif()
	
	## Setup all src_path variables
	if(NOT src_path)
		DKERROR("src_path is invalid")
		return()
	endif()
	DKDEBUG("DOWNLOAD(): src_path = ${src_path}")
	
	get_filename_component(src_dir ${src_path} DIRECTORY)
	if(NOT src_dir)
		DKERROR("src_dir is invalid")
		return()
	endif()
	DKDEBUG("DOWNLOAD(): src_dir = ${src_dir}")
	
	get_filename_component(src_filename ${src_path} NAME)
	if(NOT src_filename)
		DKERROR("src_filename is invalid")
		return()
	endif()
	DKDEBUG("DOWNLOAD(): src_filename = ${src_filename}")
	
	dk_getExtension(${src_path} src_ext)	
	if(NOT src_ext)
		DKERROR("src_ext is invalid")
		return()
	endif()
	DKDEBUG("DOWNLOAD(): src_ext = ${src_ext}")
	
	## Setup all dest_path variables
	if(NOT dest_path)
		set(dest_path ${DKDOWNLOAD})
	endif()
	if(NOT dest_path)
		DKERROR("dest_path is invalid")
		return()
	endif()	
	if(IS_DIRECTORY ${dest_path})
		set(dest_path "${dest_path}/${src_filename}")
	endif()
	DKDEBUG("DOWNLOAD(): dest_path = ${dest_path}")
	
	get_filename_component(dest_dir ${dest_path} DIRECTORY)
	if(NOT dest_dir)
		DKERROR("dest_dir is invalid")
		return()
	endif()
	if(NOT EXISTS ${dest_dir})
		DKWARN("The destination directory does not exists. It will be created \n ${dest_dir}")
		dk_makeDirectory(${dest_dir})
	endif()
	DKSET(CURRENT_DIR ${dest_dir})
	DKDEBUG("DOWNLOAD(): dest_dir = ${dest_dir}")
	
	get_filename_component(dest_filename ${dest_path} NAME)
	if(NOT dest_filename)
		DKERROR("dest_filename is invalid")
		return()
	endif()
	DKDEBUG("DOWNLOAD(): dest_filename = ${dest_filename}")
	
	dk_getExtension(${dest_path} dest_ext)
	if(NOT dest_ext)
		DKERROR("dest_ext is invalid")
		return()
	endif()
	DKDEBUG("DOWNLOAD(): dest_ext = ${dest_ext}")
	
	if(EXISTS ${dest_path})
		DKWARN("DOWNLOAD(): The destination path already exists \n ${dest_path}")
		return()
	endif()
	
	DKDEBUG("Downloading ${src_path}")
	DKDEBUG("      To -> ${dest_path}")
	
	## setup temp_path variables
	set(temp_filename "${dest_filename}.downloading")
	set(temp_path ${dest_dir}/${temp_filename})
	DKDEBUG("temp_path = ${temp_path}")
	if(EXISTS ${temp_path})
		DKREMOVE(${temp_path})
	endif()
	if(EXISTS ${temp_path})
		DKERROR("The temporary destination path already exists and could not be removed \n ${temp_path}")
		return()
	endif()
	
	DKINFO("Downloading ${src_filename}. . . please wait")
	file(DOWNLOAD ${src_path} ${temp_path} 
		SHOW_PROGRESS 
		INACTIVITY_TIMEOUT 60
		STATUS status 
	)
	list(GET status 0 status_code) 
	list(GET status 1 status_string)
	if(NOT status_code EQUAL 0)
		DKREMOVE(${temp_path})
		DKERROR("error: downloading ${src_path} \n status_code: ${status_code} \n status_string: ${status_string}")
	else()
		if(NOT EXISTS ${temp_path})
			DKERROR("Could not locate temporary download file \n ${temp_path}")
			return()
		endif()
		DKRENAME(${temp_path} ${dest_path} false)
		if(NOT EXISTS ${dest_path})
			DKERROR("Could not locate downloaded file \n ${dest_path}")
			return()
		endif()
		DKINFO("Finnished downloading ${dest_filename} \n")
	endif() 
endfunction()
AliasFunctions("DOWNLOAD")


# dk_file_extract
function(DKEXTRACT src dest)
	if(NOT EXISTS ${dest})
		dk_makeDirectory(${dest})
	endif()
	if(NOT EXISTS ${CMAKE_COMMAND})
		DKERROR("CMAKE_COMMAND not found: \${CMAKE_COMMAND} = ${CMAKE_COMMAND}")
	endif()
	#execute_process(COMMAND ${CMAKE_COMMAND} -E tar xvf ${src} WORKING_DIRECTORY ${dest})
	DKEXECUTE_PROCESS(${CMAKE_COMMAND} -E tar xvf ${src} WORKING_DIRECTORY ${dest})
endfunction()


# dk_file_compress
function(DKZIP path)
	DKINFO("Zipping: ${path}")
	if(NOT EXISTS ${path})
		DKERROR("ERROR: DKZIP(): the path ${path} does not exist")
	endif()
	execute_process(COMMAND ${CMAKE_COMMAND} -E tar "cfv" "${DKPROJECT}/assets.zip" --format=zip "." WORKING_DIRECTORY ${path}/)
endfunction()


# dk_file_copy
function(DKCOPY from to overwrite)
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
						DKINFO("COPIED: ${sourcefile} to ${destinationfile}")
					elseif(compare_result EQUAL 0)
						#DKINFO("${sourcefile} No Copy, The files are identical.")
					else()
						DKWARN( "DKCOPY(${from} ${to} ${overwrite}): \n ERROR: compare_result = ${compare_result}")
					endif()
				elseif(NOT EXISTS ${destinationfile})
					execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${sourcefile} ${destinationfile})
					DKINFO("COPIED: ${sourcefile} to ${destinationfile}")
				endif()
			endforeach()
		else()
			if(overwrite)
				execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${from} ${to})
				DKINFO("COPIED: ${from} to ${to}")
			elseif(NOT EXISTS ${to})
				execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${from} ${to})
				DKINFO("COPIED: ${from} to ${to}")
			endif()
		endif()
	else()
		DKINFO("!WARNING! DKCOPY(): The source path does not exist.\n (${from})\n")
	endif()
endfunction()


# dk_file_compair
function(DKCOMPAREFILES fileA fileB)
	execute_process(COMMAND ${CMAKE_COMMAND} -E compare_files ${fileA} ${fileB} RESULT_VARIABLE compare_result)
	if(compare_result EQUAL 0)
		DKINFO("The files are identical.")
	elseif(compare_result EQUAL 1)
		DKINFO("The files are different.")
	else()
		DKINFO("Error while comparing the files.")
	endif()
endfunction()


# dk_file_rename
function(DKRENAME from to overwrite)
	DKINFO("Renameing ${from} to ${to}")
	if(EXISTS ${from})
		if(EXISTS ${to})
			if(NOT ${overwrite})
				DKWARN("Cannot rename file. Destiantion exists and not set to overwrite")
				return()
			endif()
			DKREMOVE(${to})
		endif()
		file(RENAME ${from} ${to})
	endif()
endfunction()


# dk_file_remove
function(DKREMOVE path)
	if(NOT EXISTS ${path})
		#DKINFO("WARNING: DKREMOVE(${path}): path does not exist")
		return()
	endif()
	if(IS_DIRECTORY ${path})
		execute_process(COMMAND ${CMAKE_COMMAND} -E remove_directory ${path})
	else()
		execute_process(COMMAND ${CMAKE_COMMAND} -E remove ${path})
	endif()
endfunction()


function(UPX_COMPRESS path)
	DKINFO("UPX compressing ${path}...")
	DKINFO("Please wait...")
	DKEXECUTE_PROCESS("${UPX_EXE} -9 -v ${path}")
endfunction()


function(DKENABLE plugin)
	if(NOT ${plugin})
		if(${ARGC} GREATER 1)
			DKSET(${${ARGV1}} ON)
			DKSET(HAVE_${${ARGV1}} ON)
			#In c++ we can't use certian symbals in the preprocess or for macros. - must be turned to _
			string(REPLACE "-" "_" argv1_macro "${ARGV1}")
			string(REPLACE "." "_" argv1_macro "${argv1_macro}")
			DKDEFINE(HAVE_${argv1_macro})
		else()
			DKSET(${plugin} ON)
			DKSET(HAVE_${plugin} ON)
			#In c++ we can't use certian symbals in the preprocess or for macros. - must be turned to _
			string(REPLACE "-" "_" plugin_macro "${plugin}")
			string(REPLACE "." "_" plugin_macro "${plugin_macro}")
			DKDEFINE(HAVE_${plugin_macro})
		endif()
	endif()
endfunction()


function(DKDISABLE plugin)
	if(BYPASS_DISABLE)
		DKINFO("* DKDISABLE(${plugin}) ignored.  BYPASS_DISABLE is set to ON. ${plugin} will not be disabled *")
		return()
	endif()
	if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKCMAKE} AND NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKPROJECT}) # /from DKCMake or curremt Project directory only
		DKERROR("\n! WARNING !\n DKDISABLE() Can only be used from the DKCMake/Disabled.cmake file. This is to avoid having disabled libraries hideing everywhere.\n")
	endif()
	
	if(NOT EXISTS ${DKIMPORTS}/${plugin}/DKMAKE.cmake)
	if(NOT EXISTS ${DKPLUGINS}/${plugin}/DKMAKE.cmake)
		DKWARN("DKDISABLE(${plugin}):  unable to locate plugin in /3rdParty/_DKIMPORTS  or /DKPlugins")
		return()
	endif()
	endif()
	
	if(${ARGC} GREATER 1)
		DKUNSET(${ARGV1})
		DKUNSET(HAVE_${ARGV1})
		#In c++ we can't use certian symbals in the preprocess or for macros. - must be turned to _
		string(REPLACE "-" "_" argv1_macro "${ARGV1}")
		DKUNDEFINE(HAVE_${argv1_macro})
		DKUNDEPEND(${ARGV1})
	else()
		DKUNSET(${plugin})
		DKUNSET(HAVE_${plugin})
		#In c++ we can't use certian symbals in the preprocess or for macros. - must be turned to _
		string(REPLACE "-" "_" plugin_macro "${plugin}")
		DKUNDEFINE(HAVE_${plugin_macro})
		DKUNDEPEND(${plugin})
	endif()
endfunction()


function(DKDEFINE str)
	if(CMAKE_SCRIPT_MODE_FILE)
		return()
	endif()
	list(FIND DKDEFINES_LIST "${str}" index)
	if(${index} GREATER -1)
		return() ## already in the list, return.
	endif()
	DKSET(DKDEFINES_LIST ${DKDEFINES_LIST} ${str})
	add_definitions(-D${str})
endfunction()
AliasFunctions("DKDEFINE")

function(DKUNDEFINE str)
	if(NOT DKDEFINES_LIST)
		return()
	endif()
	list(REMOVE_ITEM DKDEFINES_LIST ${str})
	remove_definitions(-D${str})
endfunction()


function(DKINCLUDE path)
	foreach(item ${ARGV})
		list(FIND DKINCLUDES_LIST "${item}" index)
		if(${index} GREATER -1)
			continue()  #item is already in the list
		endif()
		DKSET(DKINCLUDES_LIST ${DKINCLUDES_LIST} ${item})
		include_directories(${item})
		
		if(INSTALL_DKLIBS)
			dk_getFilename(${CMAKE_CURRENT_LIST_DIR} LIB_NAME)
			file(INSTALL DIRECTORY ${path}/ DESTINATION ${CMAKE_INSTALL_PREFIX}/${LIB_NAME}/include FILES_MATCHING PATTERN "*.h")
		endif()
		
	endforeach()
endfunction()
AliasFunctions("DKINCLUDE")


function(DKLINKDIR path)
	foreach(item ${ARGV})
		list(FIND DKLINKDIRS_LIST "${item}" index)
		if(${index} GREATER -1)
			continue()  #item is already in the list
		endif()
		DKSET(DKLINKDIRS_LIST ${DKLINKDIRS_LIST} ${item})
		link_directories(${item})
	endforeach()
endfunction()
AliasFunctions("DKLINKDIR")


#function(dk_getCurrentDirectory result)
#
#	if(WIN_HOST)
#		execute_process(COMMAND echo "hello world" ECHO_OUTPUT_VARIABLE output WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
#	else()
#		execute_process(COMMAND pwd ECHO_OUTPUT_VARIABLE output WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
#	endif()
#	execute_process(COMMAND timeout /t 2 /nobreak WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})  ##wait 2 seconds for the stdout to flush
#	DKINFO("output = ${output}")
#	set(${result} ${output} PARENT_SCOPE)
#endfunction()


function(dk_makeDirectory path)
	make_directory(${path})  #requires full path
	return()
	
	#build missing directory parents recursivley
	#if(MAC_HOST)
	#	file(RELATIVE_PATH rel_path "${DIGITALKNOB}/DK" ${path})
	#	DKINFO("RELATIVE_PATH(${path}) OF (${DIGITALKNOB}/DK) =-> ${rel_path}")
	#	DKINFO("MAKE_DIRECTORY ${rel_path}")
	#	file(MAKE_DIRECTORY ${rel_path})
	#else()
	#	string(REPLACE "/" ";" path_list ${path})
	#	foreach(item ${path_list})
	#		string(REPLACE "home" "/home" item ${item})
	#		if(path2)
	#			set(path2 "${path2}/${item}")
	#			if(NOT EXISTS ${path2})
	#				file(MAKE_DIRECTORY ${path2})
	#			endif()
	#		else()
	#			set(path2 "${item}")
	#		endif()
	#	endforeach()
	#endif()
endfunction()


function(dk_getDirectory path result)
	string(FIND ${path} "/" index REVERSE)
	if(${index} EQUAL -1)
		return() #no path dividers found
	endif()
	string(SUBSTRING ${path} 0 ${index} directory) 
    set(${result} ${directory} PARENT_SCOPE)
endfunction()


function(dk_getFilename path result)
	string(FIND ${path} "/" index REVERSE)
	if(${index} EQUAL -1)
		DKERROR("No Path Dividers found")
		return()
	endif()
	MATH(EXPR index "${index}+1")
	string(SUBSTRING ${path} ${index} -1 filename) 
    set(${result} ${filename} PARENT_SCOPE)
endfunction()


function(dk_getExtension path result)
	# WHY A NEW GET EXTENSION FUNCTION ?
	# get_filename_component(extension ${url} EXT)       #Gets the large part of the extension of everything after the first .
	# get_filename_component(extension ${url} LAST_EXT)  #LAST_EXT only available with cmake 3.14+ 
	# cmake_path(GET url EXTENSION LAST_ONLY extension)  #LAST_ONLY only available with cmake 3.19+
	string(FIND ${path} "." index REVERSE)
	if(${index} EQUAL -1)
		return() # no extension found
	endif()
	string(SUBSTRING ${path} ${index} -1 ext) 
    set(${result} ${ext} PARENT_SCOPE)
endfunction()


function(dk_dirIsEmpty path result)
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


function(DKREFRESH_ICONS)
	DKEXECUTE_PROCESS(ie4uinit.exe -ClearIconCache)
	DKEXECUTE_PROCESS(ie4uinit.exe -show)   ##Windows 10
endfunction()

function(DKPATCH import_name dest_path)
	DKINFO("\nCOPYING PATCH FILES FROM _IMPORTS/${import_name} TO ${dest_path}")
	DKINFO("To stop patch files from overwriting install files, remove the \"PATCH\" argument from the end of the DKIMPORT or DKINSTALL command\n")
	DKINFO("located in ${DKIMPORTS}/${import_name}/DKMAKE.cmake")
	DKCOPY(${DKIMPORTS}/${import_name}/ ${dest_path}/ TRUE)
endfunction()

# For archive files such as libraries and assets, the arguments are:  The download src_path, the name of its _DKIMPORTS folder, The name given to the installed 3rdParty/folder  
# For executable files such as software amd IDE's the arguments are:  The download src_path, the name of the final name of the dl file, The installation path to check for installation.
function(DKINSTALL src_path import_name dest_path)

	DKINFO("\n")
	string(TOLOWER ${import_name} import_name_lower)
	if(NOT ${import_name} STREQUAL ${import_name_lower})
		DKERROR("ERROR: 2nd parameter in DKINSTALL() (${import_name}) must be all lowercase")
	endif()
	
	if(NOT EXISTS ${DKIMPORTS}/${import_name})
		DKERROR("ERROR: 2nd parameter in DKINSTALL() (${DKIMPORTS}/${import_name}) does not exist")
	endif()
	if(EXISTS ${dest_path}/installed)
		#DKINFO("${import_name} already installed")
		if("${ARGN}" STREQUAL "PATCH")
			DKINFO("\nCOPYING PATCH FILES FROM _IMPORTS/${import_name} TO COMPLETE INSTALL.")
			DKINFO("To stop patch files from overwriting install files, remove the \"PATCH\" argument from the end of the DKIMPORT or DKINSTALL command\n")
			DKINFO("located in ${DKIMPORTS}/${import_name}/DKMAKE.cmake")
			DKCOPY(${DKIMPORTS}/${import_name}/ ${dest_path}/ TRUE)
		endif()
		return()
	endif()
	DKDEBUG("\n")
	DKDEBUG("DKINSTALL((): src_path = ${src_path}")
	dk_getDirectory(${src_path} src_directory)
	DKDEBUG("DKINSTALL((): src_directory = ${src_directory}")
	dk_getFilename(${src_path} src_filename)
	DKDEBUG("DKINSTALL((): src_filename = ${src_filename}")
	dk_getExtension(${src_filename} src_extension)
	DKDEBUG("DKINSTALL((): src_extension = ${src_extension}")
	DKDEBUG("\n")
	DKDEBUG("DKINSTALL((): dest_path = ${dest_path}")
	dk_getDirectory(${dest_path} dest_directory)
	DKDEBUG("DKINSTALL((): dest_directory = ${dest_directory}")
	dk_getFilename(${dest_path} dest_filename)
	DKDEBUG("DKINSTALL((): dest_filename = ${dest_filename}")
	dk_getExtension(${dest_filename} dest_extension)
	DKDEBUG("DKINSTALL((): dest_extension = ${dest_extension}")
	DKDEBUG("\n")
	
	
	# let's check that the scr_filename has at least the name of the target in it somewhere, or else we gotta rename it
	string(TOLOWER ${src_filename} src_filename_lower)
	string(FIND ${src_filename_lower} ${import_name} index)
	if(${index} EQUAL -1)
		DKDEBUG("The download filename ${src_filename} does not contaian the import name ${import_name}")
		string(TOLOWER ${dest_filename} dest_filename_lower)
		string(FIND ${dest_filename_lower} ${import_name} index)
		if(${index} EQUAL -1)
			set(dl_filename "${import_name}-${dest_filename}${src_extension}") 
		else()
			set(dl_filename "${dest_filename}${src_extension}")
		endif()
	elseif(NOT ${src_filename} MATCHES "[0-9]")
		DKDEBUG("The download filename ${src_filename} does not contain any numbers to identify it's version")
		DKDEBUG("Normally we would rename the downloaded filename to ${dest_filename}${src_extension}, but we'll let it pass.")
		#set(dl_filename "${dest_filename}${src_extension}")
		set(dl_filename ${src_filename})
	else()
		set(dl_filename ${src_filename})
	endif()
	
	DOWNLOAD(${src_path} ${DKDOWNLOAD}/${dl_filename})
	if(NOT EXISTS ${DKDOWNLOAD}/${dl_filename})
		DKERROR("The download files does not exist")
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
	##If the file type is unknown, we'll still try to extract it like a compressed file anyway
	##It's better the have a chance at success.
	DKDEBUG("The Downloaded file ${${dl_filename}} is a ${FILETYPE} file ${src_extension}")
	if(${FILETYPE} STREQUAL "UNKNOWN")
		set(FILETYPE "Archive")
		DKDEBUG("We will try to extract it in case it's an archive, but it may fail.")
	endif()
	if(${FILETYPE} STREQUAL "Archive")
		DKREMOVE(${DKDOWNLOAD}/UNZIPPED)
		DKEXTRACT(${DKDOWNLOAD}/${dl_filename} ${DKDOWNLOAD}/UNZIPPED)
		#We either have a root folder in /UNZIPPED, or multiple files without a root folder
		file(GLOB items RELATIVE "${DKDOWNLOAD}/UNZIPPED/" "${DKDOWNLOAD}/UNZIPPED/*")
		list(LENGTH items count)
		if(${count} GREATER 2) ##NOTE: This should be "${count} GREATER 1" but msys has a readme file in it next to the inner msys folder and that messes things up for more than 1
			#Zip extracted with no root folder, Rename UNZIPPED and move to 3rdParty
			DKRENAME(${DKDOWNLOAD}/UNZIPPED ${dest_path} true)
		else()
			if(EXISTS ${DKDOWNLOAD}/UNZIPPED/${dest_filename}) ##Zip extracted to expected folder. Move the folder to 3rdParty
				DKRENAME(${DKDOWNLOAD}/UNZIPPED/${dest_filename} ${dest_path} true)
				DKREMOVE(${DKDOWNLOAD}/UNZIPPED)
			else() #Zip extracted to a root folder, but not named what we expected. Rename and move folder to 3rdParty
				foreach(item ${items})
					if(NOT IS_DIRECTORY ${DKDOWNLOAD}/UNZIPPED/${item})
						list(REMOVE_ITEM items ${item}) #remove any readme.txt or other non-directory items
					endif()
				endforeach()
				DKRENAME(${DKDOWNLOAD}/UNZIPPED/${items} ${dest_path} true)
				DKREMOVE(${DKDOWNLOAD}/UNZIPPED)
			endif() 
		endif()
	#elseif(${FILETYPE} STREQUAL "Executable")
	#	DKSETPATH(${DKDOWNLOAD})
	#	DKSET(QUEUE_BUILD ON)
	#	DKEXECUTE(${DKDOWNLOAD}/${src_filename})
	else() #NOT ARCHIVE, just copy the file into it's 3rdParty folder
		DKCOPY(${DKDOWNLOAD}/${dl_filename} ${dest_path}/${dl_filename} TRUE)
	endif()
	if("${ARGN}" STREQUAL "PATCH")
		DKPATCH(${import_name} ${dest_path})
	else()
		file(GLOB ITEMS ${DKIMPORTS}/${import_name}/*)
		list(LENGTH ITEMS count)
		DKDEBUG(${count})
		if(${count} GREATER 1)
			DKWARN("\nFound ${count} items in the ${import_name} import folder. DKINSTALL has not requested to PATCH to the install files. If needed, add PATCH as the last argument to the DKINSTALL or DKIMPORT command in ${DKIMPORTS}/${import_name}/DKMAKE.cmake\n")
		endif()
	endif()
	file(WRITE ${dest_path}/installed "${dest_filename}\n")
endfunction()
AliasFunctions("DKINSTALL" "NO_DEBUG_RELEASE_TAGS")

function(dk_validatePath path result)
	get_filename_component(path ${path} ABSOLUTE)
	set(${result} ${path} PARENT_SCOPE)
endfunction()


function(WIN_GetShortPath path result)
	if(WIN_HOST)
		execute_process(COMMAND ${DKCMAKE}/GetShortPath.cmd ${path} OUTPUT_VARIABLE path WORKING_DIRECTORY ${DIGITALKNOB})
		string(REPLACE "\\" "/" path ${path})
		string(REPLACE "\n" "" path ${path})
		set(${result} ${path} PARENT_SCOPE)
	endif()
endfunction()



function(DKEXECUTE_PROCESS commands)
	set(commands ${ARGV})
	list(REMOVE_ITEM commands COMMAND) # we can supply the cmake specific base commands
	list(REMOVE_ITEM commands "cmd /c ")
	
	list(FIND commands "WORKING_DIRECTORY" index) #find WORKING_DRIECTORY
	if(index EQUAL -1)
		set(command ${commands} WORKING_DIRECTORY ${CURRENT_DIR}) #add it if missing
	endif()	
	
	DKINFO("")
	DKINFO("*** Commands ***")
	DKINFO("-> ${commands}")
	DKINFO("")
	
	if(WIN_HOST)
		execute_process(COMMAND cmd /c ${commands} RESULT_VARIABLE result ERROR_VARIABLE error) #FIXME: Do we always need  cmd /c  here?
	else()
		execute_process(COMMAND ${commands} RESULT_VARIABLE result ERROR_VARIABLE error)
	endif()
	if(NOT ${result} EQUAL 0)
		if(WIN_HOST)
			execute_process(COMMAND timeout /t 2 /nobreak OUTPUT_QUIET WORKING_DIRECTORY ${CURRENT_DIR}) ##wait 2 seconds for the stdout to flush before printing error
		else()
			execute_process(COMMAND sleep 2 WORKING_DIRECTORY ${CURRENT_DIR}) ##wait 2 seconds for the stdout to flush before printing error
		endif()
		DKINFO("\n\n")
		#DKERROR("ERROR: command=${commands}\n  result=${result}\n   error=${error}\n\n")
		DKASSERT("ERROR: command=${commands}\n  result=${result}\n   error=${error}\n\n")
	endif()
endfunction()



###################### DK_PATH ####################
function(DKSETPATH path)
	if(path STREQUAL "OFF")
		return() 
	endif()	
	DKSET(CURRENT_DIR ${path})
	if(NOT EXISTS ${CURRENT_DIR})
		DKINFO("Creating directory: ${CURRENT_DIR})")
		dk_makeDirectory(${CURRENT_DIR})
	endif()
	
	# TODO https://stackoverflow.com/a/6595001/688352
	# NOTE: Some 3rdParty projects break when their binary output path is changed. It may be better to compile the project normally, then do a library install to a final common location 
	#if(WIN_HOST)
	#	foreach(item ${DKCMAKE_BUILD})
	#		string(FIND "${item}" "-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY=" index)
	#		if(${index} GREATER -1)
	#			list(REMOVE_ITEM DKCMAKE_BUILD ${item})
	#		endif()
	#	
	#		string(FIND "${item}" "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=" index)
	#		if(${index} GREATER -1)
	#			list(REMOVE_ITEM DKCMAKE_BUILD ${item})
	#		endif()
	#		
	#		string(FIND "${item}" "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=" index)
	#		if(${index} GREATER -1)
	#			list(REMOVE_ITEM DKCMAKE_BUILD ${item})
	#		endif()
	#	endforeach()
	#	DKSET(DKCMAKE_BUILD ${DKCMAKE_BUILD} -DCMAKE_ARCHIVE_OUTPUT_DIRECTORY=${CURRENT_DIR} -DCMAKE_LIBRARY_OUTPUT_DIRECTORY=${CURRENT_DIR} -DCMAKE_RUNTIME_OUTPUT_DIRECTORY=${CURRENT_DIR})
	#endif()
endfunction()
AliasFunctions("DKSETPATH")


###################  Windows MSYS  ######################
function(MSYS)
	DEBUG_LINE()
	if(QUEUE_BUILD)
		string(REPLACE ";" " " str "${ARGV}")
		set(bash "#!/bin/bash")
		list(APPEND bash "cd ${CURRENT_DIR}")
		if(WIN_32 OR ANDROID_32)
			list(APPEND bash "export PATH=${MINGW32}/bin:$PATH")
		elseif(WIN_64 OR ANDROID_64)
			list(APPEND bash "export PATH=${MINGW64}/bin:$PATH")
		else()
			DKERROR("MSYS(): ERROR: not WIN_32, WIN_64, ANDROID_32 or ANDROID_64")
		endif()
		list(APPEND bash "export PATH=${MSYS}/bin:$PATH")
		list(APPEND bash "${str}")
		list(APPEND bash "exit")
		list(APPEND bash " ")
		string(REPLACE ";" "\n"	bash "${bash}")
		string(REPLACE "C:/" "/c/" bash ${bash})
		file(WRITE ${MSYS}/dkscript.tmp ${bash})
		DKINFO("MSYS -> ${bash}")
		DKEXECUTE_PROCESS(${MSYS}/bin/bash ${MSYS}/dkscript.tmp)
	endif()
endfunction()
AliasFunctions("MSYS")

###################  Windows MSYS2  ######################
function(MSYS2)
	DEBUG_LINE()
	if(QUEUE_BUILD)
		string(REPLACE ";" " " str "${ARGV}")
		set(bash "#!/bin/bash")
		list(APPEND bash "cd ${CURRENT_DIR}")
		if(WIN_32 OR ANDROID_32)
			list(APPEND bash "export PATH=${MINGW32}/bin:$PATH")
		elseif(WIN_64 OR ANDROID_64)
			list(APPEND bash "export PATH=${MINGW64}/bin:$PATH")
		else()
			DKERROR("MSYS2(): ERROR: not WIN_32, WIN_64, ANDROID_32 or ANDROID_64")
		endif()
		list(APPEND bash "export PATH=${MSYS2}/usr/bin:$PATH")
		list(APPEND bash "${str}")
		list(APPEND bash "exit")
		list(APPEND bash " ")
		string(REPLACE ";" "\n"	bash "${bash}")
		string(REPLACE "C:/" "/c/" bash ${bash})
		file(WRITE ${MSYS2}/dkscript.tmp ${bash})
		DKINFO("MSYS2 -> ${bash}")
		DKEXECUTE_PROCESS(${MSYS2}/usr/bin/bash ${MSYS2}/dkscript.tmp)
	endif()
endfunction()
AliasFunctions("MSYS2")


function(DKMERGE_FLAGS args result)
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
					#set(placeholder ${index})
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
			list(INSERT args ${placeholder} "${DK_${word}}")  #FIXME:  Error on Linux:  List index: 6 out of range (-6, 5)
		endif()
	endforeach()
	set(${result} ${args} PARENT_SCOPE)
endfunction()


function(DKCOMMAND)
	if(NOT EXISTS ${CURRENT_DIR})
		DKSET(CURRENT_DIR ${DIGITALKNOB})
	endif()
	#DKDEBUG("${ARGV}")
	DKMERGE_FLAGS("${ARGV}" merged_args)
	#DKDEBUG("${ARGV}")
	DKEXECUTE_PROCESS(${merged_args} WORKING_DIRECTORY ${CURRENT_DIR})
endfunction()
AliasFunctions("DKCOMMAND")


function(DKQCOMMAND)
	if(QUEUE_BUILD)
		DKCOMMAND(${ARGV})
	endif()	
endfunction()
AliasFunctions("DKQCOMMAND")



################# Visual Studio Build ################
function(DEBUG_VS folder sln_file) #target #arch
	if(DEBUG AND QUEUE_BUILD)
		if(NOT EXISTS ${3RDPARTY}/${folder}/${OS}/${sln_file})
			DKERROR("CANNOT FIND: ${3RDPARTY}/${folder}/${OS}/${sln_file}" )
		endif()
		if(${ARGC} GREATER 3)
			set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /t:${ARGV2} /p:Configuration=Debug /p:Platform=${ARGV3})
		elseif(${ARGC} GREATER 2)
			set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /t:${ARGV2} /p:Configuration=Debug)
		else()
			set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /p:Configuration=Debug)
		endif()
		DKEXECUTE_PROCESS(${EXECUTE_COMMAND} WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
	endif()
endfunction()
AliasFunctions("DEBUG_VS" "NO_DEBUG_RELEASE_TAGS")

function(RELEASE_VS folder sln_file) #target #arch
	if(RELEASE AND QUEUE_BUILD)
		if(NOT EXISTS ${3RDPARTY}/${folder}/${OS}/${sln_file})
			DKERROR("CANNOT FIND: ${3RDPARTY}/${folder}/${OS}/${sln_file}" )
		endif()
		if(${ARGC} GREATER 3)
			set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /t:${ARGV2} /p:Configuration=Release /p:Platform=${ARGV3})
		elseif(${ARGC} GREATER 2)
			set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /t:${ARGV2} /p:Configuration=Release)
		else()
			set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /p:Configuration=Release)
		endif()
		DKEXECUTE_PROCESS(${EXECUTE_COMMAND} WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
	endif()
endfunction()
AliasFunctions("RELEASE_VS" "NO_DEBUG_RELEASE_TAGS")

function(VS)
	DEBUG_VS(${ARGV})
	RELEASE_VS(${ARGV})
endfunction()
AliasFunctions("VS" "NO_DEBUG_RELEASE_TAGS")


################### Xcode Build ###################
function(DEBUG_XCODE folder)
	if(DEBUG AND QUEUE_BUILD)
		if(${ARGC} GREATER 1)
			DKEXECUTE_PROCESS(xcodebuild -target ${ARGV1} -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		else()
			DKEXECUTE_PROCESS(xcodebuild -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		endif()
	endif()
endfunction()
AliasFunctions("DEBUG_XCODE" "NO_DEBUG_RELEASE_TAGS")

function(RELEASE_XCODE folder)
	if(RELEASE AND QUEUE_BUILD)
		if(${ARGC} GREATER 1)
			DKEXECUTE_PROCESS(xcodebuild -target ${ARGV1} -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		else()
			DKEXECUTE_PROCESS(xcodebuild -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		endif()
	endif()
endfunction()
AliasFunctions("RELEASE_XCODE" "NO_DEBUG_RELEASE_TAGS")

function(XCODE)
		DEBUG_XCODE(${ARGV})
		RELEASE_XCODE(${ARGV})
endfunction()
AliasFunctions("XCODE" "NO_DEBUG_RELEASE_TAGS")


####################### Android NDK Build #################
function(DEBUG_NDK folder)
	if(DEBUG AND QUEUE_BUILD)
		if(WIN_HOST)
			DKEXECUTE_PROCESS(${ANDROIDNDK}/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS}/Debug)
		endif()
		if(UNIX_HOST)
			DKEXECUTE_PROCESS(${ANDROIDNDK}/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS}/Debug)
		endif()
	endif()
endfunction()
AliasFunctions("DEBUG_NDK" "NO_DEBUG_RELEASE_TAGS")

function(RELEASE_NDK folder)
	if(RELEASE AND QUEUE_BUILD)
		if(WIN_HOST)
			DKEXECUTE_PROCESS(${ANDROIDNDK}/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS}/Release)
		endif()
		if(UNIX_HOST)
			DKEXECUTE_PROCESS(${ANDROIDNDK}/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS}/Release)
		endif()
	endif()
endfunction()
AliasFunctions("RELEASE_NDK" "NO_DEBUG_RELEASE_TAGS")

function(NDK)
		DEBUG_NDK(${ARGV})
		RELEASE_NDK(${ARGV})
endfunction()
AliasFunctions("NDK" "NO_DEBUG_RELEASE_TAGS")



###################### DKPlugin Link Libraries #####################
function(DKLIB lib_path)
	foreach(item ${ARGV})
		#DKSET(LIBLIST "${LIBLIST} ${lib_path}") ## used for double checking
		string(FIND "${LIBS}" "${item}" index)
		if(NOT ${index} EQUAL -1)
			continue() # item is already in the list
		endif()
		DKSET(LIBS "${LIBS};${item}")

		if(INSTALL_DKLIBS)
			if(EXISTS ${lib_path})
				dk_getFilename(${CMAKE_CURRENT_LIST_DIR} LIB_NAME)
				file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/${LIB_NAME}/lib/${OS})
			else()
				DKERROR("Could not locate ${lib_path}")
			endif()
		endif()
		
	endforeach()
endfunction()
AliasFunctions("DKLIB" "NO_DEBUG_RELEASE_TAGS")

function(DEBUG_DKLIB lib_path)
	if(NOT DEBUG)
		return()
	endif()	
	DKSET(LIBLIST ${LIBLIST} ${lib_path}) ## used for double checking
	if(NOT EXISTS ${lib_path})
		DKINFO("MISSING: ${lib_path}")
		DKSET(QUEUE_BUILD ON) 
	endif()
	string(FIND "${DEBUG_LIBS}" "${lib_path}" index)
	if(NOT ${index} EQUAL -1)
		return() ## The library is already in the list
	endif()
	if(LINUX OR RASPBERRY OR ANDROID)
		DKSET(DEBUG_LIBS debug ${lib_path} ${DEBUG_LIBS})  #Add to beginning of list
	else()
		DKSET(DEBUG_LIBS ${DEBUG_LIBS} debug ${lib_path})  #Add to end of list
	endif()

	if(INSTALL_DKLIBS)
		dk_getFilename(${CMAKE_CURRENT_LIST_DIR} LIB_NAME)
		file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/${LIB_NAME}/lib/${OS}/Debug)
	endif()
	
endfunction()
AliasFunctions("DEBUG_DKLIB" "NO_DEBUG_RELEASE_TAGS")

function(RELEASE_DKLIB lib_path)
	if(NOT RELEASE)
		return()
	endif()
	DKSET(LIBLIST ${LIBLIST} ${lib_path}) ## used for double checking
	if(NOT EXISTS ${lib_path})
		DKINFO("MISSING: ${lib_path}")
		DKSET(QUEUE_BUILD ON)
	endif()
	string(FIND "${RELEASE_LIBS}" "${lib_path}" index)
	if(NOT ${index} EQUAL -1)
		return() ## The library is already in the list
	endif()	
	if(LINUX OR RASPBERRY OR ANDROID)
		DKSET(RELEASE_LIBS optimized ${lib_path} ${RELEASE_LIBS})  #Add to beginning of list
	else()
		DKSET(RELEASE_LIBS ${RELEASE_LIBS} optimized ${lib_path})  #Add to end of list
	endif()
	
	if(INSTALL_DKLIBS)
		dk_getFilename(${CMAKE_CURRENT_LIST_DIR} LIB_NAME)
		file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/${LIB_NAME}/lib/${OS}/Release)
	endif()
	
endfunction()
AliasFunctions("RELEASE_DKLIB" "NO_DEBUG_RELEASE_TAGS")


function(generateCmake plugin_name)
	DEBUG_LINE()
	dk_getPathToPlugin(${plugin_name} plugin_path)
	if(NOT EXISTS "${plugin_path}")
		DKERROR("generateCmake(${plugin_name}): plugin not found")
		return()
	endif()

	##Create CmakeLists.txt file
	DKREMOVE(${plugin_path}/CMakeLists.txt)
	file(APPEND ${plugin_path}/CMakeLists.txt "### This file is generated by DKCMake. Any Changes here, will be overwritten. ###\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "### ${plugin_name} ###\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "cmake_minimum_required(VERSION 3.10)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "cmake_policy(SET CMP0054 NEW)\n")
	#file(APPEND ${plugin_path}/CMakeLists.txt "cmake_policy(SET CMP0002 OLD)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "include(${DKCMAKE}/Functions.cmake)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "include(${DKCMAKE}/Variables.cmake)\n")
		
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
	#file(APPEND ${plugin_path}/CMakeLists.txt "target_compile_options(${plugin_name} PRIVATE \${CMAKE_CXX_FLAGS} $<$<CONFIG:Debug>:\${CMAKE_CXX_FLAGS_DEBUG}> $<$<CONFIG:Release>:\${CMAKE_CXX_FLAGS_RELEASE}>)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "if(WIN_HOST)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		set_target_properties(${plugin_name} PROPERTIES LINKER_LANGUAGE CPP)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "endif()\n")
	
	#file(APPEND ${plugin_path}/CMakeLists.txt "install(TARGETS ${plugin_name} DESTINATION lib/\${OS})\n")
	#file(APPEND ${plugin_path}/CMakeLists.txt "file(GLOB HEADER_FILES ${plugin_path}/*.h)\n")
	#file(APPEND ${plugin_path}/CMakeLists.txt "install(FILES \${HEADER_FILES} DESTINATION include/${plugin_name})\n")
	
	#file(APPEND ${plugin_path}/CMakeLists.txt "if(NOT DKAPP)\n")
	#file(APPEND ${plugin_path}/CMakeLists.txt "     set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${plugin_name})\n")
	#file(APPEND ${plugin_path}/CMakeLists.txt "endif()\n")
	
	##add headers to DKPlugins.h
	if(${plugin_name} STREQUAL DK OR STATIC)
		file(GLOB HEADER_FILES RELATIVE ${DKPLUGINS} ${plugin_path}/*.h)
		foreach(header ${HEADER_FILES})
			string(FIND "${PLUGINS_FILE}" "${header}" index)
			if(${index} EQUAL -1)
				DKINFO("Adding ${header} to header file.")
				DKSET(PLUGINS_FILE ${PLUGINS_FILE} "#include \"${header}\"\\n")
			endif()
		endforeach()
	endif()
	
	DKENABLE(${plugin_name})
	WIN_DEBUG_DKLIB(${plugin_path}/${OS}/${DEBUG_DIR}/${plugin_name}.lib)
	WIN_RELEASE_DKLIB(${plugin_path}/${OS}/${RELEASE_DIR}/${plugin_name}.lib)
	APPLE_DEBUG_DKLIB(${plugin_path}/${OS}/${DEBUG_DIR}/lib${plugin_name}.a)
	APPLE_RELEASE_DKLIB(${plugin_path}/${OS}/${RELEASE_DIR}/lib${plugin_name}.a)
	LINUX_DEBUG_DKLIB(${plugin_path}/${OS}/${DEBUG_DIR}/lib${plugin_name}.a)
	LINUX_RELEASE_DKLIB(${plugin_path}/${OS}/${RELEASE_DIR}/lib${plugin_name}.a)
	RASPBERRY_DEBUG_DKLIB(${plugin_path}/${OS}/${DEBUG_DIR}/lib${plugin_name}.a)
	RASPBERRY_RELEASE_DKLIB(${plugin_path}/${OS}/${RELEASE_DIR}/lib${plugin_name}.a)
	ANDROID_DEBUG_DKLIB(${plugin_path}/${OS}/${DEBUG_DIR}/lib${plugin_name}.a)
	ANDROID_RELEASE_DKLIB(${plugin_path}/${OS}/${RELEASE_DIR}/lib${plugin_name}.a)
	if(REBUILD OR REBUILDALL)
		DKSET(QUEUE_BUILD ON)
	endif()
	
	DKSET(DKPLUGIN_LIST ${DKPLUGIN_LIST} ${plugin_name})  #Add to list
endfunction()


function(DKDLL name)
	DEBUG_LINE()
	dk_getPathToPlugin(${name} plugin_path)
	if(NOT EXISTS "${plugin_path}")
		DKINFO("DKDLL(): ${name} plugin not found")
		return()
	endif()
	DKINCLUDE(${plugin_path})
			
	##Create CmakeLists.txt file
	DKREMOVE(${plugin_path}/CMakeLists.txt)
	if(NOT EXISTS "${plugin_path}/CMakeLists.txt")
	file(APPEND ${plugin_path}/CMakeLists.txt "### ${name} ###\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "cmake_minimum_required(VERSION 3.10)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "cmake_policy(SET CMP0054 NEW)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "include(${DKCMAKE}/Functions.cmake)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "include(${DKCMAKE}/Variables.cmake)\n")
	
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
		#file(APPEND ${plugin_path}/CMakeLists.txt "target_link_libraries(${name} debug ${DKPLUGINS}/DK/${OS}/${DEBUG_DIR}/DK.lib optimized ${DKPLUGINS}/DK/${OS}/${RELEASE_DIR}/DK.lib) \n")
		file(APPEND ${plugin_path}/CMakeLists.txt "target_link_libraries(${name} ${DLL_DEBUG_LIBS} ${DLL_RELEASE_LIBS} ${DLL_LIBS}) \n")
	endif()
	file(APPEND ${plugin_path}/CMakeLists.txt "if(WIN_HOST)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "		set_target_properties(${name} PROPERTIES LINKER_LANGUAGE CPP)\n")
	file(APPEND ${plugin_path}/CMakeLists.txt "endif()\n")
	endif()
	ADDTO_DKPLUGIN_LIST(${name})
endfunction()

# TODO
function(DKEXECUTABLE name)
	DEBUG_LINE()
	dk_getPathToPlugin(${name} plugin_path)
	if(NOT EXISTS "${plugin_path}")
		DKERROR("DKEXECUTABLE(): ${name} plugin not found")
		return()
	endif()
	DKINCLUDE(${plugin_path})
	DKREMOVE(${plugin_path}/CMakeLists.txt)
	if(NOT EXISTS "${plugin_path}/CMakeLists.txt")
	#file(APPEND ${plugin_path}/CMakeLists.txt "### ${name} ###\n")
	#file(APPEND ${plugin_path}/CMakeLists.txt "cmake_minimum_required(VERSION 3.10)\n")
	#file(APPEND ${plugin_path}/CMakeLists.txt "cmake_policy(SET CMP0054 NEW)\n")
	#file(APPEND ${plugin_path}/CMakeLists.txt "include(${DKCMAKE}/Functions.cmake)\n")
	#file(APPEND ${plugin_path}/CMakeLists.txt "include(${DKCMAKE}/Variables.cmake)\n")
	#file(APPEND ${plugin_path}/CMakeLists.txt "project(${name})\n")
	endif()
	ADDTO_DKPLUGIN_LIST(${name})
endfunction()


function(DKTESTAPP name)
	DEBUG_LINE()
	dk_getPathToPlugin(${name} plugin_path)
	if(NOT EXISTS "${plugin_path}/test")
		DKINFO("DKTESTAPP(): ${name}_test app not found")
		return()
	endif()
	DKINFO("building ${name}_test app")
	DKSET(test_path "${plugin_path}/test")
	
	##Create CmakeLists.txt file
	DKREMOVE("${test_path}/CMakeLists.txt")
	file(APPEND ${test_path}/CMakeLists.txt "### This file is generated by DKCMake. Any Changes here, will be overwritten. ###\n")
	file(APPEND ${test_path}/CMakeLists.txt "### ${name} ###\n")
	file(APPEND ${test_path}/CMakeLists.txt "cmake_minimum_required(VERSION 3.10)\n")
	file(APPEND ${test_path}/CMakeLists.txt "cmake_policy(SET CMP0054 NEW)\n")
	file(APPEND ${test_path}/CMakeLists.txt "include(${DKCMAKE}/Functions.cmake)\n")
	file(APPEND ${test_path}/CMakeLists.txt "include(${DKCMAKE}/Variables.cmake)\n")
	DKAPPEND_CMAKE("project(${name}_test)\n")
	DKAPPEND_CMAKE("include_directories(${DKPLUGINS})\n")
		
	#TODO		

	ADDTO_DKPLUGIN_LIST(${name})
endfunction()


function(ADDTO_DKPLUGIN_LIST name)
	DEBUG_LINE()
	dk_getPathToPlugin(${name} plugin_path)
	if(NOT EXISTS "${plugin_path}")
		DKERROR("DKEXECUTABLE(): ${name} plugin not found")
		return()
	endif()
	DKINCLUDE(${plugin_path})
	DKSET(DKPLUGIN_LIST ${DKPLUGIN_LIST} ${name})
endfunction()

function(DKAPPEND_CMAKE str)

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

# Add a library's files to the App's assets
function(DKASSETS name)
	DEBUG_LINE()
	if(NOT DKAPP)
		return()
	endif()	
	dk_getPathToPlugin(${name} plugin_path)
	if(NOT plugin_path)
		DKERROR("${name} plugin not found")
		return()
	endif()
	DKINFO("Importing ${name} assets...")
	file(COPY ${plugin_path} DESTINATION ${DKPROJECT}/assets ${ASSETS})
	#file(COPY ${plugin_path}/${OS}/${DEBUG_DIR}/*.exe DESTINATION ${DKPROJECT}/assets/${OS}/Debug)
endfunction()


function(dk_getPathToPlugin name result)
	DEBUG_LINE()
	list(FIND dkdepend_disable_list "${ARGV}" index)
	if(${index} GREATER -1)
		DKINFO("${ARGV} IS DISABLED")
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
	#DKERROR("Could not find ${name} Plugin.")
	DKASSERT("Could not find ${name} Plugin.")
endfunction()


# Add a library or plugin to the dependency list
function(DKDEPEND name)
	DEBUG_LINE()
	DKDEBUG("CMAKE_CURRENT_LIST_DIR = ${CMAKE_CURRENT_LIST_DIR}")
	
	if(${ARGC} GREATER 1)
		DKINFO("ARGV = ${ARGV}")
		#DUMP(ARGV) # FIXME: DUMP not working here, show 2 for the ARGC count, but only shows variable name ARGV, no value
	endif()

	list(FIND dkdepend_disable_list ${name} index)
	if(${index} GREATER -1)
		DKINFO("${name} IS DISABLED")
		return()
	endif()
	
	# TODO TODO TODO TODO 
	# dk_createSmartObject(${name}) #TODO:  automatically determin plugin, create variables, setup auto compiles, etc 
	# TODO TODO TODO TODO 
	
	# If DKDEPEND had second variable (a sub library), set that variable to ON
	# if(${ARGC} GREATER 1)
	#	list(FIND dkdepend_list "${name} ${args}" index)
	#	if(${index} GREATER -1) #library is already in the list
	#		return()
	#	endif()
	# else()
	#	list(FIND dkdepend_list "${name}" index)
	#	if(${index} GREATER -1)
	#		return() #library is already in the list
	#	endif()
	# endif()
		
	list(FIND dkdepend_list ${name} index)
	if(${index} GREATER -1)
		return()  #library is already in the list
	endif()
	
	DKENABLE(${name})
	DKRUNDEPENDS(${name}) # strip everything from the file except if() else() elseif() endif() and DKDEPEND() before sorting.
	# else()
	#	list(FIND dkdepend_list "${name}" index)
	#	if(${index} GREATER -1)
	#		return() #library is already in the list
	#	endif()
	#	DKRUNDEPENDS(${name}) # strip everything from the file except if() else() elseif() endif() and DKDEPEND() before sorting.
	# endif()
	
endfunction()
AliasFunctions("DKDEPEND")


# Remove a library or plugin from the dependency list
function(DKUNDEPEND name)

	## Only allow DKUNDEPEND command from these filters	
	if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKCMAKE} AND NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKPROJECT}) # /DKCMake or /App directory only
		DKERROR("\n! WARNING !\n DKUNDEPEND() Can only be used from the Disabled.cmake file. This is to avoid having disabled libraries hideing everywhere.\n")
	endif()
	DKINFO("DISABLING ${ARGV}")
	DKSET(dkdepend_disable_list ${dkdepend_disable_list} "${ARGV}")
	if(${ARGC} GREATER 1)
		dk_removeTarget(${name} ${ARGV1})
	endif()
endfunction()


### DKRUNDEPENDS() will strip everything from the library's DKMAKE.cmake file except DKDEPEND() commands AND conditionals.
### Conditionals such as if(), else(), elseif(), endif(), return() will remain included during the sorting process. 
### WARNING: BE CAREFULL WRITING NEW VARIABLES TO USE WITH CONDITIONALS, AS THEY MIGHT BE IGNORED 
##########################
function(DKRUNDEPENDS name)
	DEBUG_LINE()
	dk_getPathToPlugin(${name} plugin_path)
	if(NOT plugin_path)
		DKERROR("DKRUNDEPENDS() ${name} plugin not found")
		return()
	endif()
	#DKINFO("FOUND ${name} DK makefile at ${plugin_path}")
	
	file(STRINGS ${plugin_path}/DKMAKE.cmake lines)
	unset(disable_script)
	unset(depends_script)
	unset(index)
	
	set(KEEPLINE 0)
	foreach(line ${lines})
		string(FIND "${line}" "if(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		string(FIND "${line}" "IF(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		## elseif(
		##NOTE: The 'if(' search commands take care of elseif() and endif() since 'if' is already in those words 
		
		string(FIND "${line}" "else(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		string(FIND "${line}" "ELSE(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		## endif(
		##NOTE: The 'if(' search commands take care of elseif() and endif() since 'if' is already in those words 
		
		string(FIND "${line}" "return(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		string(FIND "${line}" "RETURN(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		string(FIND "${line}" "DKDISABLE(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		#string(FIND "${line}" "SET(" index)
		#if(${index} GREATER -1)
		#	set(KEEPLINE 1)
		#endif()
		
		#string(FIND "${line}" "DKSET(" index) # taken care of by SET( sytax above
		#if(${index} GREATER -1)
		#	set(KEEPLINE 1)
		#endif()
		
		if(KEEPLINE)
			set(disable_script "${disable_script}${line}\n")
		endif()
		
		# FIXME: we need to get a proper count of openeing (  before we can determine that we have actually reached the closing )
		string(FIND "${line}" ")" indexB) 
		if(${indexB} GREATER -1)
			set(KEEPLINE 0)
		endif()
	endforeach()
	
	set(KEEPLINE 0)
	foreach(line ${lines})
		string(FIND "${line}" "if(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		string(FIND "${line}" "IF(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		## elseif(
		##NOTE: The 'if(' search commands take care of elseif() and endif() since 'if' is already in those words 
		
		string(FIND "${line}" "else(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		string(FIND "${line}" "ELSE(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		## endif(
		##NOTE: The 'if(' search commands take care of elseif() and endif() since 'if' is already in those words 
		
		string(FIND "${line}" "return(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		string(FIND "${line}" "RETURN(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		string(FIND "${line}" "DKENABLE(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		string(FIND "${line}" "DKDISABLE(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()	
		
		string(FIND "${line}" "DKDEPEND(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		string(FIND "${line}" "DKSET(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		string(FIND "${line}" "message(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		string(FIND "${line}" "DKASSERT(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		string(FIND "${line}" "DKERROR(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		string(FIND "${line}" "DKWARN(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		string(FIND "${line}" "DKINFO(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		string(FIND "${line}" "DKDEBUG(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()

		string(FIND "${line}" "DKVERBOSE(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		string(FIND "${line}" "DKTRACE(" index)
		if(${index} GREATER -1)
			set(KEEPLINE 1)
		endif()
		
		if(KEEPLINE)
			set(depends_script "${depends_script}${line}\n")
		endif()
		
		# FIXME: we need to get a proper count of openeing (  before we can determine that we have actually reached the closing )
		string(FIND "${line}" ")" indexB) 
		if(${indexB} GREATER -1)
			set(KEEPLINE 0)
		endif()
	endforeach()
	
	if(disable_script)
		file(WRITE ${plugin_path}/DISABLES.TMP "${disable_script}")
		INCLUDE(${plugin_path}/DISABLES.TMP)
		#CreateFunc("${disable_script}")   #cmake 3.18+
		DKREMOVE(${plugin_path}/DISABLES.TMP)
	endif()
	
	if(depends_script)
		if(${ARGC} GREATER 1)
			DKENABLE(${ARGV1})
		else()
			DKSET(${ARGV0}_all 1)
		endif()
		file(WRITE ${plugin_path}/DEPENDS.TMP "${depends_script}")
		INCLUDE(${plugin_path}/DEPENDS.TMP)
		#CreateFunc("${depends_script}")    #cmake 3.18+
		DKREMOVE(${plugin_path}/DEPENDS.TMP)
		if(${ARGC} GREATER 1)
			DKSET(${ARGV1} OFF)
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
	
	DKSET(dkdepend_list ${dkdepend_list} "${ARGV}")  #Add sublibrary to list
	#if(${ARGC} GREATER 1)
	#	DKSET(dkdepend_list ${dkdepend_list} "${name} ${ARGV1}")  #Add sublibrary to list
	#else()
	#	DKSET(dkdepend_list ${dkdepend_list} ${name})  #Add library to list
	#endif()	
	list(REMOVE_DUPLICATES dkdepend_list)
endfunction()


function(DKDEPEND_ALL)

	DKINFO("***** DKDEPEND_ALL() *****")
	set(DEPENDALL_FILE "")
	
	if(IS_DIRECTORY ${DKIMPORTS})
		file(GLOB allfiles RELATIVE "${DKIMPORTS}/" "${DKIMPORTS}/*")
		foreach(each_file ${allfiles})
			if(EXISTS ${DKIMPORTS}/${each_file}/DKMAKE.cmake)
				#DKSET(DEPENDALL_FILE ${DEPENDALL_FILE} "DKDEPEND(${each_file})\n")
				set(DEPENDALL_FILE ${DEPENDALL_FILE} "DKDEPEND(${each_file})\n")
			endif()
		endforeach()
    endif()
	
	## Find all DKPlugins Folders from digitalknob root
	file(GLOB children RELATIVE ${DIGITALKNOB}/ ${DIGITALKNOB}/*)
  	foreach(child ${children})
		if(EXISTS ${DIGITALKNOB}/${child}/DKPlugins)
			file(GLOB plugins RELATIVE ${DIGITALKNOB}/${child}/DKPlugins/ ${DIGITALKNOB}/${child}/DKPlugins/*)
			foreach(plugin ${plugins})
				if(EXISTS ${DIGITALKNOB}/${child}/DKPlugins/${plugin}/DKMAKE.cmake)
					if(NOT ${plugin} STREQUAL "_DKIMPORT")
						set(DEPENDALL_FILE ${DEPENDALL_FILE} "DKDEPEND(${plugin})\n")
					endif()
				endif()
			endforeach()
		endif()
  	endforeach()
	
	#To exclude libraries, use DKDISABLE(lib) in your app DKMAKE.cmake file or in Disabled.cmake
	string (REPLACE ";" "" DEPENDALL_FILE "${DEPENDALL_FILE}")
	file(WRITE ${DKPROJECT}/DEPEND_ALL.txt "${DEPENDALL_FILE}")
	unset(DEPENDALL_FILE)
	INCLUDE(${DKPROJECT}/DEPEND_ALL.txt)
endfunction()


function (dkFileReplace filePath find replace)
	file(READ ${filePath} fileString)
	string(FIND "${fileString}" "${find}" index)
	if(${index} GREATER -1)
		string(REPLACE "${find}" "${replace}" fileString "${fileString}")
		file(WRITE ${filePath} "${fileString}")
	else()
		DKINFO("WARNING: cannot find \"${find}\"  in  (${filePath})")
	endif()
endfunction()


function(DKUPDATE_ANDROID_NAME name)
	string(TOLOWER ${name} name)
	if(ANDROID)
		## update all files and folders recursivley
		file(GLOB_RECURSE allfiles LIST_DIRECTORIES true RELATIVE "${DKPROJECT}/${OS}/" "${DKPROJECT}/${OS}/*")
		#DKINFO("\n Getting a list of files in ${DKPROJECT}/${OS} \n")
		list(REVERSE allfiles)
		foreach(each_file ${allfiles})
			##DKINFO("#####  each_file = ${each_file}")
			set(filepath "${DKPROJECT}/${OS}/${each_file}")
			##DKINFO("### each_file = ${each_file}")
			
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
					DKINFO("Replacing 'dkapp' with '${name}' in ${filepath}")
					string(REPLACE "dkapp" "${name}" filestring "${filestring}")
					file(WRITE ${filepath} "${filestring}")
				endif()
			endif()
			
			get_filename_component(fname ${each_file} NAME)
			string(FIND "${fname}" "dkapp" indexB)
			if(${indexB} GREATER -1)
				set(new_name ${each_file})
				string(REPLACE "dkapp" "${name}" new_name "${new_name}")
				DKINFO("Renaming ${each_file} to ${new_name}")
				DKRENAME(${DKPROJECT}/${OS}/${each_file} ${DKPROJECT}/${OS}/${new_name} true)
			endif()
		endforeach()
	endif()
endfunction()


function(DKUPDATE_INFO_PLIST name)

	if(MAC)
		## FIXME
		DKINFO("Updating MAC info.plist . . .")
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
		DKINFO("Updating IOS Info.plist . . .")
		DKINFO("CHECKING FOR... ${DKPROJECT}/${OS}/${DEBUG_DIR}/${name}.app/Info.plist")
		if(EXISTS ${DKPROJECT}/${OS}/${DEBUG_DIR}/${name}.app/Info.plist)
			DKINFO("Updating IOS Debug Info.plist . . .")
			file(READ ${DKPROJECT}/${OS}/${DEBUG_DIR}/${name}.app/Info.plist plist)
			string(REPLACE "<dict>" "<dict>\n<key>Icon files</key>\n<array>\n<string>Icon.png</string>\n<string>Icon@2x.png</string>\n<string>Icon-72.png</string>\n<string>Icon-Small-50.png</string>\n<string>Icon-Small.png</string>\n<string>Icon-Small@2x.png</string>\n</array>\n" plist ${plist})
			file(WRITE "${plist}" ${DKPROJECT}/${OS}/${DEBUG_DIR}/${name}.app/Info.plist)
		endif()
	endif()
endfunction()

function(DKBUILD_LOG entry)

	#DKSET(DKBUILD_LOG_FILE "${DKBUILD_LOG_FILE}${entry}\n")
	DKINFO("	${entry}")
	file(APPEND ${DKPROJECT}/${OS}/DKBUILD.log "${entry}\n")
endfunction()

function(ADD_SOURCE regex)

	DKSET(SRC_INCLUDE ${SRC_INCLUDE} ${ARGV})
endfunction()

function(REMOVE_SOURCE regex)

	DKSET(SRC_EXCLUDE ${SRC_EXCLUDE} ${ARGV})
endfunction()

# Function to wrap a given string into multiple lines at the given column position.
# Parameters:
#   VARIABLE    - The name of the CMake variable holding the string.
#   AT_COLUMN   - The column position at which string will be wrapped.
function(WRAP_STRING)

	set(oneValueArgs VARIABLE AT_COLUMN)
	cmake_parse_arguments(WRAP_STRING "${options}" "${oneValueArgs}" "" ${ARGN})
    string(LENGTH ${${WRAP_STRING_VARIABLE}} stringLength)
    math(EXPR offset "0")
    while(stringLength GREATER 0)
        if(stringLength GREATER ${WRAP_STRING_AT_COLUMN})
            math(EXPR length "${WRAP_STRING_AT_COLUMN}")
        else()
            math(EXPR length "${stringLength}")
        endif()
        string(SUBSTRING ${${WRAP_STRING_VARIABLE}} ${offset} ${length} line)
        set(lines "${lines}\n${line}")
        math(EXPR stringLength "${stringLength} - ${length}")
        math(EXPR offset "${offset} + ${length}")
    endwhile()
    set(${WRAP_STRING_VARIABLE} "${lines}" PARENT_SCOPE)
endfunction()



## https://gist.github.com/sivachandran/3a0de157dccef822a230#file-bin2h-cmake
# Function to embed contents of a file as byte array in C/C++ header file(.h). The header file
# will contain a byte array and integer variable holding the size of the array.
# Parameters
#   SOURCE_FILE     - The path of source file whose contents will be embedded in the header file.
#   VARIABLE_NAME   - The name of the variable for the byte array. The string "_SIZE" will be append
#                     to this name and will be used a variable name for size variable.
#   HEADER_FILE     - The path of header file.
#   APPEND          - If specified appends to the header file instead of overwriting it
#   NULL_TERMINATE  - If specified a null byte(zero) will be append to the byte array. This will be
#                     useful if the source file is a text file and we want to use the file contents
#                     as string. But the size variable holds size of the byte array without this
#                     null byte.
# Usage:
#   bin2h(SOURCE_FILE "Logo.png" HEADER_FILE "Logo.h" VARIABLE_NAME "LOGO_PNG")
function(BIN2H)

    set(options APPEND NULL_TERMINATE)
    set(oneValueArgs SOURCE_FILE VARIABLE_NAME HEADER_FILE)
    cmake_parse_arguments(BIN2H "${options}" "${oneValueArgs}" "" ${ARGN})
    # reads source file contents as hex string
    file(READ ${BIN2H_SOURCE_FILE} hexString HEX)
    string(LENGTH ${hexString} hexStringLength)
    # appends null byte if asked
    if(BIN2H_NULL_TERMINATE)
        set(hexString "${hexString}00")
    endif()
    # wraps the hex string into multiple lines at column 32(i.e. 16 bytes per line)
    ##wrap_string(VARIABLE hexString AT_COLUMN 32)
    math(EXPR arraySize "${hexStringLength} / 2")
    # adds '0x' prefix and comma suffix before and after every byte respectively
    ##string(REGEX REPLACE "([0-9a-f][0-9a-f])" "\\1" arrayValues ${hexString})
    # removes trailing comma
    ##string(REGEX REPLACE ", $" "" arrayValues ${arrayValues})
    # converts the variable name into proper C identifier
    string(MAKE_C_IDENTIFIER "${BIN2H_VARIABLE_NAME}" BIN2H_VARIABLE_NAME)
    string(TOUPPER "${BIN2H_VARIABLE_NAME}" BIN2H_VARIABLE_NAME)
    # declares byte array and the length variables
    set(arrayDefinition "std::string ${BIN2H_VARIABLE_NAME} = \"${hexString}\";")
    set(arraySizeDefinition "size_t ${BIN2H_VARIABLE_NAME}_SIZE = ${arraySize};")
    set(declarations "${arrayDefinition}\n\n${arraySizeDefinition}\n\n")
    if(BIN2H_APPEND)
        file(APPEND ${BIN2H_HEADER_FILE} "${declarations}")
    else()
        file(WRITE ${BIN2H_HEADER_FILE} "${declarations}")
    endif()
endfunction()

# https://cmake.org/cmake/help/latest/manual/cmake-variables.7.html
function(dk_printSettings)

	DKBUILD_LOG("#################  HOST SYSTEM VARIABLES  ################")
	DKBUILD_LOG("CMAKE_COMMAND:                 ${CMAKE_COMMAND}")
	DKBUILD_LOG("CMAKE_EXE:                     ${CMAKE_EXE}")
	DKBUILD_LOG("CMAKE_VERSION:                 ${CMAKE_VERSION}")
	DKBUILD_LOG("CMAKE_HOST_SYSTEM_NAME:        ${CMAKE_HOST_SYSTEM_NAME}")
	DKBUILD_LOG("CMAKE_HOST_SYSTEM_VERSION:     ${CMAKE_HOST_SYSTEM_VERSION}")
	DKBUILD_LOG("CMAKE_HOST_SYSTEM_PROCESSOR:   ${CMAKE_HOST_SYSTEM_PROCESSOR}")
	DKBUILD_LOG("CMAKE_SYSTEM_NAME:             ${CMAKE_SYSTEM_NAME}")
	DKBUILD_LOG("CMAKE_LIBRARY_ARCHITECTURE:    ${CMAKE_LIBRARY_ARCHITECTURE}")
	DKBUILD_LOG("ENV(USERNAME):                 $ENV{USERNAME}")
	DKBUILD_LOG("ENV(USER):	    				$ENV{USER}")
	DKBUILD_LOG("DIGITALKNOB:                   ${DIGITALKNOB}")
	DKBUILD_LOG("3RDPARTY:                      ${3RDPARTY}")
	DKBUILD_LOG("DKPLUGINS:                     ${DKPLUGINS}")
	DKBUILD_LOG("\n")
	DKBUILD_LOG("#############  PROJECT VARIABLES  ############")
	DKBUILD_LOG("APP_NAME:                      ${APP_NAME}")            ### APP_NAME is set to the App folder name
	DKBUILD_LOG("DKPROJECT:                     ${DKPROJECT}")
	DKBUILD_LOG("CMAKE_BINARY_DIR:              ${CMAKE_BINARY_DIR}")
	if(CMAKE_ARCHIVE_OUTPUT_DIRECTORY)
		DKBUILD_LOG("CMAKE_ARCHIVE_OUTPUT_DIRECTORY = ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}")
	endif()
	if(CMAKE_LIBRARY_OUTPUT_DIRECTORY)
		DKBUILD_LOG("CMAKE_LIBRARY_OUTPUT_DIRECTORY = ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
	endif()
	if(CMAKE_RUNTIME_OUTPUT_DIRECTORY)
		DKBUILD_LOG("CMAKE_RUNTIME_OUTPUT_DIRECTORY = ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")
	endif()
	DKBUILD_LOG("DEBUG_DIR:                     ${DEBUG_DIR}")
	DKBUILD_LOG("RELEASE_DIR:                   ${RELEASE_DIR}")
	DKBUILD_LOG("CMAKE_GENERATOR:               ${CMAKE_GENERATOR}")
	DKBUILD_LOG("VS_STARTUP_PROJECT:            ${VS_STARTUP_PROJECT}") 
	DKBUILD_LOG("CMAKE_C_COMPILER:              ${CMAKE_C_COMPILER}")
	if(CMAKE_C_STANDARD)
		DKBUILD_LOG("CMAKE_C_STANDARD:              ${CMAKE_C_STANDARD}")
	endif()
	if(CMAKE_C_STANDARD_REQUIRED)
		DKBUILD_LOG("CMAKE_C_STANDARD_REQUIRED:     ${CMAKE_C_STANDARD_REQUIRED}")
	endif()
	if(CMAKE_C_EXTENSIONS)
		DKBUILD_LOG("CMAKE_C_EXTENSIONS:            ${CMAKE_C_EXTENSIONS}")
	endif()
	DKBUILD_LOG("CMAKE_C_FLAGS:                 ${CMAKE_C_FLAGS}")
	DKBUILD_LOG("CMAKE_C_FLAGS_DEBUG:           ${CMAKE_C_FLAGS_DEBUG}")
	DKBUILD_LOG("CMAKE_C_FLAGS_RELEASE:         ${CMAKE_C_FLAGS_RELEASE}")
	DKBUILD_LOG("CMAKE_CXX_COMPILER:            ${CMAKE_CXX_COMPILER}")
	if(CMAKE_CXX_STANDARD)
		DKBUILD_LOG("CMAKE_CXX_STANDARD:            ${CMAKE_CXX_STANDARD}")
	endif()
	if(CMAKE_CXX_STANDARD_REQUIRED)
		DKBUILD_LOG("CMAKE_CXX_STANDARD_REQUIRED:   ${CMAKE_CXX_STANDARD_REQUIRED}")
	endif()
	if(CMAKE_CXX_EXTENSIONS)
		DKBUILD_LOG("CMAKE_CXX_EXTENSIONS :         ${CMAKE_CXX_EXTENSIONS}")
	endif()
	DKBUILD_LOG("CMAKE_CXX_FLAGS:               ${CMAKE_CXX_FLAGS}")
	DKBUILD_LOG("CMAKE_CXX_FLAGS_DEBUG:         ${CMAKE_CXX_FLAGS_DEBUG}")
	DKBUILD_LOG("CMAKE_CXX_FLAGS_RELEASE:       ${CMAKE_CXX_FLAGS_RELEASE}")
	DKBUILD_LOG("OS:                            ${OS}")
	DKBUILD_LOG("DEBUG:                         ${DEBUG}")
	DKBUILD_LOG("RELEASE:                       ${RELEASE}")
	if(BUILD)
		DKBUILD_LOG("BUILD:                         ${BUILD}")
	endif()
	if(REBUILD)
		DKBUILD_LOG("REBUILD:                       ${REBUILD}")
	endif()
	if(REBUILDALL)
		DKBUILD_LOG("REBUILDALL:                    ${REBUILDALL}")
	endif()
	if(DKCEF)
		DKBUILD_LOG("DKCEF:                         ${DKCEF}")
	endif()
	if(WIN)
		DKBUILD_LOG("WIN:                           ${WIN}")
	endif()	
	if(WIN_32)
		DKBUILD_LOG("WIN_32:                        ${WIN_32}")
	endif()
	if(WIN_64)
		DKBUILD_LOG("WIN_64:                        ${WIN_64}")
	endif()
	if(MAC)
		DKBUILD_LOG("MAC:                           ${MAC}")
	endif()
	if(MAC_32)
		DKBUILD_LOG("MAC_32:                        ${MAC_32}")
	endif()
	if(MAC_64)
		DKBUILD_LOG("MAC_64:                        ${MAC_64}")
	endif()
	if(IOS)
		DKBUILD_LOG("IOS:                           ${IOS}")
	endif()
	if(IOS_32)
		DKBUILD_LOG("IOS_32:                        ${IOS_32}")
	endif()
	if(IOS_64)
		DKBUILD_LOG("IOS_64:                        ${IOS_64}")
	endif()
	if(IOSSIM)
		DKBUILD_LOG("IOSSIM:                        ${IOSSIM}")
	endif()
	if(IOSSIM_32)
		DKBUILD_LOG("IOSSIM_32:                     ${IOSSIM_32}")
	endif()
	if(IOSSIM_64)
		DKBUILD_LOG("IOSSIM_64:                     ${IOSSIM_64}")
	endif()
	if(LINUX)
		DKBUILD_LOG("LINUX:                         ${LINUX}")
	endif()
	if(LINUX_32)
		DKBUILD_LOG("LINUX_32:                      ${LINUX_32}")
	endif()
	if(LINUX_64)
		DKBUILD_LOG("LINUX_64:                      ${LINUX_64}")
	endif()
	if(ANDROID)
		DKBUILD_LOG("ANDROID:                       ${ANDROID}")
	endif()
	if(ANDROID_32)
		DKBUILD_LOG("ANDROID_32:                    ${ANDROID_32}")
	endif()
	if(ANDROID_64)
		DKBUILD_LOG("ANDROID_64:                    ${ANDROID_64}")
	endif()
	if(RASPBERRY)
		DKBUILD_LOG("RASPBERRY:                     ${RASPBERRY}")
	endif()
	if(RASPBERRY_32)
		DKBUILD_LOG("RASPBERRY_32:                  ${RASPBERRY_32}")
	endif()
	if(RASPBERRY_64)
		DKBUILD_LOG("RASPBERRY_64:                  ${RASPBERRY_64}")
	endif()
	DKBUILD_LOG("\n") 
endfunction()

function(dk_addTarget name target)

	DKINFO("dk_addTarget( ${ARGV} )")
	if(${name}_targets_OFF)
		list(REMOVE_ITEM ${name}_targets_OFF ${target})
	endif()
	if(${name}_targets)
		DKSET(${name}_targets ${${name}_targets} ${target})
	else()
		DKSET(${name}_targets ${target})
	endif()
	if(${name}_all)
		DKSET(${name}_${target} 1)
		# DKSET(${name}::${target} 1) # TESTME
	endif()
endfunction()

function(dk_removeTarget name target)

	DKINFO("dk_removeTarget( ${ARGV} )")
	if(${name}_targets)
		list(REMOVE_ITEM ${name}_targets ${target})
	endif()
	if(${name}_targets_OFF)
		DKSET(${name}_targets_OFF ${${name}_targets_OFF} ${target})
	else()
		DKSET(${name}_targets_OFF ${target})
	endif()
	DKSET(${name}_${target} 0)
	DKUNSET(${name}_${target})
	#DKUNSET(${name}::${target}) # TESTME
endfunction()


# TODO
# We can scan each plugin and attempt to create it's variable and infomation manually here
function(dk_createSmartObject object)

	DKINFO("dk_createSmartObject(${object})")
	# We require something that can resolve to a full, valid path containing a DKMAKE.cmake file 
endfunction()

# A simple, quick and easy logger
function(log args)
	DKINFO("${ARGV}")
	set(output " ")
	foreach(arg ${ARGV})
		if(DEFINED ${arg})
			set(output "${output} ${arg}=${${dmpvar}} ")
		else()
			set(output "${output} ${arg}")
		endif()
			DKINFO("${output}")
	endforeach()
	Wait()
endfunction()


function(dk_RemoveSubstring removethis fromthis result)
	foreach(item ${fromthis})
		string(REPLACE ${removethis} "" item ${item})
		list(APPEND rtn ${item})
	endforeach()
	#string(REPLACE "  " " " rtn "${rtn}") #replace doube spaces with single space
	set(${result} ${rtn} PARENT_SCOPE) #return result
endfunction()


function(dk_FindTarget target result_path result_type)
	## search up to 4 levels deep
	file(GLOB children RELATIVE ${DIGITALKNOB}/ 
		${DIGITALKNOB}/${target}/DKMAKE.cmake 
		${DIGITALKNOB}/**/${target}/DKMAKE.cmake 
		${DIGITALKNOB}/**/**/${target}/DKMAKE.cmake 
		${DIGITALKNOB}/**/**/**/${target}/DKMAKE.cmake
		${DIGITALKNOB}/**/**/**/**/${target}/DKMAKE.cmake)
	foreach(child ${children})
		DKINFO("FOUND: ${DIGITALKNOB}/${child}")
		string(REPLACE "/DKMAKE.cmake" "" path ${DIGITALKNOB}/${child})
		set(${result_path} ${path} PARENT_SCOPE)
		
		file(STRINGS ${path}/DKMAKE.cmake dkmake_string)
		string(FIND "${dkmake_string}" "DKAPP" index)
		if(${index} GREATER -1)
			set(${result_type} APP PARENT_SCOPE) 
		else()
			set(${result_type} LIBRARY PARENT_SCOPE) #LIBRARY is default, we need to label executables to detect them
		endif()
		return() #return the found occurance
	endforeach()
endfunction()


macro(set_readonly VAR)                      # set_readonly(var value)
	set("${VAR}" "${ARGN}")                  # Set the variable itself
	set("_${VAR}_readonly_val" "${ARGN}")    # Store the variable's value for restore it upon modifications.
	variable_watch("${VAR}" readonly_guard)  # Register a watcher for a variable
endmacro()

macro(readonly_guard VAR access value current_list_file stack)   # Watcher for readonly property.
	if ("${access}" STREQUAL "MODIFIED_ACCESS")
		DKWARN("'${VAR}' is READONLY")
		set(${VAR} "${_${VAR}_readonly_val}")                    # Restore a value of the variable to the initial one.
	endif()
endmacro()

function(dk_prependFile path string)
	file(READ "${path}" file_data)
	file(write "${pah}" "${string}\n${filedata}")
endfunction()


function(dk_addRegistryKey key value data)
if(WIN_HOST)
	string(REPLACE "/" "\\" key   ${key})
	string(REPLACE "/" "\\" value ${value})
	string(REPLACE "/" "\\" data  ${data})
	execute_process(COMMAND reg add "${key}" /v "${value}" /t REG_SZ /d "${data}" /f /reg:64 OUTPUT_VARIABLE _output ERROR_VARIABLE _output RESULT_VARIABLE _failed)
	DKINFO("_output = ${_output}")
	DKINFO("_failed = ${_failed}")
endif()
endfunction()

function(DKGITCLONE url) #path)
# IS THE URL VALID           Example https://github.com/aquawicket/DigitalKnob/archive/01c17f6a9cd66068f7890ea887ab3b9a673f0434.zip)
	# must contain https://github.com/
	#split into list converting / to divider ;
	string(REPLACE "/" ";" url_list ${url})
	#foreach(item ${url_list})
	#	DKDEBUG("item = ${item}")
	#endforeach()
	
	list(LENGTH url_list count)
	#DKDEBUG("url_list is ${count}")
	if(${count} LESS 5)
		DKERROR("url_list doesn't contain enough elements to have a 'orginization/library'")
		return()
	endif()	
	
	if(${ARGC} GREATER 1)
		if(NOT "${ARGV1}" STREQUAL "PATCH")
			set(version ${ARGV1})
		endif()
	endif()
	
	if(${ARGC} GREATER 2)
		if(NOT "${ARGV2}" STREQUAL "PATCH")
			set(version ${ARGV2})
		endif()
	endif()
	
	if(NOT Lib)
		string(FIND ${url} "github.com" result)
		if(${result} EQUAL -1)
			string(FIND ${url} "gitlab.com" result)
			if(${result} EQUAL -1)
				DKERROR("The url does not contain 'github.com' OR 'gitlab.com'")
				return()
			endif()
		endif()
	
		list(GET url_list 3 org)
		#DKDEBUG("org = ${org}")
	
		list(GET url_list 4 Lib)
		#DKDEBUG("Lib = ${Lib}")
		
		string(FIND ${Lib} ".git" index)
		if(${index} GREATER -1)
			string(SUBSTRING ${Lib} 0 ${index} Lib)
		endif()
	endif()
	
	string(TOLOWER ${Lib} Lib)
	#DKDEBUG("Lib = ${Lib}")
	
	math(EXPR last "${count}-1")  #OUTPUT_FORMAT DECIMAL)")  CMake 3.13+
	list(GET url_list ${last} url${last})
	
	string(FIND ${url${last}} ".git" index)
	if(${index} GREATER -1)
		if(NOT ID)
			string(SUBSTRING ${url${last}} 0 ${index} ID)
			string(TOLOWER ${ID} FOLDER)
			#DKDEBUG("$(FOLDER) = ${FOLDER}")
		endif()
	endif()
	
	## check current folder name
	if(NOT "${DKIMPORTS}/${FOLDER}" STREQUAL "${CMAKE_CURRENT_LIST_DIR}")
		DKERROR("The Imports folder is named inncorrectly. \n CURRENTLY: ${CMAKE_CURRENT_LIST_DIR} \n SHOULD BE: ${DKIMPORTS}/${FOLDER}")
		return()
	endif()
	
	############################################
	string(TOUPPER ${Lib} LIBVAR)
	if(NOT LIBVAR)
		DKINFO("$(LIBVAR) is invalid")
		return()
	endif()
	DKDEBUG("LIBVAR = ${LIBVAR}")
	
	DKSET(${LIBVAR}_FOLDER ${FOLDER})
	if(NOT ${LIBVAR}_FOLDER)
		DKINFO("${LIBVAR}_FOLDER is invalid")
		return()
	endif()
	DKDEBUG("${LIBVAR}_FOLDER = ${${LIBVAR}_FOLDER}")
	
	DKSET(${LIBVAR}_VERSION ${version})
	if(NOT ${LIBVAR}_VERSION)
		DKINFO("${LIBVAR}_VERSION is invalid")
		return()
	endif()
	DKDEBUG("${LIBVAR}_VERSION = ${${LIBVAR}_VERSION}")
	
	DKSET(${LIBVAR}_NAME ${FOLDER}-${${LIBVAR}_VERSION})
	if(NOT ${LIBVAR}_NAME)
		DKINFO("${LIBVAR}_NAME is invalid")
		return()
	endif()
	DKDEBUG("${LIBVAR}_NAME = ${${LIBVAR}_NAME}")
	
	DKSET(${LIBVAR} ${3RDPARTY}/${${LIBVAR}_NAME})
	if(NOT ${LIBVAR})
		DKINFO("${${LIBVAR}} is invalid")
		return()
	endif()
	DKDEBUG("${${LIBVAR}} = ${${LIBVAR}}")
	
	#############################################
	#DKSET(CURRENT_DIR ${${LIBVAR}})
	if(NOT EXISTS ${${LIBVAR}}/.git)
		if(EXISTS ${${LIBVAR}})
			DKREMOVE(${${LIBVAR}})
		endif()
		DKCOMMAND("git clone ${url} ${${LIBVAR}}")
	endif()
	DKSET(CURRENT_DIR ${${LIBVAR}})
	DKCOMMAND("git checkout -- .")
	if(${ARGC} GREATER 1)
		set(branch ${ARGV1})
		DKCOMMAND("git checkout ${branch}")
	else()
		DKCOMMAND("git checkout main")
		DKCOMMAND("git checkout master")
	endif()
	DKCOMMAND("git pull")
endfunction()



function(DKIMPORT url) #Lib #ID #Patch
# IS THE URL VALID           Example https://github.com/aquawicket/DigitalKnob/archive/01c17f6a9cd66068f7890ea887ab3b9a673f0434.zip)
	# must contain https://github.com/
	#split into list converting / to divider ;
	string(REPLACE "/" ";" url_list ${url})
	#foreach(item ${url_list})
	#	DKDEBUG("item = ${item}")
	#endforeach()

	list(LENGTH url_list count)
	#DKDEBUG("url_list is ${count}")
	if(${count} LESS 5)
		DKERROR("url_list doesn't contain enough elements to have a 'orginization/library'")
		return()
	endif()	
	
	if(${ARGC} GREATER 1)
		if(NOT "${ARGV1}" STREQUAL "PATCH")
			set(Lib ${ARGV1})
		endif()
	endif()
	
	if(${ARGC} GREATER 2)
		if(NOT "${ARGV2}" STREQUAL "PATCH")
			set(ID ${ARGV2})
		endif()
	endif()
	
	if(NOT Lib)
		string(FIND ${url} "github.com" result)
		if(${result} EQUAL -1)
			string(FIND ${url} "gitlab.com" result)
			if(${result} EQUAL -1)
				DKERROR("The url does not contain 'github.com' OR 'gitlab.com'")
				return()
			endif()
		endif()
	
		list(GET url_list 3 org)
		#DKDEBUG("org = ${org}")
	
		list(GET url_list 4 Lib)
		#DKDEBUG("Lib = ${Lib}")
	endif()
	
	string(TOUPPER ${Lib} LIB)
	DKSET(LIBVAR ${LIB})
	#DKDEBUG("LIBVAR = ${LIBVAR}")
	
	string(TOLOWER ${Lib} FOLDER)
	DKSET(${LIBVAR}_FOLDER ${FOLDER})
	#DKDEBUG("${LIBVAR}_FOLDER = ${FOLDER}")
	
	## check current folder name
	#DKDEBUG("CMAKE_CURRENT_LIST_DIR = ${CMAKE_CURRENT_LIST_DIR}")
	#DKDEBUG("\${DKIMPORTS}/\${FOLDER} = ${DKIMPORTS}/${FOLDER}")
	if(NOT "${DKIMPORTS}/${FOLDER}" STREQUAL "${CMAKE_CURRENT_LIST_DIR}")
		DKERROR("The Imports folder is named inncorrectly. \n CURRENTLY: ${CMAKE_CURRENT_LIST_DIR} \n SHOULD BE: ${DKIMPORTS}/${FOLDER}")
		return()
	endif()
	
	math(EXPR last "${count}-1")  #OUTPUT_FORMAT DECIMAL)")  CMake 3.13+
	list(GET url_list ${last} url${last})
	
	
	string(FIND ${url${last}} ".zip" index)
	if(${index} GREATER -1)
		if(NOT ID)
			string(SUBSTRING ${url${last}} 0 ${index} ID)
		endif()
		DKSET(${LIBVAR}_DL ${url})
	endif()
	
	string(FIND ${url${last}} ".tar.gz" index)
	if(${index} GREATER -1)
		if(NOT ID)
			string(SUBSTRING ${url${last}} 0 ${index} ID)
		endif()
		DKSET(${LIBVAR}_DL ${url})
	endif()
	
	string(FIND ${url${last}} ".js" index)
	if(${index} GREATER -1)
		if(NOT ID)
			string(SUBSTRING ${url${last}} 0 ${index} ID)
		endif()
		DKSET(${LIBVAR}_DL ${url})
	endif()

	
	if(NOT ${LIBVAR}_DL)
		string(FIND ${url} "github.com" result)
		if(${result} EQUAL -1)
			#string(FIND ${url} "gitlab.com" result)
			#if(${result} EQUAL -1)
				DKERROR("The url is not a 'github.com' address")
				return()
			#endif()
		endif()
		
		DKINFO("The url doesn't end in .zip or .tar.gz")
		DKINFO("We will try to get the master commit id from the page")
		DOWNLOAD(${url} ${DKDOWNLOAD}/TEMP/${FOLDER}.html)
		file(READ ${DKDOWNLOAD}/TEMP/${FOLDER}.html PAGE)
		#DKREMOVE(${DKDOWNLOAD}/TEMP/${FOLDER}.html)
		string(FIND "${PAGE}" "spoofed_commit_check" index)
		if(${index} EQUAL -1)
			DKERROR("The page doesn't contain a 'spoofed_commit_check' variable")
			return()
		endif()
		math(EXPR value "${index} + 21") #OUTPUT_FORMAT DECIMAL) # CMake 3.13+
		string(SUBSTRING "${PAGE}" ${value} 40 ID)
		set(ZIP ${ID}.zip)
		#string(SUBSTRING ${ZIP} 0 7 TAG)
		DKSET(${LIBVAR}_DL https://github.com/${org}/${Lib}/archive/${ZIP})
		#DKDEBUG("ID = ${ID}")
		
		## update DKMAKE.cmake file
		DKCOPY(${CMAKE_CURRENT_LIST_FILE} ${CMAKE_CURRENT_LIST_FILE}.BACKUP TRUE)
		file(READ ${CMAKE_CURRENT_LIST_FILE} DKMAKE_FILE)
		string(REPLACE "DKIMPORT(${url})" "#DKIMPORT(${url})\nDKIMPORT(${${LIBVAR}_DL})" DKMAKE_FILE ${DKMAKE_FILE})
		string(REPLACE "DKIMPORT(${url} PATCH)" "#DKIMPORT(${url} PATCH)\nDKIMPORT(${${LIBVAR}_DL} PATCH)" DKMAKE_FILE ${DKMAKE_FILE})
        file(WRITE ${CMAKE_CURRENT_LIST_FILE} ${DKMAKE_FILE})
	endif()
	
	if(NOT ${LIBVAR}_DL)
		DKERROR("The url is not a valid .zip or .tar.gz download from github.com and we could not get the master commit ID")
		return()
	endif()
		
	############################################
	DKSET(${LIBVAR}_VERSION ${ID})
	DKSET(${LIBVAR}_NAME ${FOLDER}-${${LIBVAR}_VERSION})
	DKSET(${LIBVAR} ${3RDPARTY}/${${LIBVAR}_NAME})
	
	if(${LIBVAR} AND ${LIBVAR}_VERSION AND ${LIBVAR}_NAME AND ${LIBVAR}_DL)
		DKDEBUG("${LIBVAR}_VERSION = ${${LIBVAR}_VERSION}") 
		DKDEBUG("${LIBVAR}_DL = ${${LIBVAR}_DL}")
		DKDEBUG("${LIBVAR}_NAME = ${${LIBVAR}_NAME}")
		DKDEBUG("${LIBVAR} = ${${LIBVAR}}") 
		DKDEBUG("DKINSTALL(${${LIBVAR}_DL} ${FOLDER} ${${LIBVAR}})")
		DKINSTALL(${${LIBVAR}_DL} ${FOLDER} ${${LIBVAR}} ${ARGN})
	else()
		DKERROR("One of the required LIBVAR variables vas not satisfied")
		return()
	endif()
endfunction()

function(dk_DownloadAll3rdParty)
	DKDEPEND_ALL() ## ADD any and all plugins here
	
	# Get a list of all /3rdParty/DKMAKE.cmake paths
	file(GLOB All3rdParty ${DKIMPORTS}/*)
	foreach(item ${All3rdParty})
		if(EXISTS ${item}/DKMAKE.cmake)
	
			DKINFO("item = ${item}")
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
		
				string(FIND "${line}" "DOWNLOAD(" index)
				if(${index} GREATER -1)
					set(KEEPLINE 1)
				endif()
				
				string(FIND "${line}" "DKINSTALL(" index)
				if(${index} GREATER -1)
					set(KEEPLINE 1)
				endif()
				
				string(FIND "${line}" "DKIMPORT(" index)
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
				DKREMOVE(${DKDOWNLOAD}/TEMP/dl_import.TMP)
			endif()

		endif()
	endforeach()
endfunction()

###################################################################
# dk_GetFileType( ${path} rtn-type )
#  
# Takes a path and checks the extension to return the file type.
#
#  ${path}: A string value of the path to identify
# rtn-type: returns a string representing the  type of file.
#           Possible results are ARCHIVE, EXECUTABLE, IMAGE, SCRIPT,
#           UNKNOWN, WEB, ...TODO
# Reference: https://en.wikipedia.org/wiki/List_of_file_formats
###################################################################
function(dk_GetFileType path rtn-type)
	dk_getExtension(${path} ext)
	if(NOT ext)
		DKERROR("The path does not contain an extension")
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
	return()
endfunction()

function(DKIMPORT2 url)
	DKDEBUG("DKIMPORT2(${ARGV})")
	DKDEBUG("     ARGC = ${ARGC}")
	DKDEBUG("     ARGN = ${ARGN}")
	DKDEBUG("     ARGV = ${ARGV}")	
	DKDEBUG("    ARGV0 = ${ARGV0}")
	DKDEBUG("    ARGV1 = ${ARGV1}")
	math(EXPR ARGC_LAST "${ARGC}-1") #OUTPUT_FORMAT DECIMAL) #CMake 3.13+
	DKDEBUG("ARGC_LAST = ${ARGC_LAST}")
	set(ARGV_LAST ${ARGV${ARGC_LAST}})
	DKDEBUG("ARGV_LAST = ${ARGV_LAST}")
	
	DKDEBUG("Is ${url} a file download link or a local path to a container?  archive, .zip, .tar.gz, .7z, .rar, folder, package, etc?")
	string(REPLACE "/" ";" url_list ${url})
	set(n -1)
	foreach(item ${url_list})
		math(EXPR n "${n}+1") #OUTPUT_FORMAT DECIMAL) #CMake 3.13+
		set(url${n} ${item})
		DKDEBUG("url${n} = ${url${n}}")
		set(url_end ${n})
	endforeach()
	list(LENGTH url_list url_length)
	DKDEBUG("url_length = ${url_length}")
	DKDEBUG("url_end = ${url_end}")
	DKDEBUG("url{url_end} = ${url${url_end}}")
	
	dk_GetFileType(${url} type)
	if(NOT ${type} STREQUAL ARCHIVE) 
	DKDEBUG("NO")
		DKDEBUG("Is the url a website we can determine a download file link from?")
			string(FIND ${url} "github.com" hasGithub)
			if(hasGithub)
				DKDEBUG("hasGithub is true")
			else()
				DKDEBUG("hasGithub is false")
			endif()
			#YES - github, gitlab, etc
				#determin the download link. and goto B ->
			#NO
				#DKERROR("Not a valid download link")
	endif()
	DKDEBUG("YES")
		DKDEBUG("Can the LIB_NAME be extracted from the url?")
			#YES
			#Do we have a LIB_NAME locally to compair it with?
				#YES - (directory and or arg2)
				#Do the LIB_NAME's match?
					#YES - #use the LIB_NAME and goto C ->
					#NO - DKERROR("LIB_NAME's do not match")
				#NO
				#use the extracted LIB_NAME and goto C ->
			#NO
			#Do we have a LIB_NAME locally 
				#YES - (directory and or arg2) - #use the local LIB_NAME and goto C ->
				#NO - DKERROR("cannot determine a LIB_NAME")
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
							#NO - DKERROR("Con not determin the version")
		#We have DL, NAME and VERSION
		#Goto DKINSTALL(DL, name, VERSION)
endfunction()



include(${DIGITALKNOB}/DK/DKCMake/Functions_Ext.cmake)

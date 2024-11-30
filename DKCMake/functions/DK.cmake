#!/usr/bin/cmake -P
CMAKE_MINIMUM_REQUIRED(VERSION 3.10)
include_guard()

### Print Version Info ###
message("")
set(DKSHELL "CMake")
set(DKSHELL_VERSION ${CMAKE_VERSION})
set(DKSHELL_PATH ${CMAKE_COMMAND})
string(ASCII 27 ESC)
message("${ESC}[46m ${ESC}[30m ${DKSHELL} Version ${DKSHELL_VERSION} - ${DKSHELL_PATH} ${ESC}[0m")
message("")


#set(ENABLE_dk_debugFunc 1 CACHE INTERNAL "")
cmake_policy(SET CMP0003 NEW) 	# https://cmake.org/cmake/help/latest/policy/CMP0003.html	cmake 2.6.0
cmake_policy(SET CMP0007 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0007.html	cmake 2.6.0
cmake_policy(SET CMP0011 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0011.html	cmake 2.6.3
cmake_policy(SET CMP0012 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0012.html	cmake 2.8.0
cmake_policy(SET CMP0054 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0054.html	cmake 3.1.0
cmake_policy(SET CMP0057 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0057.html	cmake 3.3.0
if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.21.0")
cmake_policy(SET CMP0126 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0126.html   cmake 3.21.0
endif()

# Note: Using DK() as the function name will cause DK/DKMAKE.cmake to fail in dk_load.cmake
#####################################################################
# DKINIT()
#
#
function(DKINIT)
	#dk_echo("DKINIT()")
	
	###### Get Privledges ahead of time ######
	if(CMAKE_HOST_UNIX)
		message("calling sudo at beginning of script . . .")
		execute_process(COMMAND sudo echo WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}) #ask for sudo password ahead of time
	endif()

	###### Initialize Language specifics ######
	dk_init()

	###### Reload Main Script with cmake ######
	# d_k_reloadWithCmake()
	
	############ Get DKCMAKE variables ############
	dk_DKCMAKE_VARS()
	#dk_echo("DKCMAKE_DIR = ${DKCMAKE_DIR}")
	#dk_echo("DKCMAKE_FUNCTIONS_DIR = ${DKCMAKE_FUNCTIONS_DIR}")
	
	############ Get DKHTTP variables ############
	dk_DKHTTP_VARS()
	#dk_echo("DKHTTP_DKCMAKE_FUNCTIONS_DIR = ${DKHTTP_DKCMAKE_FUNCTIONS_DIR}")

	############ Setup dk_callStack ############
	dk_setupCallstack()
	#d k_callStack()
	#:dk_callStackReturn
	
	############ Get DKSCRIPT variables ############
	dk_DKSCRIPT_VARS()
	
	############ Set Options ############
	#d k_setOptions()
	
	############ Set Variables ###########
	dk_setVariables()
	
	set(ENABLE_DKTEST 1 CACHE INTERNAL "")

	############ LOAD FUNCTION FILES ############
	include(${DKCMAKE_FUNCTIONS_DIR}/dk_load.cmake)
	dk_load(dk_dirname)
	dk_load(dk_basename)
	dk_load(${DKSCRIPT_PATH})
	#dk_load(__TIME__)
	dk_load(dk_createOsMacros)
	dk_load(__FILE__)
	dk_load(__LINE__)
	dk_load(__FUNCTION__)
	dk_load(__ARGC__)
	dk_load(__ARGV__)
	dk_load(__CALLER__)
	dk_load(dk_color)
	dk_load(dk_logo)
	dk_load(dk_watch)
	
#	dk_load(dk_messageBox)
#	variable_watch(CMAKE_GENERATOR dk_onVariableWatch)
#	variable_watch(CMAKE_SYSTEM_VERSION dk_onVariableWatch)
	
	###### DKTEST MODE ######
	if(ENABLE_DKTEST)
		if("${DKSCRIPT_DIR}" STREQUAL "${DKCMAKE_FUNCTIONS_DIR}")
			dk_echo("\n${bg_magenta}${white}###### DKTEST MODE ###### ${DKSCRIPT_NAME} ###### DKTEST MODE ######${clr}\n")
			include(${DKSCRIPT_PATH}) # make sure the correct DKTEST function is loaded
			DKTEST()
			dk_echo("\n${bg_magenta}${white}########################## END TEST ################################${clr}\n")
			dk_exit(0)
		endif()
	endif()
	
endfunction()

##################################################################################
# dk_variableWatch()
#
macro(dk_onVariableWatch variable access value current_list_file stack)
	if("${access}" STREQUAL "MODIFIED_ACCESS")
		#message("dk_variableWatch(${variable} ${access} ${value} ${current_list_file} ${stack})")
		dk_stacktrace()
		dk_messageBox("${variable} = ${value}")
	endif()
endmacro()

##################################################################################
# dk_echo()
#
function(dk_echo)
	message("${ARGV}")
endfunction()

##################################################################################
# dk_init()
#
function(dk_init)
	set(CMAKE_MESSAGE_LOG_LEVEL "TRACE")
	if(CMAKE_SCRIPT_MODE_FILE)
		dk_echo()
		dk_echo("########################################################")
		dk_echo("################# CMAKE SCRIPT MODE ####################")
		dk_echo("########################################################")
		dk_echo()
	endif()
endfunction()

#####################################################################
# dk_DKCMAKE_VARS()
#
function(dk_DKCMAKE_VARS)
	get_filename_component(DKCMAKE_DIR ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)
	set(DKCMAKE_DIR ${DKCMAKE_DIR} CACHE INTERNAL "")
	set(DKCMAKE_FUNCTIONS_DIR ${DKCMAKE_DIR}/functions CACHE INTERNAL "")
	set(DKCMAKE_FUNCTIONS_DIR_ ${DKCMAKE_FUNCTIONS_DIR}/ CACHE INTERNAL "")
endfunction(dk_DKCMAKE_VARS)

##################################################################################
# dk_DKHTTP_VARS()
#
function(dk_DKHTTP_VARS)
	set(DKHTTP_DIGITALKNOB_DIR			"https://raw.githubusercontent.com/aquawicket/DigitalKnob" CACHE INTERNAL "")
	set(DKHTTP_DKBRANCH_DIR				"${DKHTTP_DIGITALKNOB_DIR}/Development" CACHE INTERNAL "")
	set(DKHTTP_DKCMAKE_DIR				"${DKHTTP_DKBRANCH_DIR}/DKCMake" CACHE INTERNAL "")
	set(DKHTTP_DKCMAKE_FUNCTIONS_DIR	"${DKHTTP_DKCMAKE_DIR}/functions" CACHE INTERNAL "")
endfunction()

##################################################################################
# dk_onCallstack()
#
macro(dk_onCallstack variable access value current_list_file stack)
	#message("dk_onCallstack(${variable} ${access} ${value} ${current_list_file} ${stack})")
	if("${access}" STREQUAL "MODIFIED_ACCESS")
		if("${value}" STREQUAL "dk_set")
			return()
		endif()
		if("${value}" STREQUAL "dk_onCallstack")
			return()
		endif()
		set(this_stack "${variable} ${access} ${value} ${current_list_file} ${stack}")
		if("${this_stack}" STREQUAL "${prev_stack}")
			return()
		endif()
		dk_set(prev_stack "${variable} ${access} ${value} ${current_list_file} ${stack}")
		set(MAX_STACK_SIZE 99)
		set(CMAKE_STACK ${stack} CACHE INTERNAL "")
		list(LENGTH CMAKE_STACK CMAKE_STACK_SIZE)
			
		set(__FILE__ "${CMAKE_CURRENT_FUNCTION_LIST_FILE}" CACHE INTERNAL "")
		get_filename_component(__FILE__ "${__FILE__}" NAME)
		set(__LINE__ "${CMAKE_CURRENT_FUNCTION_LIST_LINE}" CACHE INTERNAL "")
		set(__FUNCTION__ "${CMAKE_CURRENT_FUNCTION}" CACHE INTERNAL "")
		dk_messageBox("${__FUNCTION__}")
		set(__ARGV__ "${ARGV}" CACHE INTERNAL "")
		string(TIMESTAMP __TIME__ "%M:%S:%f")
		string(SUBSTRING "${__TIME__}" 0 10 __TIME__)
		set(__TIME__ "${__TIME__}" CACHE INTERNAL "")
		
		###### CMAKE_SOURCE[] ######
		list(PREPEND CMAKE_TIME ${__TIME__})
		list(LENGTH CMAKE_TIME CMAKE_TIME_SIZE)
		if(${CMAKE_TIME_SIZE} GREATER ${MAX_STACK_SIZE})
			list(POP_BACK CMAKE_TIME)
		endif()
		set(CMAKE_TIME ${CMAKE_TIME} CACHE INTERNAL "")
		
		###### CMAKE_SOURCE[] ######
		list(PREPEND CMAKE_SOURCE ${__FILE__})
		list(LENGTH CMAKE_SOURCE CMAKE_SOURCE_SIZE)
		if(${CMAKE_SOURCE_SIZE} GREATER ${MAX_STACK_SIZE})
			list(POP_BACK CMAKE_SOURCE)
		endif()
		set(CMAKE_SOURCE ${CMAKE_SOURCE} CACHE INTERNAL "")
		
		###### CMAKE_LINENO[] ######
		list(PREPEND CMAKE_LINENO ${__LINE__})
		list(LENGTH CMAKE_LINENO CMAKE_LINENO_SIZE)
		if(${CMAKE_LINENO_SIZE} GREATER ${MAX_STACK_SIZE})
			list(POP_BACK CMAKE_LINENO)
		endif()
		set(CMAKE_LINENO ${CMAKE_LINENO} CACHE INTERNAL "")
	
		###### FUNCNAME ######
		list(PREPEND FUNCNAME ${__FUNCTION__})
		list(LENGTH FUNCNAME FUNCNAME_SIZE)
		if(${FUNCNAME_SIZE} GREATER ${MAX_STACK_SIZE})
			list(POP_BACK FUNCNAME)
		endif()
		set(FUNCNAME ${FUNCNAME} CACHE INTERNAL "")
	
		###### STACK_LEVEL ######
		list(PREPEND STACK_LEVEL ${CMAKE_STACK_SIZE})
		list(LENGTH STACK_LEVEL STACK_LEVEL_SIZE)
		if(${STACK_LEVEL_SIZE} GREATER ${MAX_STACK_SIZE})
			list(POP_BACK STACK_LEVEL)
		endif()
		set(STACK_LEVEL ${STACK_LEVEL} CACHE INTERNAL "")
		set(__LEVEL__ ${STACK_LEVEL_SIZE})
		
		unset(indent)
		set(i 4)
		while(${i} LESS ${__LEVEL__})
			set(indent "${indent}-")
			math(EXPR i "${i}+1")
		endwhile(${i} LESS ${__LEVEL__})
		set(indent "${indent}-> ")
		
		message("${indent}${__FUNCTION__}(${__ARGV__})")	
		#dk_echo("${cyan}${indent}${__TIME__}${__FILE__}:${__LINE__}   ${__FUNCTION__}(${__ARGV__})")
	endif()
endmacro()

##################################################################################
# dk_setupCallstack()
#
function(dk_setupCallstack)
	dk_echo("dk_setupCallstack()")
	
	#variable_watch(CMAKE_CURRENT_FUNCTION_LIST_LINE dk_onCallstack)
	#variable_watch(CMAKE_CURRENT_FUNCTION dk_onCallstack)
endfunction()

##################################################################################
# dk_DKSCRIPT_VARS()
#
function(dk_DKSCRIPT_VARS)
	###### DKSCRIPT_PATH ######
	set(DKSCRIPT_PATH "${CMAKE_PARENT_LIST_FILE}" CACHE INTERNAL "")
	if(NOT EXISTS "${DKSCRIPT_PATH}")
		set(DKSCRIPT_PATH "${CMAKE_CURRENT_LIST_FILE}" CACHE INTERNAL "")
	endif()
	if(NOT EXISTS "${DKSCRIPT_PATH}")
		message(FATAL_ERROR "DKSCRIPT_PATH:${DKSCRIPT_PATH} not found")
	endif()	
	###### DKSCRIPT_ARGS ######
	set(DKSCRIPT_ARGS ${ARGS} CACHE INTERNAL "")

	###### DKSCRIPT_DIR ######
	get_filename_component(DKSCRIPT_DIR ${DKSCRIPT_PATH} DIRECTORY)
	set(DKSCRIPT_DIR ${DKSCRIPT_DIR} CACHE INTERNAL "")
	if(NOT EXISTS ${DKSCRIPT_DIR})
		dk_fatal("DKSCRIPT_DIR not found!")
	endif()
	
	###### DKSCRIPT_NAME ######
	get_filename_component(DKSCRIPT_NAME ${DKSCRIPT_PATH} NAME)
	set(DKSCRIPT_NAME ${DKSCRIPT_NAME} CACHE INTERNAL "")
	
	###### DKSCRIPT_EXT ######
	get_filename_component(DKSCRIPT_EXT ${DKSCRIPT_PATH} LAST_EXT)
	set(DKSCRIPT_EXT ${DKSCRIPT_EXT} CACHE INTERNAL "")
endfunction()

##################################################################################
# dk_setVariables()
#
function(dk_setVariables)

	##### Set ProgramFiles_<> variables ######
	if(DEFINED ENV{WSL_DISTRO_NAME})
		set(WSL 1 CACHE INTERNAL "")
		dk_echo("CMake using WSL")
	endif()
	if(DEFINED "ENV{HOMEDRIVE}")
		# TODO
	endif()
	if(DEFINED "ENV{ProgramW6432}")
		file(TO_CMAKE_PATH "$ENV{ProgramW6432}" ProgramFiles)
		set(ProgramFiles "${ProgramFiles}" CACHE INTERNAL "")
	elseif(DEFINED "ENV{ProgramFiles}")
		file(TO_CMAKE_PATH "$ENV{ProgramFiles}" ProgramFiles)
		set(ProgramFiles "${ProgramFiles}" CACHE INTERNAL "")
	endif()
	#if(DEFINED "ENV{ProgramFiles\(x86\)}")
	#	file(TO_CMAKE_PATH "$ENV{ProgramFiles\(x86\)}" ProgramFiles_x86)
	#	dk_set(ProgramFiles_x86 "${ProgramFiles_x86}")
	#endif()
endfunction()


DKINIT()

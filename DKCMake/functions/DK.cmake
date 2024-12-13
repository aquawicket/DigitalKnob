#!/usr/bin/cmake -P
CMAKE_MINIMUM_REQUIRED(VERSION 3.10)
include_guard()

#set(ENABLE_dk_debugFunc 1 CACHE INTERNAL "")

### Print Version Info ###
message("")
set(DKSHELL "CMake")
set(DKSHELL_VERSION ${CMAKE_VERSION})
set(DKSHELL_PATH ${CMAKE_COMMAND})
string(ASCII 27 ESC)
message("${ESC}[46m ${ESC}[30m ${DKSHELL} Version ${DKSHELL_VERSION} - ${DKSHELL_PATH} ${ESC}[0m")
message("")


#set(ENABLE_dk_debugFunc 1 CACHE INTERNAL "")
cmake_policy(SET CMP0001 NEW) 	# https://cmake.org/cmake/help/latest/policy/CMP0001.html	cmake 2.6.0 - CMAKE_BACKWARDS_COMPATIBILITY should no longer be used.
cmake_policy(SET CMP0002 NEW) 	# https://cmake.org/cmake/help/latest/policy/CMP0002.html	cmake 2.6.0 - Logical target names must be globally unique.
cmake_policy(SET CMP0003 NEW) 	# https://cmake.org/cmake/help/latest/policy/CMP0003.html	cmake 2.6.0 - Libraries linked via full path no longer produce linker search paths.
cmake_policy(SET CMP0004 NEW) 	# https://cmake.org/cmake/help/latest/policy/CMP0004.html	cmake 2.6.0 - Libraries linked may not have leading or trailing whitespace.
cmake_policy(SET CMP0005 NEW) 	# https://cmake.org/cmake/help/latest/policy/CMP0005.html	cmake 2.6.0 - Preprocessor definition values are now escaped automatically.
cmake_policy(SET CMP0006 NEW) 	# https://cmake.org/cmake/help/latest/policy/CMP0006.html	cmake 2.6.0 - Installing MACOSX_BUNDLE targets requires a BUNDLE DESTINATION.
cmake_policy(SET CMP0007 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0007.html	cmake 2.6.0 - list command no longer ignores empty elements.
cmake_policy(SET CMP0008 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0008.html	cmake 2.6.1 - Libraries linked by full-path must have a valid library file name.
cmake_policy(SET CMP0009 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0009.html	cmake 2.6.2 - FILE GLOB_RECURSE calls should not follow symlinks by default.
cmake_policy(SET CMP0010 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0010.html	cmake 2.6.3 - Bad variable reference syntax is an error.
cmake_policy(SET CMP0011 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0011.html	cmake 2.6.3 - Included scripts do automatic cmake_policy() PUSH and POP.
cmake_policy(SET CMP0012 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0012.html	cmake 2.8.0 - if() recognizes numbers and boolean constants.
cmake_policy(SET CMP0013 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0013.html	cmake
cmake_policy(SET CMP0014 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0014.html	cmake
cmake_policy(SET CMP0015 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0015.html	cmake
cmake_policy(SET CMP0016 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0016.html	cmake
cmake_policy(SET CMP0017 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0017.html	cmake
cmake_policy(SET CMP0018 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0018.html	cmake
cmake_policy(SET CMP0019 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0019.html	cmake
cmake_policy(SET CMP0020 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0020.html	cmake
cmake_policy(SET CMP0021 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0021.html	cmake
cmake_policy(SET CMP0022 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0022.html	cmake
cmake_policy(SET CMP0023 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0023.html	cmake
cmake_policy(SET CMP0024 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0024.html	cmake
cmake_policy(SET CMP0025 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0025.html	cmake
cmake_policy(SET CMP0026 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0026.html	cmake
cmake_policy(SET CMP0027 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0027.html	cmake
cmake_policy(SET CMP0028 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0028.html	cmake
cmake_policy(SET CMP0029 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0029.html	cmake
cmake_policy(SET CMP0030 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0030.html	cmake
cmake_policy(SET CMP0031 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0031.html	cmake
cmake_policy(SET CMP0032 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0032.html	cmake
cmake_policy(SET CMP0033 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0033.html	cmake
cmake_policy(SET CMP0034 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0034.html	cmake
cmake_policy(SET CMP0035 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0035.html	cmake
cmake_policy(SET CMP0036 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0036.html	cmake
cmake_policy(SET CMP0037 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0037.html	cmake
cmake_policy(SET CMP0038 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0038.html	cmake
cmake_policy(SET CMP0039 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0039.html	cmake
cmake_policy(SET CMP0040 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0040.html	cmake
cmake_policy(SET CMP0041 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0041.html	cmake
cmake_policy(SET CMP0042 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0042.html	cmake
cmake_policy(SET CMP0043 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0043.html	cmake
cmake_policy(SET CMP0044 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0044.html	cmake
cmake_policy(SET CMP0045 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0045.html	cmake
cmake_policy(SET CMP0046 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0046.html	cmake
cmake_policy(SET CMP0047 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0047.html	cmake
cmake_policy(SET CMP0048 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0048.html	cmake
cmake_policy(SET CMP0049 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0049.html	cmake
cmake_policy(SET CMP0050 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0050.html	cmake
cmake_policy(SET CMP0051 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0051.html	cmake
cmake_policy(SET CMP0052 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0052.html	cmake
cmake_policy(SET CMP0053 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0053.html	cmake
cmake_policy(SET CMP0054 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0054.html	cmake 3.1.0 - Only interpret if() arguments as variables or keywords when unquoted.
cmake_policy(SET CMP0055 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0055.html	cmake
cmake_policy(SET CMP0056 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0056.html	cmake
cmake_policy(SET CMP0057 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0057.html	cmake 3.3.0 - Support new if() IN_LIST operator.
if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.21.0")
cmake_policy(SET CMP0121 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0121.html	cmake 3.21.0 - The list() command now detects invalid indices.
cmake_policy(SET CMP0126 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0126.html   cmake 3.21.0 - set(CACHE) command does not remove any normal variable of the same name
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

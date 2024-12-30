#!/usr/bin/cmake -P
CMAKE_MINIMUM_REQUIRED(VERSION 3.10)
include_guard()

if(NOT EXISTS "${DKSCRIPT_PATH}")
file(TO_CMAKE_PATH "$ENV{DKSCRIPT_PATH}" DKSCRIPT_PATH)
endif()
#set(ENABLE_dk_debugFunc 1 CACHE INTERNAL "")

### Print Version Info ###
message("")
set(DKSHELL "CMake")
set(DKSHELL_VERSION ${CMAKE_VERSION})
set(DKSHELL_PATH ${CMAKE_COMMAND})
string(ASCII 27 ESC)
message("${ESC}[46m ${ESC}[30m ${DKSHELL} Version ${DKSHELL_VERSION} ${ESC}[0m")
message("DKSHELL_PATH = ${DKSHELL_PATH}")
message("DKSCRIPT_PATH = ${DKSCRIPT_PATH}")
message("")

if(DKCMAKE_FUNCTIONS_DIR_)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR_ ${DKCMAKE_FUNCTIONS_DIR_} REALPATH)
	set(DKCMAKE_FUNCTIONS_DIR_ "${DKCMAKE_FUNCTIONS_DIR_}/")
	message("DKCMAKE_FUNCTIONS_DIR_ = ${DKCMAKE_FUNCTIONS_DIR_}")
	if(NOT EXISTS "${DKCMAKE_FUNCTIONS_DIR_}")
		message(FATAL_ERROR "DKCMAKE_FUNCTIONS_DIR_:${DKCMAKE_FUNCTIONS_DIR_} does not exist")
	endif()
endif()
	
message("CMAKE_GENERATOR = ${CMAKE_GENERATOR}")


############ dk_cmakePolicies ############
include("${CMAKE_CURRENT_LIST_DIR}/dk_cmakePolicies.cmake")
dk_cmakePolicies()

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
	
	include(${DKCMAKE_FUNCTIONS_DIR}/dk_load.cmake)
	dk_load("dk_fatal")
	
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
	#include(${DKCMAKE_FUNCTIONS_DIR}/dk_load.cmake)
	dk_load(dk_dirname)
	dk_load(dk_basename)
	if("${DKSCRIPT_EXT}" STREQUAL ".cmake")
		dk_load(${DKSCRIPT_PATH})
	endif()
	#dk_load(__TIME__)
	dk_load(__FILE__)
	dk_load(__LINE__)
	dk_load(__FUNCTION__)
	dk_load(__ARGC__)
	dk_load(__ARGV__)
	dk_load(__CALLER__)
	dk_load(dk_color)
	dk_load(dk_logo)
	dk_load(dk_watch)
	dk_load(dk_messageBox)
	
	###### DKTEST MODE ######
	if(ENABLE_DKTEST)
		#if("${DKSCRIPT_DIR}" STREQUAL "${DKCMAKE_FUNCTIONS_DIR}")
		string(FIND "${DKSCRIPT_DIR}" "${DKCMAKE_FUNCTIONS_DIR}" isChildOf)
		if(${isChildOf} GREATER -1)
			dk_echo("\n${bg_magenta}${white}###### DKTEST MODE ###### ${DKSCRIPT_NAME} ###### DKTEST MODE ######${clr}\n")
			include(${DKSCRIPT_PATH}) # make sure the correct DKTEST function is loaded
			DKTEST()
			dk_echo("\n${bg_magenta}${white}########################## END TEST ################################${clr}\n")
			dk_exit(0)
		endif()
	endif()
	
endfunction()


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
# dk_setupCallstack()
#
function(dk_setupCallstack)
	dk_echo("dk_setupCallstack()")
	
	dk_load("dk_onVariableWatch")
	#variable_watch(CMAKE_GENERATOR dk_onVariableWatch)
	#variable_watch(CMAKE_CURRENT_FUNCTION_LIST_LINE dk_onVariableWatch)
	#variable_watch(CMAKE_CURRENT_LIST_DIR dk_onVariableWatch)
	#variable_watch(CMAKE_CURRENT_FUNCTION dk_onCallstack)
	#variable_watch(CMAKE_GENERATOR dk_onVariableWatch)
	#variable_watch(CMAKE_SYSTEM_VERSION dk_onVariableWatch)
endfunction()


##################################################################################
# dk_DKSCRIPT_VARS()
#
function(dk_DKSCRIPT_VARS)
	###### DKSCRIPT_PATH ######
	if(NOT EXISTS "${DKSCRIPT_PATH}")
		set(DKSCRIPT_PATH "${CMAKE_PARENT_LIST_FILE}" CACHE INTERNAL "")
	endif()
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

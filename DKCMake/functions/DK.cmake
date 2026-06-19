#!/usr/bin/cmake -P

# DKINIT_cmake
CMAKE_MINIMUM_REQUIRED(VERSION 3.10)

###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	message("DK.cmake Test sucessful")
endfunction()


if((DEFINED DKINIT_cmake) AND (NOT "${DKINIT_cmake}" STREQUAL ""))
	return()
else()
	set(DKINIT_cmake "${CMAKE_CURRENT_LIST_FILE}" CACHE INTERNAL "" FORCE)
endif()








#####################################################################
# DKINIT()
# 	Note: Using DK() as the function name will cause DK/DKINSTALL.cmake to fail in dk_load.cmake
#
function(DKINIT)
	
	### Print Shell Version Info ###
	message("")
	set(DKSHELL "CMake")
	set(DKSHELL_VERSION "${CMAKE_VERSION}")
	set(DKSHELL_PATH "${CMAKE_COMMAND}")
	string(ASCII 27 ESC)
	set(ESC )
	message("${ESC}[46m ${ESC}[30m ${DKSHELL} Version ${DKSHELL_VERSION} ${ESC}[0m${ESC}[36m ${DKSHELL_PATH} ${ESC}[0m")
	message("")
	
	set(CMAKE_MESSAGE_LOG_LEVEL "TRACE")
	if(CMAKE_SCRIPT_MODE_FILE)
		message("")
		message("################# CMAKE SCRIPT MODE ####################")
		message("# ${CMAKE_SCRIPT_MODE_FILE}")
		message("")
	endif()

	###### CMAKE_ARGV - cmake command line args ######
	if(CMAKE_ARGC)
		unset(CMAKE_ARGV)
		math(EXPR CMAKE_ARGC_END "${CMAKE_ARGC}-1")
		foreach(n RANGE ${CMAKE_ARGC_END})
			list(APPEND CMAKE_ARGV ${CMAKE_ARGV${n}})
		endforeach()
	endif()
	### Print CMAKE_ARG? variables
	message("CMAKE_ARGC  = '${CMAKE_ARGC}'")
	message("CMAKE_ARGV  = '${CMAKE_ARGV}'")
	set(n 0)
	foreach(ARG ${CMAKE_ARGV})
		message("CMAKE_ARGV${n} = '${CMAKE_ARGV${n}}'")
		math(EXPR n "${n}+1")
	endforeach()
	
	############ dk_cmakePolicies ############
	include("${CMAKE_CURRENT_LIST_DIR}/dk_printArgData.cmake")
	include("${CMAKE_CURRENT_LIST_DIR}/dk_eval.cmake")
	include("${CMAKE_CURRENT_LIST_DIR}/dk_call.cmake")
	include("${CMAKE_CURRENT_LIST_DIR}/dk_source.cmake")
	include("${CMAKE_CURRENT_LIST_DIR}/dk_validateFunc.cmake")
	include("${CMAKE_CURRENT_LIST_DIR}/dk_color.cmake")
	dk_call( dk_cmakePolicies() )
	
	#include("${CMAKE_CURRENT_LIST_DIR}/dk_cacheEnvVariables.cmake")
	#dk_cacheEnvVariables()
	
	dk_call( dk_DKBRANCH_DIR() )
	
	DKCMAKE_DIR()
	DKCMAKE_FUNCTIONS_DIR()
	DKCMAKE_FUNCTIONS_DIR_()
	DKSCRIPT_PATH()
	DKSCRIPT_ARGS()
	DKSCRIPT_DIR()
	DKSCRIPT_FILE()
	DKSCRIPT_NAME()
	DKSCRIPT_EXT()
	DKHTTP_VARS()
	dk_setVariables()
	
	include("${DKCMAKE_FUNCTIONS_DIR_}/dk_load.cmake")
	#dk_load(dk_call)
	#include("${DKCMAKE_FUNCTIONS_DIR_}/dk_call.cmake")
	dk_load(dk_fatal)
	dk_load(dk_dirname)
	dk_load(dk_basename)
	if("${DKSCRIPT_EXT}" STREQUAL ".cmake")
		dk_load("${DKSCRIPT_PATH}")
	endif()
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
	dk_initVariableWatch()
	
	dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
	if(EXISTS "${DKSCRIPT_DIR}/dkconfig.txt")
		dk_load(dk_fileVariables)
		if(COMMAND dk_fileVariables)
			dk_fileVariables("${DKSCRIPT_DIR}/dkconfig.txt")
		endif()
	elseif(EXISTS "${DKBRANCH_DIR}/dkconfig.txt")
		dk_load(dk_fileVariables)
		if(COMMAND dk_fileVariables)
			dk_fileVariables("${DKBRANCH_DIR}/dkconfig.txt")
		endif()
	endif()
	
	dk_load("${DKCMAKE_DIR}/DKVariables.cmake")
	
	###### Initialize Import Variables ######
	######################################################################################################
	# If we run a DKINSTALL.cmake file, it needs be pushed to the CURRENT_PLUGIN environment variable list.
	# dk_depend normaly does this, but since it's the first file run, we can't really call dk_depend on 
	# itself. dk_envList(PLUGIN PUSH "${Plugin}") should take care of it.
	if(NOT CURRENT_PLUGIN)
		if("${DKSCRIPT_NAME}" STREQUAL "DKINSTALL")
			dk_load("dk_importVariables")
			dk_importVariables(IMPORT_PATH "${DKSCRIPT_DIR}")
			dk_load("dk_envList")
			dk_envList(PLUGIN PUSH "${PLUGIN}")
		endif()
	endif()

	if("${DKSCRIPT_EXT}" STREQUAL ".cmake")
		###### DKTEST() ######
		#set(ENABLE_DKTEST 1 CACHE INTERNAL "" FORCE)
		#if(ENABLE_DKTEST)
		dk_source(dk_fileIncludes)
		dk_fileIncludes("${DKSCRIPT_PATH}" "function(DKTEST)")
		message("dk_fileIncludes = ${dk_fileIncludes}")
		if(dk_fileIncludes)
			message("\n${bg_magenta}${white}###### DKTEST MODE ###### ${DKSCRIPT_FILE} ###### DKTEST MODE ######${clr}\n")
				
			include(${DKSCRIPT_PATH}) # make sure the correct DKTEST function is loaded
			DKTEST()
			message("\n${bg_magenta}${white}###### DKTEST END ####### ${DKSCRIPT_FILE} ###### DKTEST END #######${clr}\n")
			return()
		endif()
		#endif()
		
		###### DKSCRIPT_NAME() ######
		dk_source(dk_fileIncludes)
		dk_fileIncludes("${DKSCRIPT_PATH}" "function(${DKSCRIPT_NAME})")
		if(dk_fileIncludes)
			include(${DKSCRIPT_PATH}) # make sure the correct function is loaded
			cmake_language(CALL "${DKSCRIPT_NAME}" ${DKSCRIPT_ARGS})
			return()
		endif()
		
		###### DKSCRIPT_PATH ######
		include("${DKSCRIPT_PATH}")
	endif()
	
endfunction()

#########################################################################
# dk_echo()
#
#function(dk_echo)
#	message("${ARGV}")
#endfunction()

#########################################################################
# dk_initVariableWatch()
#
function(dk_initVariableWatch)
	dk_load("dk_onVariableWatch")
	#variable_watch("cmake_exe" dk_onVariableWatch)
	#variable_watch(CMAKE_CURRENT_FUNCTION_LINE dk_onVariableWatch)
	#variable_watch(CMAKE_CURRENT_FUNCTION_LIST_LINE dk_onVariableWatch)
endfunction()

#########################################################################
# dk_setVariables()
#
function(dk_setVariables)
	if(DEFINED ENV{WSL_DISTRO_NAME})
		set(WSL 1 CACHE INTERNAL "" FORCE)
		message("CMake using WSL")
	endif()
	if(DEFINED "ENV{ProgramW6432}")
		message("ENV{ProgramW6432} = $ENV{ProgramW6432}")
		file(TO_CMAKE_PATH "$ENV{ProgramW6432}" ProgramFiles)
		set(ProgramFiles "${ProgramFiles}" CACHE INTERNAL "" FORCE)
	elseif(DEFINED "ENV{ProgramFiles}")
		message("ENV{ProgramFiles} = $ENV{ProgramFiles}")
		file(TO_CMAKE_PATH "$ENV{ProgramFiles}" ProgramFiles)
		set(ProgramFiles "${ProgramFiles}" CACHE INTERNAL "" FORCE)
	endif()
endfunction()


#########################################################################
# DKHTTP_VARS()
#
function(DKHTTP_VARS)
	set(DKHTTP_DIGITALKNOB_DIR			"http://aquawicket.com/DigitalKnob"			CACHE INTERNAL "" FORCE)
	set(DKHTTP_DKBRANCH_DIR				"${DKHTTP_DIGITALKNOB_DIR}/Development"		CACHE INTERNAL "" FORCE)
	set(DKHTTP_DKCMAKE_DIR				"${DKHTTP_DKBRANCH_DIR}/DKCMake"			CACHE INTERNAL "" FORCE)
	set(DKHTTP_DKCMAKE_FUNCTIONS_DIR	"${DKHTTP_DKCMAKE_DIR}/functions"			CACHE INTERNAL "" FORCE)
endfunction()


#####################################################################
# DKSCRIPT_PATH()
#
function(DKSCRIPT_PATH)
	if(NOT EXISTS "${DKSCRIPT_PATH}")
		file(TO_CMAKE_PATH "$ENV{DKSCRIPT_PATH}" DKSCRIPT_PATH)
	endif()
	if(NOT EXISTS "${DKSCRIPT_PATH}")
		#math(EXPR n "${CMAKE_ARGC}-1")
		#get_filename_component(DKSCRIPT_PATH "${CMAKE_ARGV${n}}" REALPATH)
		set(DKSCRIPT_PATH "${CMAKE_SCRIPT_MODE_FILE}")
	endif()
	if(NOT EXISTS "${DKSCRIPT_PATH}")
		set(DKSCRIPT_PATH "${CMAKE_PARENT_LIST_FILE}")
	endif()
	if(NOT EXISTS "${DKSCRIPT_PATH}")
		set(DKSCRIPT_PATH "${CMAKE_CURRENT_LIST_FILE}")
	endif()
	if(NOT EXISTS "${DKSCRIPT_PATH}")
		message("[31m ERROR: DKSCRIPT_PATH:'${DKSCRIPT_PATH}' NOT FOUND [0m")
	endif()
	set(DKSCRIPT_PATH "${DKSCRIPT_PATH}" CACHE INTERNAL "" FORCE)
	message("DKSCRIPT_PATH:'${DKSCRIPT_PATH}'")
	
	#set(ENV{DKSCRIPT_PATH} "${DKSCRIPT_PATH}")
endfunction()

#####################################################################
# DKSCRIPT_ARGS()
#
function(DKSCRIPT_ARGS)
	if(NOT DKSCRIPT_ARGS)
		file(TO_CMAKE_PATH "$ENV{DKSCRIPT_ARGS}" DKSCRIPT_ARGS)
	endif()
	if(NOT DKSCRIPT_ARGS)
		set(DKSCRIPT_ARGS ${ARGS})
	endif()
	if(NOT DKSCRIPT_ARGS)
		message("[31m ERROR: DKSCRIPT_ARGS:'${DKSCRIPT_ARGS}' INVALID [0m")
	endif()
	set(DKSCRIPT_ARGS "${DKSCRIPT_ARGS}" CACHE INTERNAL "" FORCE)
	message("DKSCRIPT_ARGS:'$CACHE{DKSCRIPT_ARGS}'")
	
	#set(ENV{DKSCRIPT_ARGS} "${DKSCRIPT_ARGS}")
endfunction()

#####################################################################
# DKSCRIPT_DIR()
#
function(DKSCRIPT_DIR)
	if(NOT EXISTS "${DKSCRIPT_PATH}")
		DKSCRIPT_PATH()
	endif()
	if(NOT EXISTS "${DKSCRIPT_DIR}")
		get_filename_component(DKSCRIPT_DIR "${DKSCRIPT_PATH}" DIRECTORY)
	endif()
	if(NOT EXISTS "${DKSCRIPT_DIR}")
		message("[31m ERROR: DKSCRIPT_DIR:'${DKSCRIPT_DIR}' INVALID [0m")
	endif()
	set(DKSCRIPT_DIR "${DKSCRIPT_DIR}" CACHE INTERNAL "" FORCE)
	message("DKSCRIPT_DIR:'$CACHE{DKSCRIPT_DIR}'")
	
	#set(ENV{DKSCRIPT_DIR} "${DKSCRIPT_DIR}")
endfunction()

#####################################################################
# DKSCRIPT_FILE()
#
function(DKSCRIPT_FILE)
	if(NOT EXISTS "${DKSCRIPT_PATH}")
		DKSCRIPT_PATH()
	endif()
	if(NOT DKSCRIPT_FILE)
		get_filename_component(DKSCRIPT_FILE "${DKSCRIPT_PATH}" NAME)
	endif()
	if(NOT DKSCRIPT_FILE)
		message("[31m ERROR: DKSCRIPT_FILE:'${DKSCRIPT_FILE}' INVALID [0m")
	endif()
	set(DKSCRIPT_FILE "${DKSCRIPT_FILE}" CACHE INTERNAL "" FORCE)
	message("DKSCRIPT_FILE:'$CACHE{DKSCRIPT_FILE}'")
	
	#set(ENV{DKSCRIPT_FILE} "${DKSCRIPT_FILE}")
endfunction()

#####################################################################
# DKSCRIPT_NAME()
#
function(DKSCRIPT_NAME)
	if(NOT EXISTS "${DKSCRIPT_PATH}")
		DKSCRIPT_PATH()
	endif()
	if(NOT DKSCRIPT_NAME)
		get_filename_component(DKSCRIPT_NAME "${DKSCRIPT_PATH}" NAME_WE)
	endif()
	if(NOT DKSCRIPT_NAME)
		message("[31m ERROR: DKSCRIPT_NAME:'${DKSCRIPT_NAME}' INVALID [0m")
	endif()
	set(DKSCRIPT_NAME "${DKSCRIPT_NAME}" CACHE INTERNAL "" FORCE)
	message("DKSCRIPT_NAME:'$CACHE{DKSCRIPT_NAME}'")
	
	#set(ENV{DKSCRIPT_NAME} "${DKSCRIPT_NAME}")
endfunction()

#####################################################################
# DKSCRIPT_EXT()
#
function(DKSCRIPT_EXT)
	if(NOT EXISTS "${DKSCRIPT_PATH}")
		DKSCRIPT_PATH()
	endif()
	if(NOT DKSCRIPT_EXT)
		get_filename_component(DKSCRIPT_EXT "${DKSCRIPT_PATH}" LAST_EXT)
	endif()
	if(NOT DKSCRIPT_EXT)
		message("[31m ERROR: DKSCRIPT_EXT:'${DKSCRIPT_EXT}' INVALID [0m")
	endif()
	set(DKSCRIPT_EXT "${DKSCRIPT_EXT}" CACHE INTERNAL "" FORCE)
	message("DKSCRIPT_EXT:'$CACHE{DKSCRIPT_EXT}'")
	
	#set(ENV{DKSCRIPT_EXT} "${DKSCRIPT_EXT}")
endfunction()


#####################################################################
# DKCMAKE_DIR()
#
function(DKCMAKE_DIR)
	if(NOT EXISTS "${DKCMAKE_DIR}")
		file(TO_CMAKE_PATH "$ENV{DKCMAKE_DIR}" DKCMAKE_DIR)
	endif()
	if(NOT EXISTS "${DKCMAKE_DIR}")
		get_filename_component(DKCMAKE_DIR "${CMAKE_CURRENT_LIST_DIR}" DIRECTORY)
	endif()
	if(NOT EXISTS "${DKCMAKE_DIR}")
		message("[31m ERROR: DKCMAKE_DIR:'${DKCMAKE_DIR}' NOT FOUND [0m")
	endif()
	set(DKCMAKE_DIR "${DKCMAKE_DIR}" CACHE INTERNAL "" FORCE)
	message("DKCMAKE_DIR:'$CACHE{DKCMAKE_DIR}'")
	
	#set(ENV{DKCMAKE_DIR} "${DKCMAKE_DIR}")
endfunction()

#####################################################################
# DKCMAKE_FUNCTIONS_DIR()
#
function(DKCMAKE_FUNCTIONS_DIR)
	if(NOT EXISTS "${DKCMAKE_FUNCTIONS_DIR}")
		file(TO_CMAKE_PATH "$ENV{DKCMAKE_FUNCTIONS_DIR}" DKCMAKE_FUNCTIONS_DIR)
	endif()
	if(NOT EXISTS "${DKCMAKE_FUNCTIONS_DIR}")
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${CMAKE_CURRENT_LIST_DIR}" REALPATH)
	endif()
	if(NOT EXISTS "${DKCMAKE_FUNCTIONS_DIR}")
		message("[31m ERROR: DKCMAKE_FUNCTIONS_DIR:'${DKCMAKE_FUNCTIONS_DIR}' NOT FOUND [0m")
	endif()
	set(DKCMAKE_FUNCTIONS_DIR "${DKCMAKE_FUNCTIONS_DIR}" CACHE INTERNAL "" FORCE)
	message("DKCMAKE_FUNCTIONS_DIR:'$CACHE{DKCMAKE_FUNCTIONS_DIR}'")
	
	#set(ENV{DKCMAKE_FUNCTIONS_DIR} "${DKCMAKE_FUNCTIONS_DIR}")
endfunction()

#####################################################################
# DKCMAKE_FUNCTIONS_DIR_()
#
function(DKCMAKE_FUNCTIONS_DIR_)
	if(NOT EXISTS "${DKCMAKE_FUNCTIONS_DIR_}")
		DKCMAKE_FUNCTIONS_DIR()
		set(DKCMAKE_FUNCTIONS_DIR_ "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	set(DKCMAKE_FUNCTIONS_DIR_ "${DKCMAKE_FUNCTIONS_DIR_}" CACHE INTERNAL "" FORCE)
	message("DKCMAKE_FUNCTIONS_DIR_:'$CACHE{DKCMAKE_FUNCTIONS_DIR_}'")
	
	#set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR_}")
endfunction()


DKINIT()












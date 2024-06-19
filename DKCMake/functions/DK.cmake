
include_guard()		# include_guard


#####################################################################
# DK()
#
#
function(DK)
	dk_echo("DK()")
	
	###### Initialize Language specifics ######
	dk_init()

	###### Reload Main Script with cmake ######
	# dk_reloadWithCmake()
	
	############ Get DKCMAKE variables ############
	dk_DKCMAKE_VARS()
	dk_echo("DKCMAKE_DIR = ${DKCMAKE_DIR}")
	dk_echo("DKCMAKE_FUNCTIONS_DIR = ${DKCMAKE_FUNCTIONS_DIR}")
	
	############ Get DKHTTP variables ############
	dk_DKHTTP_VARS()
	dk_echo("DKHTTP_DKCMAKE_FUNCTIONS_DIR = ${DKHTTP_DKCMAKE_FUNCTIONS_DIR}")

	############ Setup dk_callStack ############
	#dk_setupCallstack()
	#dk_callStack()
	#:dk_callStackReturn
	
	############ Get DKSCRIPT variables ############
	dk_DKSCRIPT_VARS()
	dk_echo("DKSCRIPT_PATH = ${DKSCRIPT_PATH}")
	dk_echo("DKSCRIPT_ARGS = ${DKSCRIPT_ARGS}")
	dk_echo("DKSCRIPT_DIR = ${DKSCRIPT_DIR}")
	dk_echo("DKSCRIPT_NAME = ${DKSCRIPT_NAME}")
	
	############ Setup KeepOpen ############
	#dk_setupKeepOpen()
	
	##### CD into the DKSCRIPT_DIR directory #####
	#cd("${DKSCRIPT_DIR}")
	
	############ Set Options ############
	#dk_setOptions()
	

	
	set(ENABLE_DKTEST 1 CACHE INTERNAL "")

	###### load default function ####
	include(${DKCMAKE_FUNCTIONS_DIR}/dk_load.cmake)
	include(${DKCMAKE_FUNCTIONS_DIR}/dk_eval.cmake)
	include(${DKCMAKE_FUNCTIONS_DIR}/dk_debugFunc.cmake)
	dk_load(dk_eval)
	dk_load(dk_escapeSequences)
	dk_escapeSequences()
	#dk_load(${DKSCRIPT_PATH})


	###### DKTEST MODE ######
	if("${ENABLE_DKTEST}" EQUAL "1")
	if("${DKSCRIPT_DIR}" STREQUAL "${DKCMAKE_FUNCTIONS_DIR}")
		message("\n###### DKTEST MODE ###### ${DKSCRIPT_NAME} ###### DKTEST MODE ######\n")
		dk_load(${DKSCRIPT_PATH})
		DKTEST()
		
		message("\n########################## END TEST ################################\n")
		dk_pause()
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
	#cmake_policy(SET CMP0003 NEW) 	# https://cmake.org/cmake/help/latest/policy/CMP0003.html
	cmake_policy(SET CMP0007 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0007.html
	cmake_policy(SET CMP0011 NEW)
	cmake_policy(SET CMP0054 NEW)
	cmake_policy(SET CMP0057 NEW)
	
	set(CMAKE_MESSAGE_LOG_LEVEL "TRACE")
	if(CMAKE_SCRIPT_MODE_FILE)
		message("")
		message("########################################################")
		message("################# CMAKE SCRIPT MODE ####################")
		message("########################################################")
		message("")
	endif()
endfunction()

#####################################################################
# dk_DKCMAKE_VARS()
#
function(dk_DKCMAKE_VARS)
	get_filename_component(DKCMAKE_DIR ${CMAKE_CURRENT_LIST_DIR} DIRECTORY CACHE INTERNAL "")
	set(DKCMAKE_DIR ${DKCMAKE_DIR} CACHE INTERNAL "")
	set(DKCMAKE_FUNCTIONS_DIR ${DKCMAKE_DIR}/functions CACHE INTERNAL "")
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
	#todo
endfunction()

##################################################################################
# dk_DKSCRIPT_VARS()
#
function(dk_DKSCRIPT_VARS)
	set(DKSCRIPT_PATH "${CMAKE_PARENT_LIST_FILE}")
	if(NOT EXISTS ${DKSCRIPT_PATH})
		dk_echo("DKSCRIPT_PATH not found!")
	endif()
	set(DKSCRIPT_ARGS ${ARGS})
	get_filename_component(DKSCRIPT_DIR ${DKSCRIPT_PATH} DIRECTORY CACHE INTERNAL "")
	if(NOT EXISTS ${DKSCRIPT_DIR})
		dk_echo("DKSCRIPT_DIR not found!")
	endif()
	get_filename_component(DKSCRIPT_NAME ${DKSCRIPT_PATH} NAME CACHE INTERNAL "")
endfunction()

##################################################################################
# dk_setupKeepOpen()
#
function(dk_setupKeepOpen)
	#if "%KEEP_CONSOLE_OPEN%" equ "1" if not defined in_subprocess (cmd /k set in_subprocess=y ^& set "DKINIT=" ^& "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%) & set "DKINIT=1" & exit )
endfunction()



DK()

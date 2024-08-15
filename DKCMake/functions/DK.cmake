
include_guard()		# include_guard

#cmake_policy(SET CMP0003 NEW) 	# https://cmake.org/cmake/help/latest/policy/CMP0003.html
cmake_policy(SET CMP0007 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0007.html
cmake_policy(SET CMP0011 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0011.html
cmake_policy(SET CMP0012 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0012.html
cmake_policy(SET CMP0054 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0054.html
cmake_policy(SET CMP0057 NEW)	# https://cmake.org/cmake/help/latest/policy/CMP0057.html
cmake_policy(SET CMP0126 NEW)   # https://cmake.org/cmake/help/latest/policy/CMP0126.html

# Note: Using DK() as the function name will cause DK/DKMAKE.cmake to fail in dk_load.cmake
#####################################################################
# DKINIT()
#
#
function(DKINIT)
	#dk_echo("DKINIT()")
	
	###### Initialize Language specifics ######
	dk_init()

	###### Reload Main Script with cmake ######
	# dk_reloadWithCmake()
	
	############ Get DKCMAKE variables ############
	dk_DKCMAKE_VARS()
	#dk_echo("DKCMAKE_DIR = ${DKCMAKE_DIR}")
	#dk_echo("DKCMAKE_FUNCTIONS_DIR = ${DKCMAKE_FUNCTIONS_DIR}")
	
	############ Get DKHTTP variables ############
	dk_DKHTTP_VARS()
	#dk_echo("DKHTTP_DKCMAKE_FUNCTIONS_DIR = ${DKHTTP_DKCMAKE_FUNCTIONS_DIR}")

	############ Setup dk_callStack ############
	dk_setupCallstack()
	#dk_callStack()
	#:dk_callStackReturn
	
	############ Get DKSCRIPT variables ############
	dk_DKSCRIPT_VARS()
	dk_echo("DKSCRIPT_PATH = ${DKSCRIPT_PATH}")
	#dk_echo("DKSCRIPT_ARGS = ${DKSCRIPT_ARGS}")
	#dk_echo("DKSCRIPT_DIR = ${DKSCRIPT_DIR}")
	#dk_echo("DKSCRIPT_NAME = ${DKSCRIPT_NAME}")
	
	############ Setup KeepOpen ############
	#dk_setupKeepOpen()
	
	##### CD into the DKSCRIPT_DIR directory #####
	#cd("${DKSCRIPT_DIR}")
	
	############ Set Options ############
	#dk_setOptions()
	
	set(ENABLE_DKTEST 1 CACHE INTERNAL "")

	############ LOAD FUNCTION FILES ############
	include(${DKCMAKE_FUNCTIONS_DIR}/dk_load.cmake)
	include(${DKCMAKE_FUNCTIONS_DIR}/dk_dirname.cmake)
	include(${DKCMAKE_FUNCTIONS_DIR}/dk_basename.cmake)
	#dk_load(${DKSCRIPT_PATH})
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
	
	dk_load(${DKSCRIPT_PATH})  #FIXME:   for some reason this causes clang++ command errors on all builds

	
	
	###### DKTEST MODE ######
	if(ENABLE_DKTEST)
	dk_echo("DKSCRIPT_DIR = ${DKSCRIPT_DIR}")
	dk_echo("DKCMAKE_FUNCTIONS_DIR = ${DKCMAKE_FUNCTIONS_DIR}")
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
		dk_echo("")
		dk_echo("########################################################")
		dk_echo("################# CMAKE SCRIPT MODE ####################")
		dk_echo("########################################################")
		dk_echo("")
	endif()
endfunction()

#####################################################################
# dk_DKCMAKE_VARS()
#
function(dk_DKCMAKE_VARS)
	get_filename_component(DKCMAKE_DIR ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)
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
# dk_onCallstack()
#
macro(dk_onCallstack variable access value current_list_file stack)
	#dk_echo("dk_onCallstack(${variable} ${access} ${value} ${current_list_file} ${stack})")
	if("${access}" STREQUAL "MODIFIED_ACCESS")
		set(MAX_STACK_SIZE 99)
		set(CMAKE_STACK ${stack} CACHE INTERNAL "")
		list(LENGTH CMAKE_STACK CMAKE_STACK_SIZE)
			
		set(__FILE__ "${CMAKE_CURRENT_FUNCTION_LIST_FILE}" CACHE INTERNAL "")
		set(__LINE__ "${CMAKE_CURRENT_FUNCTION_LIST_LINE}" CACHE INTERNAL "")
		set(__FUNCTION__ "${CMAKE_CURRENT_FUNCTION}" CACHE INTERNAL "")
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
		
		#dk_echo("${cyan}  > ${__TIME__}${__FILE__}:${__LINE__}   ${__FUNCTION__}()")
	endif()
endmacro()

##################################################################################
# dk_setupCallstack()
#
function(dk_setupCallstack)
	dk_echo("dk_setupCallstack()")
	#variable_watch(CMAKE_CURRENT_FUNCTION_LIST_FILE dk_onCallstack)
	#variable_watch(CMAKE_CURRENT_FUNCTION_LIST_LINE dk_onCallstack)
	variable_watch(CMAKE_CURRENT_FUNCTION dk_onCallstack)
endfunction()

##################################################################################
# dk_DKSCRIPT_VARS()
#
function(dk_DKSCRIPT_VARS)
	set(DKSCRIPT_PATH "${CMAKE_PARENT_LIST_FILE}" CACHE INTERNAL "")
	if(NOT EXISTS ${DKSCRIPT_PATH})
		dk_error("DKSCRIPT_PATH not found!")
	endif()
	
	set(DKSCRIPT_ARGS ${ARGS} CACHE INTERNAL "")

	get_filename_component(DKSCRIPT_DIR ${DKSCRIPT_PATH} DIRECTORY)
	set(DKSCRIPT_DIR ${DKSCRIPT_DIR} CACHE INTERNAL "")
	if(NOT EXISTS ${DKSCRIPT_DIR})
		dk_error("DKSCRIPT_DIR not found!")
	endif()
	
	get_filename_component(DKSCRIPT_NAME ${DKSCRIPT_PATH} NAME)
	set(DKSCRIPT_NAME ${DKSCRIPT_NAME} CACHE INTERNAL "")
endfunction()

##################################################################################
# dk_setupKeepOpen()
#
function(dk_setupKeepOpen)
	#if "%KEEP_CONSOLE_OPEN%" equ "1" if not defined in_subprocess (cmd /k set in_subprocess=y ^& set "DKINIT=" ^& "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%) & set "DKINIT=1" & exit )
endfunction()



DKINIT()

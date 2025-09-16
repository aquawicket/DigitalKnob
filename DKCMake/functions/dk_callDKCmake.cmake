#!/usr/bin/cmake -P
message("callDKCMake.cmake")
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################



#########################################################################
# dk_callDKCmake(function, arguments...)
#
#
function(dk_callDKCmake)
    dk_debugFunc()
    message("dk_callDKCMake(${ARGV})")
	
	set(func ${ARGV0})
	dk_load("dk_allButFirstArgs")
	dk_allButFirstArgs(${ARGV})
	set(args ${dk_allButFirstArgs})
	separate_arguments(args NATIVE_COMMAND "${args}")
	
	message("func = ${func}")
	message("args = ${args}")
	
	dk_load("${func}")
	cmake_language(CALL ${func} ${args})
	set(dk_callDKCmake "${${func}}" PARENT_SCOPE)
    
	### get required variables ###
#    dk_validate(ENV{DKIMPORTS_DIR}          "dk_DKBRANCH_DIR()")
#	dk_depend(cmake)
#	dk_validate(ENV{DKCMAKE_DIR}            "dk_DKBRANCH_DIR()")
#   dk_validate(ENV{DKCMAKE_FUNCTIONS_DIR}	"dk_DKBRANCH_DIR()")
#	dk_set(ENV{DKCMAKE_FUNCTIONS_DIR}      	"$ENV{DKCMAKE_FUNCTIONS_DIR}")
#	dk_set(ENV{DKCMAKE_FUNCTIONS_DIR_}     	"$ENV{DKCMAKE_FUNCTIONS_DIR}/")
#	dk_set(ENV{DKSCRIPT_PATH}              	"$ENV{DKSCRIPT_PATH}")
    
    
    ### get ALL_BUT_FIRST_ARGS ###
	#set(ALL_BUT_FIRST_ARGS              ${ARGN})
    
    ### get LAST_ARG ###
    #list(GET ARGN -1 LAST_ARG)
    
    
    ### Call DKCmake function ###
#   set(DKCOMMAND "${func}(${ARGN})")
#    set(DKCMAKE_COMMAND "${cmake_exe} -DDKCOMMAND=${DKCOMMAND} -DDKSCRIPT_PATH=$ENV{DKSCRIPT_PATH} -DDKCMAKE_FUNCTIONS_DIR_=$ENV{DKCMAKE_FUNCTIONS_DIR_} -P $ENV{DKCMAKE_DIR}/DKEval.cmake")
    #dk_echo("${DKCMAKE_COMMAND}")
#    execute_process(COMMAND ${DKCMAKE_COMMAND} WORKING_DIRECTORY "$ENV{DKCMAKE_FUNCTIONS_DIR}" OUTPUT_VARIABLE output ECHO_OUTPUT_VARIABLE OUTPUT_STRIP_TRAILING_WHITESPACE)
    
    
    ### process the return value ###
    #dk_echo("output = ${output}")
    #if("${LAST_ARG}" STREQUAL "rtn_var")
#        string(FIND "${output}" "\n" last_newline_pos REVERSE)  # Find the position of the last newline character
#        if(last_newline_pos GREATER -1)
#            string(SUBSTRING "${output}" ${last_newline_pos} -1 dk_callDKCmake) # Extract the last line
#        else()
#            set(dk_callDKCmake "${output}") # If no newline character was found, the whole string is the last line
#        endif()
#        string(STRIP "${dk_callDKCmake}" dk_callDKCmake)
        
#        set(dk_callDKCmake "${dk_callDKCmake}" PARENT_SCOPE)
#        execute_process(COMMAND ${CMAKE_COMMAND} -E echo "${dk_callDKCmake}")
    #endif()
endfunction()



if(DEFINED ENV{callDKCmake_func})
	message("ENV{callDKCmake_func} = $ENV{callDKCmake_func}")
	message("ENV{callDKCmake_args} = $ENV{callDKCmake_args}")
	dk_callDKCmake($ENV{callDKCmake_func} $ENV{callDKCmake_args})
	message("${dk_callDKCmake}")
endif()

###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
    message("DKTEST()")
	
    dk_callDKCmake(dk_basename "C:/Windows/System32")
	dk_echo()
    dk_echo("dk_callDKCmake = ${dk_callDKCmake}")
endfunction()

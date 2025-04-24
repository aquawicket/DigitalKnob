#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

################################################################################
# dk_callDKCmake(function, arguments..., rtn_var)
#
#
function(dk_callDKCmake func rtn_var)
    dk_debugFunc()
    
    ### get required variables ###
<<<<<<< HEAD
    dk_validate(DKIMPORTS_DIR           "dk_DKBRANCH_DIR()")
    dk_validate(CMAKE_EXE               "dk_depend(cmake)")
	dk_validate(DKCMAKE_DIR             "dk_DKBRANCH_DIR()")
    dk_validate(DKCMAKE_FUNCTIONS_DIR   "dk_DKBRANCH_DIR()")
	set(DKCMAKE_FUNCTIONS_DIR           "${DKCMAKE_FUNCTIONS_DIR:\=/%")
	set(DKCMAKE_FUNCTIONS_DIR_          "${DKCMAKE_FUNCTIONS_DIR}/")
	set(DKSCRIPT_PATH                   "${DKSCRIPT_PATH:\=/}")
=======
    dk_validate(ENV{DKIMPORTS_DIR}           "dk_DKBRANCH_DIR()")
	dk_depend(cmake)
	dk_validate(ENV{DKCMAKE_DIR}             "dk_DKBRANCH_DIR()")
    dk_validate(DKCMAKE_FUNCTIONS_DIR   "dk_DKBRANCH_DIR()")
	set(ENV{DKCMAKE_FUNCTIONS_DIR}           "$ENV{DKCMAKE_FUNCTIONS_DIR}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_}          "$ENV{DKCMAKE_FUNCTIONS_DIR}/")
	set(ENV{DKSCRIPT_PATH}                   "$ENV{DKSCRIPT_PATH}")
>>>>>>> Development
    
    
    ### get ALL_BUT_FIRST_ARGS ###
	#set(ALL_BUT_FIRST_ARGS              ${ARGN})
    
    ### get LAST_ARG ###
    #list(GET ARGN -1 LAST_ARG)
    
    
    ### Call DKCmake function ###
    set(DKCOMMAND "${func}(${ARGN})")
<<<<<<< HEAD
    set(DKCMAKE_COMMAND=${CMAKE_EXE} -DDKCOMMAND=${DKCOMMAND} -DDKSCRIPT_PATH=${DKSCRIPT_PATH} -DQUEUE_BUILD=ON -DDKCMAKE_FUNCTIONS_DIR_=${DKCMAKE_FUNCTIONS_DIR_} -P ${DKCMAKE_DIR}/DKEval.cmake)
    #dk_echo("${DKCMAKE_COMMAND}")
    execute_process(COMMAND ${DKCMAKE_COMMAND} WORKING_DIRECTORY "${DKCMAKE_FUNCTIONS_DIR}" OUTPUT_VARIABLE output ECHO_OUTPUT_VARIABLE OUTPUT_STRIP_TRAILING_WHITESPACE)
=======
    set(DKCMAKE_COMMAND "${CMAKE_EXE} -DDKCOMMAND=${DKCOMMAND} -DDKSCRIPT_PATH=$ENV{DKSCRIPT_PATH} -DQUEUE_BUILD=ON -DDKCMAKE_FUNCTIONS_DIR_=$ENV{DKCMAKE_FUNCTIONS_DIR_} -P $ENV{DKCMAKE_DIR}/DKEval.cmake")
    #dk_echo("${DKCMAKE_COMMAND}")
    execute_process(COMMAND ${DKCMAKE_COMMAND} WORKING_DIRECTORY "$ENV{DKCMAKE_FUNCTIONS_DIR}" OUTPUT_VARIABLE output ECHO_OUTPUT_VARIABLE OUTPUT_STRIP_TRAILING_WHITESPACE)
>>>>>>> Development
    
    
    ### process the return value ###
    #dk_echo("output = ${output}")
    #if("${LAST_ARG}" STREQUAL "rtn_var")
        string(FIND "${output}" "\n" last_newline_pos REVERSE)  # Find the position of the last newline character
        if(last_newline_pos GREATER -1)
            string(SUBSTRING "${output}" ${last_newline_pos} -1 rtn_value) # Extract the last line
        else()
            set(rtn_value "${output}") # If no newline character was found, the whole string is the last line
        endif()
        string(STRIP "${rtn_value}" rtn_value)
        
        set(${rtn_var} "${rtn_value}" PARENT_SCOPE)
        execute_process(COMMAND ${CMAKE_COMMAND} -E echo "${rtn_value}")
    #endif()
    
# DEBUG
#	dk_printVar(rtn_value)
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
    
    dk_callDKCmake(dk_test "FROM DKCmake" "dk_callDKCmake.cmake" rtn_var)
	dk_echo()
    dk_echo("rtn_var = ${rtn_var}")
endfunction()

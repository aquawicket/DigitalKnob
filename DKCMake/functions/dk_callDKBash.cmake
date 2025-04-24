#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_callDKBash(function, arguments..., rtn_var)
#
#
function(dk_callDKBash func rtn_var)
	dk_debugFunc()
	
    ### get required variables ###
	dk_validate(BASH_EXE                "dk_depend(bash)")
	dk_validate(DKBASH_FUNCTIONS_DIR    "dk_DKBRANCH_DIR()")
    
    
    ### get ALL_BUT_FIRST_ARGS ###
	#set(ALL_BUT_FIRST_ARGS              ${ARGN})
    
    ### get LAST_ARG ###
    #list(GET ARGN -1 LAST_ARG)
    
    
    ### Call DKBash function ###
    dk_set(DKBASH_COMMAND "${BASH_EXE}" -c "${DKBASH_FUNCTIONS_DIR}/${func}.sh ${ARGN}")
	#dk_echo("${DKBASH_COMMAND}")
    execute_process(COMMAND ${DKBASH_COMMAND} WORKING_DIRECTORY "${DKBASH_FUNCTIONS_DIR}" OUTPUT_VARIABLE output ECHO_OUTPUT_VARIABLE OUTPUT_STRIP_TRAILING_WHITESPACE)
   
   
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
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##################################################################################
# dk_callDKBash(function, arguments...)
#
#
function(dk_callDKBash)
	#dk_debugFunc()
	set(RTN_var ${ARGV0})
	set(func 	${ARGV0})

	### get required variables ###
	dk_depend(bash)
	dk_validate(DKBASH_FUNCTIONS_DIR_    "dk_DKBRANCH_DIR()")
	dk_assertPath("${DKBASH_FUNCTIONS_DIR_}")

	### get ALL_BUT_FIRST_ARGS ###
	#set(ALL_BUT_FIRST_ARGS              ${ARGN})

	### get LAST_ARG ###
	#list(GET ARGN -1 LAST_ARG)

#	### Call DKBash function
#	dk_set(DKBASH_COMMAND "${BASH_EXE} -c ${DKBASH_FUNCTIONS_DIR_}${func}.sh ${ARGN}")
#	dk_echo("${DKBASH_COMMAND}")
#	execute_process(COMMAND ${DKBASH_COMMAND} WORKING_DIRECTORY "${DKBASH_FUNCTIONS_DIR}" OUTPUT_VARIABLE output ECHO_OUTPUT_VARIABLE OUTPUT_STRIP_TRAILING_WHITESPACE)

#	### process the return value ###
#	#dk_echo("output = ${output}")
#	#if("${LAST_ARG}" STREQUAL "RTN_var")
#		string(FIND "${output}" "\n" last_newline_pos REVERSE)  # Find the position of the last newline character
#		if(last_newline_pos GREATER -1)
#			string(SUBSTRING "${output}" ${last_newline_pos} -1 RTN_value) # Extract the last line
#		else()
#			set(RTN_value "${output}") # If no newline character was found, the whole string is the last line
#		endif()
#		string(STRIP "${RTN_value}" RTN_value)
#		
#	set(${RTN_var} "${RTN_value}" PARENT_SCOPE)
#		execute_process(COMMAND ${CMAKE_COMMAND} -E echo "${RTN_value}")
#	#endif()

#if(DEBUG_CMAKE)
#	dk_printVar(RTN_value)
#endif()
>>>>>>> Development
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_callDKBash(dk_test rtn_var "FROM DKCmake" "dk_callDKBash.cmake")
    dk_echo()
	dk_echo("rtn_var = ${rtn_var}")
	
	dk_callDKBash(dk_extract "${DKDOWNLOAD_DIR}/android-ndk-r23c-aarch64.zip" "${HOME}")
=======
	dk_debugFunc(0)
	
	dk_callDKBash(dk_test "FROM DKCmake" "dk_callDKBash.cmake")
	dk_echo("dk_test = ${dk_test}")
	
	#dk_callDKBash(result dk_test)
>>>>>>> Development
endfunction()

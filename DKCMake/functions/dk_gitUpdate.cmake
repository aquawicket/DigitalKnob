#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_gitUpdate()
#
#
function(dk_gitUpdate)
	dk_debugFunc(2 3)

	if(ARGV0)
		set(url ${ARGV0}) 
	else()
		set(url "https://github.com/aquawicket/DigitalKnob.git")
	endif()
	
	if(ARGV1)
		set(branch ${ARGV1})
	else()
		set(branch "Development")
	endif()
	
	dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
	dk_validate(GIT_EXE "dk_installGit()")
	
	if(NOT EXISTS "${DKBRANCH_DIR}/.git")
		execute_process(COMMAND "${GIT_EXE}" clone ${url} "${DKBRANCH_DIR}")
	endif()
	
	execute_process(COMMAND "${GIT_EXE}" -C ${DKBRANCH_DIR} pull --all)
    execute_process(COMMAND "${GIT_EXE}" -C ${DKBRANCH_DIR} checkout -- .)
	
	execute_process(COMMAND "${GIT_EXE}" -C ${DKBRANCH_DIR} checkout ${branch} COMMAND echo "%ERRORLEVEL%" == "0" OUTPUT_VARIABLE ERRORLEVEL OUTPUT_STRIP_TRAILING_WHITESPACE)
	
	### process the return value ###
    string(FIND "${ERRORLEVEL}" "\n" last_newline_pos REVERSE)  # Find the position of the last newline character
    if(last_newline_pos GREATER -1)
        string(SUBSTRING "${ERRORLEVEL}" ${last_newline_pos} -1 ERRORLEVEL) # Extract the last line
    endif()
    string(STRIP "${ERRORLEVEL}" ERRORLEVEL)
    dk_echo("ERRORLEVEL = ${ERRORLEVEL}")  
    #set(${rtn_var} "${rtn_value}" PARENT_SCOPE)
    #execute_process(COMMAND ${CMAKE_COMMAND} -E echo "${rtn_value}")

	
	
	
	if(NOT ${ERRORLEVEL} EQUAL 0)
		dk_echo("Remote has no %branch% branch. Creating...")
		#execute_process(COMMAND "${GIT_EXE}" -C ${DKBRANCH_DIR} checkout -b ${branch} main)
		#execute_process(COMMAND "${GIT_EXE}" -C ${DKBRANCH_DIR} push --set-upstream origin ${branch})
	else()
		dk_echo("Updated ${branch} branch.")
	endif()
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_gitUpdate()
endfunction()
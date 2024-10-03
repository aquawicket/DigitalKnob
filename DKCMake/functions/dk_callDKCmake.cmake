#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

################################################################################
# dk_callDKCmake(function, arguments..., rtn_var)
#
#
function(dk_callDKCmake func rtn_var)
    dk_debugFunc("\${ARGV}")
    
    dk_validate(DKIMPORTS_DIR           "dk_DKBRANCH_DIR()")
    dk_validate(CMAKE_EXE               "dk_depend(cmake)")
	dk_validate(DKCMAKE_DIR             "dk_DKBRANCH_DIR()")
    dk_validate(DKCMAKE_FUNCTIONS_DIR   "dk_DKBRANCH_DIR()")
	set(DKCMAKE_FUNCTIONS_DIR           "${DKCMAKE_FUNCTIONS_DIR:\=/%")
	set(DKCMAKE_FUNCTIONS_DIR_          "${DKCMAKE_FUNCTIONS_DIR}/")
	set(DKSCRIPT_PATH                   "${DKSCRIPT_PATH:\=/}")
    
    # get ALL_BUT_FIRST_ARGS
	TODO set ALL_BUT_FIRST_ARGS=%%b
    set(ALL_BUT_FIRST_ARGS "${ALL_BUT_FIRST_ARGS:"='%"}
    
    # get LAST_ARG
    TODO set LAST_ARG=%%a
    
    # Create Run function Script
    set(DKCOMMAND  "${func}(${ALL_BUT_FIRST_ARGS})")
    
	####### run script ######
	#"${CMAKE_EXE}" -DDKSCRIPT_PATH=%DKSCRIPT_PATH% -DQUEUE_BUILD=ON -DDKCMAKE_FUNCTIONS_DIR_="%DKCMAKE_FUNCTIONS_DIR_%" -P "%DKCMAKE_FUNCTIONS_DIR_%/%~1.cmake"
    # call DKPowershell function
#echo for /f "delims=" %%Z in ('"%CMAKE_EXE%" "-DDKCOMMAND=%DKCOMMAND% -DDKSCRIPT_PATH=%DKSCRIPT_PATH% -DQUEUE_BUILD=ON -DDKCMAKE_FUNCTIONS_DIR_=%DKCMAKE_FUNCTIONS_DIR_% -P "%DKCMAKE_DIR%/DKEval.cmake"') do (

    # Call DKCmake function
    set(DKCMAKE_COMMAND=${CMAKE_EXE} -DDKCOMMAND=${DKCOMMAND} -DDKSCRIPT_PATH=${DKSCRIPT_PATH} -DQUEUE_BUILD=ON -DDKCMAKE_FUNCTIONS_DIR_=${DKCMAKE_FUNCTIONS_DIR_} -P ${DKCMAKE_DIR}/DKEval.cmake)
    #echo ${DKCMAKE_COMMAND}    
    execute_process(COMMAND ${DKCMAKE_COMMAND} WORKING_DIRECTORY "${DKCMAKE_FUNCTIONS_DIR}" OUTPUT_VARIABLE rtn_value ECHO_OUTPUT_VARIABLE OUTPUT_STRIP_TRAILING_WHITESPACE)
    #dk_echo("rtn_value = ${rtn_value}")
    
	if("${LAST_ARG}" STREQUAL "rtn_var")
        set(${LAST_ARG} "${rtn_value}" PARENT_SCOPE)
        execute_process(COMMAND ${CMAKE_COMMAND} -E echo "${rtn_value}")
    endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc("\${ARGV}")
    
    dk_callDKCmake(dk_test "FROM DKCmake" "dk_callDKCmake.cmake" rtn_var)
	dk_echo()
    dk_echo("rtn_var = ${rtn_var}")
endfunction()

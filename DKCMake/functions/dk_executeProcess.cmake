include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")


###############################################################################
# dk_executeProcess(commands) NOASSERT
#
#	TODO
#
#	@commands	- TODO
#	@NOASSERT	- will not halt cmake if an error occurs
#
function(dk_executeProcess commands) #NOASSERT #NOECHO
	DKDEBUGFUNC(${ARGV})

	dk_includes("${ARGV}" "NOASSERT" NOASSERT)
	dk_includes("${ARGV}" "NOECHO" NOECHO)
	
	set(commands ${ARGV})
	
	### DO NOT DO THIS ###
	#string(REPLACE ";" " " ARGV "${ARGV}")

	if(NOT ${NOECHO})
		string(REPLACE ";" " " print_commands "${ARGV}")
		dk_info("\n${CLR}${magenta} dk_executeProcess> ${print_commands}\n")
	endif()

	list(REMOVE_ITEM commands NOASSERT)
	list(REMOVE_ITEM commands NOECHO)
	list(REMOVE_ITEM commands COMMAND)
	list(REMOVE_ITEM commands "cmd /c ")
	
	if(NOT CURRENT_DIR)
		set(CURRENT_DIR ${DKCMAKE})
	endif()
	
	list(FIND commands "WORKING_DIRECTORY" index)
	if(index EQUAL -1)
		set(commands ${commands} WORKING_DIRECTORY ${CURRENT_DIR}) # add WORKING_DIRECTORY if missing
	endif()
	
	if(MSVC)	#FIXME: detect cmd instead of msvc
		execute_process(COMMAND cmd /c ${commands} RESULT_VARIABLE result ERROR_VARIABLE error) # FIXME: Do we always need  cmd /c  here?
	else()
		execute_process(COMMAND ${commands} RESULT_VARIABLE result ERROR_VARIABLE error)
	endif()

	if(NOT ${result} EQUAL 0)
		execute_process(COMMAND ${CMAKE_COMMAND} -E sleep 2) # wait 2 seconds for the stdout to flush before printing error
		dk_error(" 							" NOASSERT)
		dk_error("path    = ${CURRENT_DIR}	" NOASSERT)
		dk_error("command = ${commands}		" NOASSERT)
		dk_error("result  = ${result}		" NOASSERT)     
		dk_error("error   = ${error}		" NOASSERT)
		dk_error(" 							" ${NOASSERT})
	endif()
endfunction()
dk_createOsMacros("dk_executeProcess")
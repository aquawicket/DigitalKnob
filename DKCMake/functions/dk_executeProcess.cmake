include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")


###############################################################################
# dk_executeProcess(commands) NOASSERT NOECHO OUTPUT <output_variable>
#
#	TODO
#
#	@commands	- TODO
#	@NOASSERT	- will not halt cmake if an error occurs
#
function(dk_executeProcess) #commands NOASSERT #NOECHO
	DKDEBUGFUNC(${ARGV})

	dk_get_option(NOASSERT ${ARGV})
	dk_get_option(NOECHO ${ARGV})
	dk_get_option_value(OUTPUT_VARIABLE ${ARGV})
	if(OUTPUT_VARIABLE)
		set(EXTRA_ARGS ${EXTRA_ARGS} OUTPUT_VARIABLE ${OUTPUT_VARIABLE})
	endif()
	dk_get_option_value(WORKING_DIRECTORY ${ARGV})
	if(WORKING_DIRECTORY)
		set(EXTRA_ARGS ${EXTRA_ARGS} WORKING_DIRECTORY ${WORKING_DIRECTORY})
	endif()
	

	set(commands ${ARGV})
	
	### DO NOT DO THIS ###
	#string(REPLACE ";" " " ARGV "${ARGV}")

	if(NOT ${NOECHO})
		string(REPLACE ";" " " print_commands "${ARGV}")
		dk_info("\n${CLR}${magenta} dk_executeProcess> ${print_commands}\n")
	endif()

	list(REMOVE_ITEM commands COMMAND)
	list(REMOVE_ITEM commands "cmd /c ")
	
	#list(FIND commands "WORKING_DIRECTORY" index)
	#if(index EQUAL -1)
	#	set(EXTRA_ARGS ${EXTRA_ARGS} WORKING_DIRECTORY ${CURRENT_DIR}) # add WORKING_DIRECTORY if missing
	#endif()
	
	if(OUTPUT_VARIABLE)
		set(EXTRA_ARGS ${EXTRA_ARGS} OUTPUT_VARIABLE ${OUTPUT_VARIABLE})
	endif()
	
	set(EXTRA_ARGS ${EXTRA_ARGS} RESULT_VARIABLE result)
	set(EXTRA_ARGS ${EXTRA_ARGS} ERROR_VARIABLE error)
	set(EXTRA_ARGS ${EXTRA_ARGS} OUTPUT_STRIP_TRAILING_WHITESPACE)
	
	if(MSVC)	#FIXME: detect cmd instead of msvc
		execute_process(COMMAND cmd /c ${commands} ${EXTRA_ARGS})
	else()
		execute_process(COMMAND ${commands} ${EXTRA_ARGS})
	endif()
	
	if(OUTPUT_VARIABLE)
		set(${OUTPUT_VARIABLE} ${${OUTPUT_VARIABLE}} PARENT_SCOPE)
	endif()

	if(NOT ${result} EQUAL 0)
		dk_sleep(2) # wait 2 seconds for the stdout to flush before printing error
		dk_error(" 							" NOASSERT)
		dk_error("path    = ${CURRENT_DIR}	" NOASSERT)
		dk_error("command = ${commands}		" NOASSERT)
		dk_error("result  = ${result}		" NOASSERT)
		dk_error("output  = ${output}		" NOASSERT) 		
		dk_error("error   = ${error}		" NOASSERT)
		if(NOT ${NOASSERT})
			dk_error("")
		endif()
	endif()
endfunction()
dk_createOsMacros("dk_executeProcess")

include_guard()

###############################################################################
# dk_getCmakeCommandLine(RESULT)
#	
#	TODO
#
#	@RESULT			- TODO
#
function(dk_getCmakeCommandLine RESULT)
	DKDEBUGFUNC(${ARGV})
	if(NOT CMAKE_ARGC)
		dk_info("dk_getCmakeCommandLine(): CMAKE_ARGC not set")
		dk_info("CMAKE_ARG variables are only set in cmake script mode")
		return()
	endif()
	
	set(PASSED_PARAMETERS "") # it will contain all params string
	set(ARG_NUM 1) # current index, starting with 1 (0 ignored)
	#math(EXPR ARGC_COUNT "${CMAKE_ARGC}")
	set(ARGC_COUNT "${CMAKE_ARGC}")
	
	while(ARG_NUM LESS ARGC_COUNT)	
		set(CURRENT_ARG ${CMAKE_ARGV${ARG_NUM}})					# making current arg named "CMAKE_ARGV" + "CURRENT_INDEX"
		set(PASSED_PARAMETERS ${PASSED_PARAMETERS} ${CURRENT_ARG})  # adding current param to the list
		math(EXPR ARG_NUM "${ARG_NUM}+1") 							# incrementing current index
	endwhile()
	
	dk_debug(PASSED_PARAMETERS	PRINTVAR)
	dk_wait()
	
	set(${RESULT} "${PASSED_PARAMETERS}" PARENT_SCOPE) #return RESULT
endfunction()
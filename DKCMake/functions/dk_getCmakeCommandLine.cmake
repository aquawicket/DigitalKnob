include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_getCmakeCommandLine(rtn_var)
#	
#	TODO
#
#	@rtn_var			- TODO
#
function(dk_getCmakeCommandLine rtn_var)
	dk_debugFunc(${ARGV})
	
	if(NOT CMAKE_ARGC)
		dk_info("dk_getCmakeCommandLine(): CMAKE_ARGC not set")
		dk_info("CMAKE_ARG variables are only set in cmake script mode")
		return()
	endif()
	
	set(cmakeCommandLine "") # it will contain all params string
	set(ARG_NUM 1) # current index, starting with 1 (0 ignored)
	#math(EXPR ARGC_COUNT "${CMAKE_ARGC}")
	set(ARGC_COUNT "${CMAKE_ARGC}")
	
	while(ARG_NUM LESS ARGC_COUNT)	
		set(CURRENT_ARG ${CMAKE_ARGV${ARG_NUM}})					# making current arg named "CMAKE_ARGV" + "CURRENT_INDEX"
		set(cmakeCommandLine ${cmakeCommandLine} ${CURRENT_ARG})  # adding current param to the list
		math(EXPR ARG_NUM "${ARG_NUM}+1") 							# incrementing current index
	endwhile()
	
	dk_debug(cmakeCommandLine)
	dk_wait()
	
	dk_printVar()
	set(${rtn_var} "${cmakeCommandLine}" PARENT_SCOPE) #return rtn_var
endfunction()





function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction(DKTEST)
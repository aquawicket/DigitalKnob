include_guard()

###############################################################################
# dk_make(path lib)
#
#	TODO
#
#	@path 				- TODO
#	@lib (optional)		- TODO
#
function(dk_make path) #lib
	DKDEBUGFUNC(${ARGV})
	
	if(NOT EXISTS ${path})
		dk_error("dk_make(${path}) path does not exist")
	endif()
	
	# https://github.com/emscripten-core/emscripten/issues/2005#issuecomment-32162107
	if(EMSCRIPTEN)
		dk_error("No proper dk_make() implemented for emscripten" NOASSERT)
		dk_set(EMMAKE ${EMSDK}/upstream/emscripten/emmake)
		dk_set(CURRENT_DIR ${path}/${BUILD_DIR})
		
		#set(lib ${ARGV1})
		#if(${ARGC} GREATER 1)
		#	dk_queueCommand(${EMMAKE} make ${lib})
		#else()
		#	dk_queueCommand(${EMMAKE} make)
		#endif()
		
		DEBUG_dk_queueCommand(${CMAKE_COMMAND} --build . --config Debug)
		RELEASE_dk_queueCommand(${CMAKE_COMMAND} --build . --config Release)
	else()
		set(lib ${ARGV1})
		#dk_set(CURRENT_DIR ${path}/${BUILD_DIR})
		if(${ARGC} GREATER 1)
			#dk_queueCommand(make ${lib})
			dk_queueCommand(${CMAKE_MAKE_PROGRAM} ${lib})
		else()
			#dk_queueCommand(make)
			dk_queueCommand(${CMAKE_MAKE_PROGRAM})
		endif()
	endif()
endfunction()
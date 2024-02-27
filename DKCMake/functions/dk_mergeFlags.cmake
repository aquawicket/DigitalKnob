include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")


###############################################################################
# dk_mergeFlags(args RESULT)
#
#	TODO
#
#	@args		- TODO
#	@RESULT		- TODO
#
function(dk_mergeFlags args RESULT)
	DKDEBUGFUNC(${ARGV})
	set(args ${args} ${RESULT} ${ARGN})
	list(GET args -1 RESULT)
	list(REMOVE_AT args -1)
	set(search "-DCMAKE_C_FLAGS=" "-DCMAKE_C_FLAGS_DEBUG=" "-DCMAKE_C_FLAGS_RELEASE=" "-DCMAKE_CXX_FLAGS=" "-DCMAKE_CXX_FLAGS_DEBUG=" "-DCMAKE_CXX_FLAGS_RELEASE=" "CFLAGS=" "CXXFLAGS=")
	foreach(word ${search})
		set(DK_${word} "${word}")
		if(MSYS)
			set(DK_${word} "${DK_${word}}'")
		endif()
		set(index 0)
		set(placeholder 0)
		foreach(arg ${args})
			math(EXPR index "${index}+1")
			string(FIND ${arg} ${word} hasWord)
			if(${hasWord} GREATER -1)
				if(${placeholder} EQUAL 0)
					math(EXPR placeholder "${index}-1")
				endif()				
				list(REMOVE_ITEM args ${arg})
				string(REPLACE ${word} "" arg ${arg})
				if(DK_${word} STREQUAL "${word}" OR DK_${word} STREQUAL "${word}'")
					set(DK_${word} "${DK_${word}}${arg}")
				else()
					set(DK_${word} "${DK_${word}} ${arg}")
				endif()
			endif()
		endforeach()
		if(MSYS)
			set(DK_${word} "${DK_${word}}'")
		endif()
		if(${placeholder} GREATER 0)
			list(LENGTH args args_length)
			if(${placeholder} GREATER ${args_length})
				math(EXPR placeholder "${args_length}-1")
			endif()

			list(INSERT args ${placeholder} "${DK_${word}}")	# https://stackoverflow.com/a/61948012
		endif()
	endforeach()
	set(${RESULT} ${args} PARENT_SCOPE)
endfunction()
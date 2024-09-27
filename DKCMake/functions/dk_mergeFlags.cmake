#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_mergeFlags(args rtn_var)
#
#	TODO
#
#	@args		- TODO
#	@rtn_var		- TODO
#
function(dk_mergeFlags args rtn_var)
	dk_debugFunc("\${ARGV}")
	
	#dk_debug("BEFORE: dk_mergeFlags(${ARGV})")
	set(args ${args} ${rtn_var} ${ARGN})
	list(GET args -1 rtn_var)
	list(REMOVE_AT args -1)
	set(search "-DCMAKE_C_FLAGS=" "-DCMAKE_C_FLAGS_DEBUG=" "-DCMAKE_C_FLAGS_RELEASE=" "-DCMAKE_CXX_FLAGS=" "-DCMAKE_CXX_FLAGS_DEBUG=" "-DCMAKE_CXX_FLAGS_RELEASE=" "-DCMAKE_EXE_LINKER_FLAGS=" "CFLAGS=" "CXXFLAGS=")
	foreach(word ${search})
		set(DK_${word} "${word}")
		if(MINGW)
		#	set(DK_${word} "${DK_${word}}'")	# NOTE:  This issue is related to DKBuildFlags.cmake:736
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
				dk_replaceAll(${arg} ${word} "" arg)
				if(DK_${word} STREQUAL "${word}" OR DK_${word} STREQUAL "${word}'")
					set(DK_${word} "${DK_${word}}${arg}")
				else()
					set(DK_${word} "${DK_${word}} ${arg}")
				endif()
			endif()
		endforeach()
		if(MINGW)
		#	set(DK_${word} "${DK_${word}}'")	# NOTE:  This issue is related to DKBuildFlags.cmake:736
		endif()
		if(${placeholder} GREATER 0)
			list(LENGTH args args_length)
			if(${placeholder} GREATER ${args_length})
				math(EXPR placeholder "${args_length}-1")
			endif()

			list(INSERT args ${placeholder} "${DK_${word}}")	# https://stackoverflow.com/a/61948012
		endif()
	endforeach()

	set(${rtn_var} ${args} PARENT_SCOPE)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()
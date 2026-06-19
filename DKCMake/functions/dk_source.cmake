#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
# dk_source(filepath)
#
#
function(dk_source)
	if("${PrintArgData}" STREQUAL "1")
		message(" ")
		message("###### dk_source() ${CMAKE_CURRENT_FUNCTION} ######")
		#set(ARGV "${ARGV}")
		#set(ARGN "${ARGN}")
		
		message(" ARGV = ${ARGV}")
		set(n 0)
		foreach(arg IN LISTS ARGV)
			message("ARGV${n} = ${arg}")
			math(EXPR n "${n}+1")
		endforeach()
		message(" ARGC = ${ARGC}")
		
		message(" ARGN = ${ARGN}")
		set(ARGNC 0)
		foreach(arg IN LISTS ARGN)
			message("ARGV${ARGNC} = ${arg}")
			math(EXPR ARGNC "${ARGNC}+1")
		endforeach()
		message("ARGNC = ${ARGNC}")
		dk_printArgData()
	endif()
	
	#execute_process(COMMAND ${CMAKE_COMMAND} -E echo_append "myVar = '${myVar}'")
	
#	if(COMMAND dk_debugFunc)
#		dk_debugFunc(1)
#	endif()

#	message("ARGV = ${ARGV}")
#	string(REPLACE "(" ";" _args_ "${ARGV};")	
#	list(GET _args_ 0 func)
#	message("func = ${func}")
	
	set(func "${ARGV0}")
	
	
	# load if it's an existing full file path
#	if(EXISTS ${func})
#		#include(${func})
#		dk_load(${func})
#		return()
#	endif()
	
	# If it's a dk_function, download if it doesn't exist then load it
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}${func}.cmake")
		message(downloading ${func} . . .)
		if(COMMAND dk_download)
			dk_download("${DKHTTP_DKCMAKE_FUNCTIONS_DIR}/${func}.cmake" "$ENV{DKCMAKE_FUNCTIONS_DIR_}${func}.cmake")
		else()
			message("dk_download not loaded")
		endif()
	endif()
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}${func}.cmake")
		message("ERROR: failed to download ${func}") 
	endif()

	if(COMMAND dk_load)
		dk_load("$ENV{DKCMAKE_FUNCTIONS_DIR_}${func}.cmake")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}${func}.cmake")
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	if(COMMAND dk_debugFunc)
		dk_debugFunc(0)
	endif()
	
	dk_source("dk_info") 
	dk_info("test message using dk_source to download it first")
endfunction()

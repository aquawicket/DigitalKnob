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
# dk_printArgData()
#
#	Print the current CMake scripte path and ARG* variables
#
macro(dk_printArgData)
	
	set(argc 0)
	unset(argv)
	foreach(arg IN LISTS ARGV)
		set(argv${argc} ${arg})
		list(APPEND argv ${arg})
		math(EXPR argc "${argc}+1")
	endforeach()
	
	set(argnc 0)
	unset(argn)
	foreach(arg IN LISTS ARGN)
		set(argn${argnc} ${arg})
		list(APPEND argn ${arg})
		math(EXPR argnc "${argnc}+1")
	endforeach()
	



	if("${PrintArgData}" STREQUAL "1")
		message("")
		message("CMAKE_CURRENT_FUNCTION           = ${CMAKE_CURRENT_FUNCTION}")
		message("CMAKE_CURRENT_FUNCTION_LIST_FILE = ${CMAKE_CURRENT_FUNCTION_LIST_FILE}")
		message("CMAKE_CURRENT_LIST_FILE          = ${CMAKE_CURRENT_LIST_FILE}")
		message("CMAKE_SCRIPT_MODE_FILE           = ${CMAKE_SCRIPT_MODE_FILE}")
		
		message(" argv = ${argv}")
		execute_process(COMMAND ${CMAKE_COMMAND} -E echo_append " argv = ")
		message(${argv})
		set(n 0)
		foreach(arg IN LISTS argv)
			message("argv${n} = ${argv${n}}")
			math(EXPR n "${n}+1")
		endforeach()
		message(" argc = ${argc}")

		message(" argn = ${argn}")
		execute_process(COMMAND ${CMAKE_COMMAND} -E echo_append " argn = ")
		message(${argn})
		set(n 0)
		foreach(arg IN LISTS argn)
			message("argn${n} = ${argn${n}}")
			math(EXPR n "${n}+1")
		endforeach()
		message("argnc = ${argnc}")
	endif()
endmacro()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()
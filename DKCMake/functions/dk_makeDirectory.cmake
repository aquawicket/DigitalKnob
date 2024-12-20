#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_makeDirectory(path)
#
#	Create a directory 
#
#	@path	- The full path to the direcotory to be created
#
function(dk_makeDirectory)
	dk_debugFunc()
	if(NOT ${ARGC} EQUAL 1)
		dk_error("dk_makeDirectory(${ARGV}): incorret numer of arguments:${ARGC}")
	endif()
	
	set(path ${ARGV0})
	make_directory("${path}")  # requires full path
	dk_return()
	
	# build missing directory parents recursivley
#	if(MAC_HOST)
#		file(RELATIVE_PATH rel_path "${DIGITALKNOB_DIR}/DK" ${path})
#		dk_info("RELATIVE_PATH(${path}) OF (${DIGITALKNOB_DIR}/DK) =-> ${rel_path}")
#		dk_info("MAKE_DIRECTORY ${rel_path}")
#		file(MAKE_DIRECTORY ${rel_path})
#	else()
#		dk_replaceAll(${path} "/" ";" path_list)
#		foreach(item ${path_list})
#			dk_replaceAll(${item} "home" "/home" item)
#			if(path2)
#				set(path2 "${path2}/${item}")
#				if(NOT EXISTS ${path2})
#					file(MAKE_DIRECTORY ${path2})
#				endif()
#			else()
#				set(path2 "${item}")
#			endif()
#		endforeach()
#	endif()
endfunction()
dk_createOsMacros("dk_makeDirectory")





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_makeDirectory("C:/test")
endfunction()
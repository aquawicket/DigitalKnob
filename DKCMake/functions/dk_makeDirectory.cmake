include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_makeDirectory(path)
#
#	Create a directory 
#
#	@path	- The full path to the direcotory to be created
#
function(dk_makeDirectory path)
	dk_debugFunc("\${ARGV}")
	
	make_directory("${path}")  # requires full path
	return()
	
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
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()
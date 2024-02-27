include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")


##################################################################################
# dk_load(filename)
#
#	load a ${filename}.cmake file located in the DKCMake path 
#
#	@filename	- TODO
#
macro(dk_load filename)
	if(EXISTS ${DKCMAKE}/${filename}.cmake)
		include(${DKCMAKE}/${filename}.cmake)
	elseif(EXISTS ${DKCMAKE}/functions/${filename}.cmake)
		include(${DKCMAKE}/functions/${filename}.cmake)
	else()
		message(FATAL_ERROR "${filename}.cmake: file not found")
	endif()
endmacro()

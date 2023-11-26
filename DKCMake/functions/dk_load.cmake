include_guard()

##################################################################################
# dk_load(filename)
#
#	load a ${filename}.cmake file located in the DKCMake path 
#
#	@filename	- TODO
#
macro(dk_load filename)
	if(NOT EXISTS ${DKCMAKE}/${filename}.cmake)
		message(FATAL_ERROR "${DKCMAKE}/${filename}.cmake: file not found")
	endif()
	include(${DKCMAKE}/${filename}.cmake)
endmacro()

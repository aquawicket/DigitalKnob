include_guard()

##################################################################################
# dk_load(filename)
#
#	load a ${filename}.cmake file located in the DKCMake path 
#
#	@filename	- TODO
#
macro(dk_load filename)
	if(NOT EXISTS ${DKCMAKE_DIR})
		message(FATAL_ERROR "DKCMAKE_DIR does not exist!  \n    DKCMAKE_DIR = ${DKCMAKE_DIR} \n")
	endif()

	if(EXISTS ${DKCMAKE_DIR}/${filename}.cmake)
		include(${DKCMAKE_DIR}/${filename}.cmake)
	elseif(EXISTS ${DKCMAKE_DIR}/functions/${filename}.cmake)
		include(${DKCMAKE_DIR}/functions/${filename}.cmake)
	else()
		message(FATAL_ERROR "${filename}.cmake: file not found")
	endif()
endmacro()

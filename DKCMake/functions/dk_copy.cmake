#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_copy(from to) OVERWRITE NO_HALT
#
#	Copy a file or directory to another location
#
#	@from		- The source path to copy
#	@to			- The destination path to copy to
#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing files is enabled
#   NO_HALT     - if any of the parameters equals NO_HALT, dk_fatal() messages will not be displayed
#
function(dk_copy from to) # OVERWRITE NO_HALT
	dk_debugFunc()
	
	dk_getParameter(OVERWRITE)
	dk_getParameter(NO_HALT)
	
	if(EXISTS ${from})
		if(IS_DIRECTORY ${from})
			file(GLOB_RECURSE allfiles RELATIVE "${from}/" "${from}/*")
			foreach(each_file ${allfiles})
				if(${each_file} STREQUAL "DKINSTALL.cmake")
					continue()
				endif()
				if(${each_file} STREQUAL "DKINSTALL.cmake.BACKUP")
					continue()
				endif()
				set(sourcefile "${from}/${each_file}")
				set(destinationfile "${to}/${each_file}")
				if(OVERWRITE)
					execute_process(COMMAND ${CMAKE_COMMAND} -E compare_files ${sourcefile} ${destinationfile} RESULT_VARIABLE compare_result)
					if("${compare_result}" STREQUAL "1")
						execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${sourcefile} ${destinationfile})
						dk_info("COPIED: ${sourcefile} to ${destinationfile}")
					elseif("${compare_result}" STREQUAL "0")
#						dk_info("${sourcefile} No Copy, The files are identical.")
					else()
						dk_fatal( "dk_copy(${from} ${to} ${OVERWRITE}): \n ERROR: compare_result = ${compare_result}")
					endif()
				elseif(NOT EXISTS ${destinationfile})
					execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${sourcefile} ${destinationfile})
					dk_info("COPIED: ${sourcefile} to ${destinationfile}")
				endif()
			endforeach()
		else()
			if(OVERWRITE)
				execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${from} ${to})
				dk_info("COPIED: ${from} to ${to}")
			elseif(NOT EXISTS ${to})
				execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${from} ${to})
				dk_info("COPIED: ${from} to ${to}")
			endif()
		endif()
	else()
		if(NOT NO_HALT)
			dk_fatal("from:(${from}) The source path does not exist")
		endif()
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_copy("C:/Windows/System32/vcomp140d.dll" "C:/Users/Administrator/digitalknob/Development/3rdParty/imagemagick-7.1.1-43-portable-q16-x64/vcomp140.dll")
endfunction()
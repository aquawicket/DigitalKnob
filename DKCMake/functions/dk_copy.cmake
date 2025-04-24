#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

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
	
<<<<<<< HEAD
	dk_getOption(OVERWRITE ${ARGV})
	dk_getOption(NO_HALT ${ARGV})
=======
	dk_getOption(OVERWRITE)
	dk_getOption(NO_HALT)
>>>>>>> Development
	
	if(EXISTS ${from})
		if(IS_DIRECTORY ${from})
			file(GLOB_RECURSE allfiles RELATIVE "${from}/" "${from}/*")
			foreach(each_file ${allfiles})
<<<<<<< HEAD
				if(${each_file} STREQUAL "DKMAKE.cmake")
					continue()
				endif()
				if(${each_file} STREQUAL "DKMAKE.cmake.BACKUP")
=======
				if(${each_file} STREQUAL "DKINSTALL.cmake")
					continue()
				endif()
				if(${each_file} STREQUAL "DKINSTALL.cmake.BACKUP")
>>>>>>> Development
					continue()
				endif()
				set(sourcefile "${from}/${each_file}")
				set(destinationfile "${to}/${each_file}")
				if(OVERWRITE)
					execute_process(COMMAND ${CMAKE_COMMAND} -E compare_files ${sourcefile} ${destinationfile} RESULT_VARIABLE compare_result)
<<<<<<< HEAD
					if(compare_result EQUAL 1)
						execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${sourcefile} ${destinationfile})
						dk_info("COPIED: ${sourcefile} to ${destinationfile}")
					elseif(compare_result EQUAL 0)
=======
					if("${compare_result}" STREQUAL "1")
						execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${sourcefile} ${destinationfile})
						dk_info("COPIED: ${sourcefile} to ${destinationfile}")
					elseif("${compare_result}" STREQUAL "0")
>>>>>>> Development
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
<<<<<<< HEAD
dk_createOsMacros("dk_copy")
=======
>>>>>>> Development





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_todo()
=======
	dk_debugFunc(0)
	
	dk_copy("C:/Windows/System32/vcomp140d.dll" "C:/Users/Administrator/digitalknob/Development/3rdParty/imagemagick-7.1.1-43-portable-q16-x64/vcomp140.dll")
>>>>>>> Development
endfunction()
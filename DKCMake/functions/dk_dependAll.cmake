include_guard()

###############################################################################
# dk_dependAll()
#
#	TODO
#
function(dk_dependAll)
	DKDEBUGFUNC(${ARGV})
	set(DEPENDALL_FILE "")
	
	if(IS_DIRECTORY ${DKIMPORTS_DIR})
		file(GLOB allfiles RELATIVE "${DKIMPORTS_DIR}/" "${DKIMPORTS_DIR}/*")
		foreach(each_file ${allfiles})
			if(EXISTS ${DKIMPORTS_DIR}/${each_file}/DKMAKE.cmake)
				set(DEPENDALL_FILE ${DEPENDALL_FILE} "dk_depend(${each_file})\n")
			endif()
		endforeach()
    endif()
	
	# Find all DKPlugins Folders from DKBRANCH root
	file(GLOB children RELATIVE ${DKBRANCH_DIR}/ ${DKBRANCH_DIR}/*)
  	foreach(child ${children})
		if(EXISTS ${DKPLUGINS_DIR})
			file(GLOB plugins RELATIVE ${DKBRANCH_DIR}/${child}/DKPlugins/ ${DKBRANCH_DIR}/${child}/DKPlugins/*)
			foreach(plugin ${plugins})
				if(EXISTS ${DKBRANCH_DIR}/${child}/DKPlugins/${plugin}/DKMAKE.cmake)
					if(NOT ${plugin} STREQUAL "_DKIMPORT")
						set(DEPENDALL_FILE ${DEPENDALL_FILE} "dk_depend(${plugin})\n")
					endif()
				endif()
			endforeach()
		endif()
  	endforeach()
	
	# To exclude libraries, use dk_disable(lib) in your app DKMAKE.cmake file or in DKDisabled.cmake
	string (REPLACE ";" "" DEPENDALL_FILE "${DEPENDALL_FILE}")
	file(WRITE ${DK_PROJECT_DIR}/DEPEND_ALL.txt "${DEPENDALL_FILE}")
	unset(DEPENDALL_FILE)
	INCLUDE(${DK_PROJECT_DIR}/DEPEND_ALL.txt)
endfunction()
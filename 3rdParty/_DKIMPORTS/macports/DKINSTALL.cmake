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


############ macports ############
# https://guide.macports.org/#installing.macports
# https://github.com/macports/macports-base
# https://github.com/macports/macports-base/releases
# https://github.com/macports/macports-base/releases/download/v2.7.1/MacPorts-2.7.1-11-BigSur.pkg

if(NOT Mac_Host)
	return()
endif()

dk_importVariables("${macports${Host_Tuple}_Import}" IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR})

if(NOT EXISTS ${macports_Url})
	dk_download(${macports_Url})		
	dk_exec(chmod +x ${dk_download})
	#dk_exec(${DKDOWNLOAD_DIR}/MacPorts-2.7.1-11-BigSur.pkg) #FIXME
endif()

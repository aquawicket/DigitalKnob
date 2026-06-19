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


############ far ############
# http://findandreplace.sourceforge.net/
# https://sourceforge.net/projects/findandreplace/files/latest/download
# https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-win.zip/download
# https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-osx.zip/download
# https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-x.tar.gz/download
# https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-sources.tar.gz/download
# https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-win.zip

if(NOT Windows_Host)
	dk_disable(far)
	dk_return()
endif()

dk_import()

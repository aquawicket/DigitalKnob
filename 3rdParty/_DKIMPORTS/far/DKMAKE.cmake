#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# http://findandreplace.sourceforge.net/
# https://sourceforge.net/projects/findandreplace/files/latest/download
# https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-win.zip/download
# https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-osx.zip/download
# https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-x.tar.gz/download
# https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-sources.tar.gz/download
if(NOT WIN_HOST)
	dk_undepend(far)
	dk_return()
endif()


### IMPORT ###
dk_validate(DK3RDPARTY_DIR "dk_DKBRANCH_DIR()")
dk_import(https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-win.zip ${DK3RDPARTY_DIR}/FAR-2.0.3-win)

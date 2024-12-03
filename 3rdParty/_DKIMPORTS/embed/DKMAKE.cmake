#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ embed ############
# https://github.com/batterycenter/embed



### DEPENDS ###
#dk_depend(libname)

### INSTALL ###
#dk_validate			(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
#dk_getFileParam	(${DKIMPORTS_DIR}/[lib_name]/[lib_name].txt [LIB_NAME]_IMPORT)
dk_import			("https://github.com/batterycenter/embed/archive/465081903d97ff1ed05e1fd5d0b3c8032a4a26a6.zip")

### LINK ###
dk_include			(${EMBED}/include)
if(UNIX)
	dk_libDebug		(${EMBED_DEBUG_DIR}/libembed.a)
	dk_libRelease	(${EMBED_RELEASE_DIR}/libembed.a)
else()
	dk_libDebug		(${EMBED_DEBUG_DIR}/libembed.lib)
	dk_libRelease	(${EMBED_RELEASE_DIR}/libembed.lib)
endif()

### GENERATE ###
dk_configure(${EMBED})


### COMPILE ###
dk_build(${EMBED})

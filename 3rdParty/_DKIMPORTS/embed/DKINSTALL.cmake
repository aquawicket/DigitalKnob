#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ embed ############
# https://github.com/batterycenter/embed



### DEPENDS ###
#dk_depend(libname)

### INSTALL ###
#dk_validate			(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
#dk_getFileParams	("$ENV{DKIMPORTS_DIR}/[lib_name]/dkconfig.txt")
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

#/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### embed ######
# https://github.com/MKlimenko/embed
# https://github.com/MKlimenko/embed/archive/refs/heads/master.zip

### INSTALL ###
dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import		(${EMBED_IMPORT} NAME embed)

dk_depend(tbb)


### LINK ###
dk_include			(${EMBED}/include)
if(MSVC)
	dk_libDebug		(${EMBED_DEBUG_DIR}/embed.lib)
	dk_libRelease	(${EMBED_RELEASE_DIR}/embed.lib)
else()
	dk_libDebug		(${EMBED_DEBUG_DIR}/libembed.a)
	dk_libRelease	(${EMBED_RELEASE_DIR}/libembed.a)
endif()

### GENERATE ###
dk_set(CURRENT_PLUGIN "EMBED")
dk_configure(${EMBED} ${TBB_CMAKE}) # -fexperimental-library


### COMPILE ###
dk_build(${EMBED})
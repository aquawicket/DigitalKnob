#/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### CMakeRC ######
# https://github.com/vector-of-bool/cmrc
# https://github.com/vector-of-bool/cmrc/archive/refs/heads/master.zip
# https://vector-of-bool.github.io/2017/01/21/cmrc.html

### INSTALL ###
dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import		(${CMAKERC_IMPORT} NAME CMakeRC)



### LINK ###
dk_include			(${CMAKERC}/include)
if(MSVC)
	dk_libDebug		(${CMAKERC_DEBUG_DIR}/cmakerc.lib)
	dk_libRelease	(${CMAKERC_RELEASE_DIR}/cmakerc.lib)
else()
	dk_libDebug		(${CMAKERC_DEBUG_DIR}/libcmakerc.a)
	dk_libRelease	(${CMAKERC_RELEASE_DIR}/libcmakerc.a)
endif()

### GENERATE ###
dk_configure(${CMAKERC})


### COMPILE ###
dk_build(${CMAKERC})
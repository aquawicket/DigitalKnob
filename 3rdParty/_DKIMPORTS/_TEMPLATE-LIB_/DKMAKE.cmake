########################################################################################
# Remove these lines and rename all instaces of _TEMPLATE-APP_ to the name of your library
dk_undepend(_TEMPLATE-LIB_)
dk_return()
########################################################################################

#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### [lib_name] ######
# http://www.[lib_name].com
# https://github.com/organization/[lib_name]

### DEPENDS ###
#dk_depend(libname)

### INSTALL ###
dk_validate		(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
dk_getFileParam	(${DKIMPORTS_DIR}/[lib_name]/[lib_name].txt [LIB_NAME]_IMPORT)
dk_import		(${[LIB_NAME]})

### LINK ###
dk_include			(${[LIB_NAME]}/include)
UNIX_dk_libDebug	(${[LIB_NAME]_DEBUG_DIR}/libpackage.a)
UNIX_dk_libRelease	(${[LIB_NAME]_RELEASE_DIR}/libpackage.a)
WIN_dk_libDebug		(${[LIB_NAME]_DEBUG_DIR}/package.lib)
WIN_dk_libRelease	(${[LIB_NAME]_RELEASE_DIR}/package.lib)


### GENERATE ###
dk_configure(${[LIB_NAME]})


### COMPILE ###
dk_build(${[LIB_NAME]} package)

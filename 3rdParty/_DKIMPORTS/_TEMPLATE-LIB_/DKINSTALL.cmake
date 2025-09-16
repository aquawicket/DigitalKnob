########################################################################################
# Remove these lines and rename all instaces of [LIBNAME] to the name of your library
dk_disable(_TEMPLATE-LIB_)
dk_return()
########################################################################################

#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


###### [_lib_name_] ######
# http://www.[_lib_name_].com
# https://github.com/organization/[_lib_name_]

dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")

### DEPENDS ###
#dk_depend(libname)

### INSTALL ###
#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import			(${LIBNAME})

### LINK ###
dk_include			(${LIBNAME}/include)
if(MSVC)
	dk_libDebug		(${LIBNAME_Debug_Dir}/package.lib)
	dk_libRelease	(${LIBNAME_Release_Dir}/package.lib)
else()
	dk_libDebug		(${LIBNAME_Debug_Dir}/libpackage.a)
	dk_libRelease	(${LIBNAME_Release_Dir}/libpackage.a)
endif()

### GENERATE ###
dk_configure(${LIBNAME})


### COMPILE ###
dk_build(${LIBNAME} package)

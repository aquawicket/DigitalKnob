########################################################################################
# Remove these lines and rename all instaces of [_LIB_NAME_] to the name of your library
dk_undepend(_TEMPLATE-LIB_)
dk_return()
########################################################################################

#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### [_lib_name_] ######
# http://www.[_lib_name_].com
# https://github.com/organization/[_lib_name_]

### DEPENDS ###
#dk_depend(libname)

### INSTALL ###
dk_validate		(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam	($ENV{DKIMPORTS_DIR}/[_lib_name_]/dkconfig.txt _LIB_NAME_._IMPORT)
dk_import		(${_LIB_NAME_})

### LINK ###
dk_include			(${_LIB_NAME_}/include)
if(MSVC)
	dk_libDebug		(${_LIB_NAME_._DEBUG_DIR}/package.lib)
	dk_libRelease	(${_LIB_NAME_._RELEASE_DIR}/package.lib)
else()
	dk_libDebug		(${_LIB_NAME_._DEBUG_DIR}/libpackage.a)
	dk_libRelease	(${_LIB_NAME_._RELEASE_DIR}/libpackage.a)
endif()

### GENERATE ###
dk_configure(${_LIB_NAME_})


### COMPILE ###
dk_build(${_LIB_NAME_} package)

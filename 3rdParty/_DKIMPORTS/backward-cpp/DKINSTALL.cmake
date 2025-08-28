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


############ backward-cpp ############
# https://github.com/bombela/backward-cpp.git

### IMPORT ###
##dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
#dk_import			("${backward_cpp_Import}")
dk_import()

### LINK ###
dk_include			("${BACKWARD_CPP}")
#if(Unix)
#	dk_libDebug		("${BACKWARD_CPP_Debug_Dir}/libbackward.a")
#	dk_libRelease	("${BACKWARD_CPP_Release_Dir}/libbackward.a")
#elseif(Windows)
#	dk_libDebug		("${BACKWARD_CPP_Debug_Dir}/backward.lib")
#	dk_libRelease	("${BACKWARD_CPP_Release_Dir}/backward.lib")
#endif()



dk_validate(DKCPP_PLUGINS_DIR "dk_DKBRANCH_DIR()")
if("$ENV{WSL_DISTRO_NAME}" STREQUAL "Alpine")
	dk_delete("${DKCPP_PLUGINS_DIR}/DK/backward.cpp" NO_HALT)
elseif(Android)
	dk_delete("${DKCPP_PLUGINS_DIR}/DK/backward.cpp" NO_HALT)
else()
	dk_copy("${BACKWARD_CPP}/backward.cpp" "${DKCPP_PLUGINS_DIR}/DK/backward.cpp" OVERWRITE)
endif()

### GENERATE ###
#dk_configure()

### COMPILE ###
#dk_build()

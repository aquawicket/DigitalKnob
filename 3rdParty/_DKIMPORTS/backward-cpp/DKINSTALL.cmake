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


############ backward-cpp ############
# https://github.com/bombela/backward-cpp.git

### IMPORT ###
dk_import()

### LINK ###
dk_include			("${backward-cpp}")
#if(Unix)
#	dk_libDebug		("${backward-cpp_Debug_Dir}/libbackward.a")
#	dk_libRelease	("${backward-cpp_Release_Dir}/libbackward.a")
#elseif(Windows)
#	dk_libDebug		("${backward-cpp_Debug_Dir}/backward.lib")
#	dk_libRelease	("${backward-cpp_Release_Dir}/backward.lib")
#endif()



dk_validate(DKCPP_PLUGINS_DIR "dk_DKBRANCH_DIR()")
dk_assertPath("${DKCPP_PLUGINS_DIR}/DK")

if("$ENV{WSL_DISTRO_NAME}" STREQUAL "Alpine")
	dk_delete("${DKCPP_PLUGINS_DIR}/DK/backward.cpp" NO_HALT)
elseif(Android)
	dk_delete("${DKCPP_PLUGINS_DIR}/DK/backward.cpp" NO_HALT)
else()
	dk_assertPath("${backward-cpp}/backward.cpp")
	dk_copy("${backward-cpp}/backward.cpp" "${DKCPP_PLUGINS_DIR}/DK/backward.cpp" OVERWRITE)
endif()

### GENERATE ###
#dk_configure()

### COMPILE ###
#dk_build()

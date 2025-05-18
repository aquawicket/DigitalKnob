#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ backward-cpp ############
# https://github.com/bombela/backward-cpp.git

### IMPORT ###
dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams("$ENV{DKIMPORTS_DIR}/backward-cpp/dkconfig.txt")
dk_import		("${BACKWARD_CPP_IMPORT}")

### LINK ###
dk_include			("${BACKWARD_CPP_DIR}")
#if(UNIX)
#	dk_libDebug		("${BACKWARD_CPP_DEBUG_DIR}/libbackward.a")
#	dk_libRelease	("${BACKWARD_CPP_RELEASE_DIR}/libbackward.a")
#elseif(Windows)
#	dk_libDebug		("${BACKWARD_CPP_DEBUG_DIR}/backward.lib")
#	dk_libRelease	("${BACKWARD_CPP_RELEASE_DIR}/backward.lib")
#endif()



dk_validate(DKCPP_PLUGINS_DIR "dk_DKBRANCH_DIR()")
if("$ENV{WSL_DISTRO_NAME}" STREQUAL "Alpine")
	dk_delete("${DKCPP_PLUGINS_DIR}/DK/backward.cpp" NO_HALT)
elseif(ANDROID)
	dk_delete("${DKCPP_PLUGINS_DIR}/DK/backward.cpp" NO_HALT)
else()
	dk_copy("${BACKWARD_CPP_DIR}/backward.cpp" "${DKCPP_PLUGINS_DIR}/DK/backward.cpp" OVERWRITE)
endif()

### GENERATE ###
#dk_configure("${BACKWARD_CPP_DIR}")

### COMPILE ###
#dk_build("${BACKWARD_CPP_DIR}")

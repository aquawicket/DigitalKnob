#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ boxer ############
# https://github.com/aaronmjacobs/Boxer.git
dk_validate(target_triple "dk_target_triple()")
if(ANDROID OR RASPBERRY)
	dk_undepend(boxer)
	dk_return()
endif()

### DEPEND ###
dk_depend			(cocoa)
dk_depend			(libgtk-3-dev)

### IMPORT ###
dk_import			(https://github.com/aaronmjacobs/Boxer/archive/65e79c38.zip)

### LINK ###
dk_include			(${BOXER_DIR}/include)
dk_include			(${BOXER_CONFIG_DIR})

if(MSVC)
	dk_libDebug		(${BOXER_DEBUG_DIR}/Boxer.lib)
	dk_libRelease	(${BOXER_RELEASE_DIR}/Boxer.lib)
else()
	dk_libDebug		(${BOXER_DEBUG_DIR}/libBoxer.a)
	dk_libRelease	(${BOXER_RELEASE_DIR}/libBoxer.a)
endif()

### GENERATE ###
dk_configure		(${BOXER_DIR})

### COMPILE ###
dk_build			(${BOXER_DIR} Boxer)

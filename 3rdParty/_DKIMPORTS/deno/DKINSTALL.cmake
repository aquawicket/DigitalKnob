#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ deno ############
# https://github.com/denoland/deno



### INSTALL ###
dk_validate		(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam	($ENV{DKIMPORTS_DIR}/debo/dkconfig.txt DENO_IMPORT)
dk_import		(DENO_IMPORT)

### LINK ###
dk_include			(${DENO}/include)
if(MSVC)
	dk_libDebug		(${DENO_DEBUG_DIR}/deno.lib)
	dk_libRelease	(${DENO_RELEASE_DIR}/deno.lib)
else()
	dk_libDebug		(${DENO_DEBUG_DIR}/libdeno.a)
	dk_libRelease	(${DENO_RELEASE_DIR}/libdeno.a)
endif()

### GENERATE ###
dk_configure(${DENO})


### COMPILE ###
dk_build(${DENO})

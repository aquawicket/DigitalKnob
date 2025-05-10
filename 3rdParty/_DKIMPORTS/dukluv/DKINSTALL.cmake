#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ dukluv ############
# https://github.com/creationix/dukluv.git
# https://github.com/creationix/dukluv/archive/f02103bcadd5a5b9280b7a07064649d0a465f70c.zip

dk_load(dk_builder)

### DEPEND ###
dk_depend(duktape)
dk_depend(libuv)

### IMPORT ###
dk_validate				(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParams 		("$ENV{DKIMPORTS_DIR}/dukluv/dkconfig.txt")
dk_import				(${DUKLUV_DL})

### LINK ###
dk_include				(${DUKLUV}/include)
dk_include				(${DUKLUV}/${Target_Triple})
if(MSVC)
	WIN_dk_libDebug		(${DUKLUV_DEBUG_DIR}/dukluv.lib)
	WIN_dk_libRelease	(${DUKLUV_RELEASE_DIR}/dukluv.lib)
else()
	dk_libDebug			(${DUKLUV_DEBUG_DIR}/libdukluv.a)
	dk_libRelease		(${DUKLUV_RELEASE_DIR}/libdukluv.a)
endif()

### GENERATE ###
dk_configure			(${DUKLUV_DIR} ${DUKTAPE_CMAKE} ${LIBUV_CMAKE})

### COMPILE ###
dk_build				(${DUKLUV})

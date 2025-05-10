#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### smpeg2 ######
## https://github.com/icculus/smpeg.git
## https://www.libsdl.org/projects/smpeg/release/smpeg2-2.0.0.tar.gz

dk_load(dk_builder)

### DEPEND ###
dk_depend(sdl)
dk_depend(git)

### IMPORT ###
dk_import(https://www.libsdl.org/projects/smpeg/release/smpeg2-2.0.0.tar.gz PATCH)
dk_chdir(${SMPEG2_DEBUG_DIR})

### PATCH ###
dk_gitApplyPatch(${SMPEG2} $ENV{DKIMPORTS_DIR}/smpeg2/gcc6.patch)
dk_chdir(${SMPEG2_DEBUG_DIR})

### LINK ###
dk_include				(${SMPEG2})
if(MSVC)
	WIN_dk_libDebug		(${SMPEG2}/${Target_Triple}/lib/${DEBUG_DIR}/libsmpeg2.lib)
	WIN_dk_libRelease	(${SMPEG2}/${Target_Triple}/lib/${RELEASE_DIR}/libsmpeg2.lib)
elseif(APPLE)
	dk_libDebug			(${SMPEG2}/${Target_Triple}/lib/${DEBUG_DIR}/libsmpeg2.a)
	dk_libRelease		(${SMPEG2}/${Target_Triple}/lib/${RELEASE_DIR}/libsmpeg2.a)
else()
	dk_libDebug			(${SMPEG2_DEBUG_DIR}/lib/libsmpeg2.a)
	dk_libRelease		(${SMPEG2_RELEASE_DIR}/lib/libsmpeg2.a)
endif()



### 3RDPARTY LINK ###
dk_set(SMPEG2_CMAKE -DSMPEG_INCLUDE_DIR=${SMPEG2})
	
	
### GENERATE ###
dk_replaceAll("${DKCMAKE_BUILD}" "-std=c17"   ""  DKCMAKE_BUILD)
dk_replaceAll("${DKCMAKE_BUILD}" "-std=c++1z" ""  DKCMAKE_BUILD)
dk_replaceAll("${DKCMAKE_BUILD}" "  "         " " DKCMAKE_BUILD)

if(MSVC)
	#dk_queueCommand(${DKCMAKE_BUILD} ${SDL_CMAKE})
	dk_configure(${SMPEG2_DIR} ${SDL_CMAKE})
else()
	#dk_queueCommand(${DKCMAKE_BUILD} ${SDL_CMAKE} -DCMAKE_CXX_FLAGS=-Wno-narrowing)
	dk_configure(${SMPEG2_DIR} ${SDL_CMAKE} -DCMAKE_CXX_FLAGS=-Wno-narrowing)
endif()



### COMPILE ###
dk_build(${SMPEG2} SMPEG)

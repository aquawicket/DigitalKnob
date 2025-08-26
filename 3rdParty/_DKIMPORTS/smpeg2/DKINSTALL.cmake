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


###### smpeg2 ######
## https://github.com/icculus/smpeg.git
## https://www.libsdl.org/projects/smpeg/release/smpeg2-2.0.0.tar.gz

dk_validate(Target_Config  "dk_Target_Config()")

### DEPEND ###
dk_depend(sdl)
dk_depend(git)

### IMPORT ###
dk_import(https://www.libsdl.org/projects/smpeg/release/smpeg2-2.0.0.tar.gz PATCH)
dk_chdir(${SMPEG2_Debug_Dir})

### PATCH ###
dk_gitApplyPatch(${SMPEG2} $ENV{DKIMPORTS_DIR}/smpeg2/gcc6.patch)
dk_chdir(${SMPEG2_Debug_Dir})

### LINK ###
dk_include				(${SMPEG2})
if(MSVC)
	Windows_dk_libDebug		(${SMPEG2}/${Target_Tuple}/lib/${Debug_Dir}/libsmpeg2.lib)
	Windows_dk_libRelease	(${SMPEG2}/${Target_Tuple}/lib/${Release_Dir}/libsmpeg2.lib)
elseif(Apple)
	dk_libDebug			(${SMPEG2}/${Target_Tuple}/lib/${Debug_Dir}/libsmpeg2.a)
	dk_libRelease		(${SMPEG2}/${Target_Tuple}/lib/${Release_Dir}/libsmpeg2.a)
else()
	dk_libDebug			(${SMPEG2_Debug_Dir}/lib/libsmpeg2.a)
	dk_libRelease		(${SMPEG2_Release_Dir}/lib/libsmpeg2.a)
endif()



### 3RDPARTY LINK ###
dk_set(SMPEG2_CMAKE -DSMPEG_INCLUDE_DIR=${SMPEG2})
	
	
### GENERATE ###
dk_replaceAll("${DKCMAKE_BUILD}" "-std=c17"   ""  DKCMAKE_BUILD)
dk_replaceAll("${DKCMAKE_BUILD}" "-std=c++1z" ""  DKCMAKE_BUILD)
dk_replaceAll("${DKCMAKE_BUILD}" "  "         " " DKCMAKE_BUILD)

if(MSVC)
	#dk_exec(${DKCMAKE_BUILD} ${SDL_CMAKE})
	dk_configure(${SMPEG2} ${SDL_CMAKE})
else()
	#dk_exec(${DKCMAKE_BUILD} ${SDL_CMAKE} -DCMAKE_CXX_FLAGS=-Wno-narrowing)
	dk_configure(${SMPEG2} ${SDL_CMAKE} -DCMAKE_CXX_FLAGS=-Wno-narrowing)
endif()



### COMPILE ###
dk_build(${SMPEG2} SMPEG)

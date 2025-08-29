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


############ glew #############
# https://github.com/nigels-com/glew.git
# http://glew.sourceforge.net
# https://github.com/nigels-com/glew/releases/download/glew-2.2.0/glew-2.2.0.zip
#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")

#dk_validate(Target_Config  "dk_Target_Config()")
if(IOS OR Iossim OR Android)
	dk_disable(glew)
	dk_return()
endif()

### DEPEND ###
dk_depend(libglu1-mesa-dev)

### IMPORT ###
#dk_import(${glew_Import})
dk_import()

dk_copy(${GLEW}/build/cmake ${GLEW_Tuple_Dir}/CMakeFiles/Export/lib/cmake/glew OVERWRITE)

### LINK ###
dk_define			(GLEW_STATIC)
dk_include			(${GLEW}/include										GLEW_INCLUDE_DIR)
if(Apple)
	dk_libDebug		(${GLEW_Config_Dir}/lib/${Debug_Dir}/libGLEWd.a			GLEW_DEBUG_LIBRARY)
	dk_libRelease	(${GLEW_Config_Dir}/lib/${Release_Dir}/libGLEW.a		GLEW_RELEASE_LIBRARY)
elseif(MSVC)
	dk_libDebug		(${GLEW_Config_Dir}/lib/${Debug_Dir}/libglew32d.lib		GLEW_DEBUG_LIBRARY)
	dk_libRelease	(${GLEW_Config_Dir}/lib/${Release_Dir}/libglew32.lib	GLEW_RELEASE_LIBRARY)
elseif(Windows)
	dk_libDebug		(${GLEW_Debug_Dir}/lib/libglew32d.a						GLEW_DEBUG_LIBRARY)
	dk_libRelease	(${GLEW_Release_Dir}/lib/libglew32.a					GLEW_RELEASE_LIBRARY)
else()
	dk_libDebug		(${GLEW_Debug_Dir}/lib/libGLEWd.a						GLEW_DEBUG_LIBRARY)
	dk_libRelease	(${GLEW_Release_Dir}/lib/libGLEW.a						GLEW_RELEASE_LIBRARY)
endif()
if(Debug)
	dk_set			(GLEW_LIBRARY											${GLEW_DEBUG_LIBRARY})
endif()
if(Release)
	dk_set			(GLEW_LIBRARY											${GLEW_RELEASE_LIBRARY})
endif()

### 3RDPARTY LINK ###
# dk_set(GLEW_CMAKE
#	-DGLEW_USE_STATIC_LIB=ON
#	-DGLEW=${GLEW}/${Target_Tuple}/CMakeFiles/Export/lib/cmake/glew
#	-DGLEW_LIBRARY=${GLEW_LIBRARY_DEBUG}
#	-DGLEW_INCLUDE_DIR=${GLEW_INCLUDE_DIR}
#	-DGLEW_SHARED_LIBRARY_DEBUG=${GLEW}/${Target_Tuple}/lib/${Debug_Dir}/libglew32d.lib
#	-DGLEW_SHARED_LIBRARY_RELEASE=${GLEW}/${Target_Tuple}/lib/${Release_Dir}/libglew32.lib
#	-DGLEW_STATIC_LIBRARY_DEBUG=${GLEW}/${Target_Tuple}/lib/${Debug_Dir}/glew32d.lib
#	-DGLEW_STATIC_LIBRARY_RELEASE=${GLEW}/${Target_Tuple}/lib/${Release_Dir}/glew32.lib
#	-DGLEW_LIBRARIES=${GLEW_LIBRARY_DEBUG} ${GLEW_LIBRARY_RELEASE})
dk_set(GLEW_CMAKE 
	-DGLEW_INCLUDE_DIR=${GLEW_INCLUDE_DIR}
	-DGLEW_LIBRARY=${GLEW_LIBRARY})
if(MSVC)
	dk_append(GLEW_CMAKE 
		"-DCMAKE_C_FLAGS=/I${GLEW}/include /DGLEW_STATIC" 
		"-DCMAKE_CXX_FLAGS=/I${GLEW_INCLUDE_DIR} /DGLEW_STATIC")
else()
	dk_append(GLEW_CMAKE 
		"-DCMAKE_C_FLAGS=-I${GLEW}/include -DGLEW_STATIC" 
		"-DCMAKE_CXX_FLAGS=-I${GLEW_INCLUDE_DIR} -DGLEW_STATIC")
endif()


### GENERATE ###
dk_configure(${GLEW}/build/cmake)
#dk_copy(${GLEW}/${Target_Tuple}/lib/${Debug_Dir} ${GLEW}/${Target_Tuple}/CMakeFiles/Export/lib/ OVERWRITE)
#dk_copy(${GLEW}/${Target_Tuple}/lib/${Release_Dir} ${GLEW}/${Target_Tuple}/CMakeFiles/Export/lib/ OVERWRITE)
#dk_copy(${GLEW}/${Target_Tuple}/bin/${Debug_Dir} ${GLEW}/${Target_Tuple}/CMakeFiles/Export/bin/ OVERWRITE)
#dk_copy(${GLEW}/${Target_Tuple}/bin/${Release_Dir} ${GLEW}/${Target_Tuple}/CMakeFiles/Export/bin/ OVERWRITE)


### COMPILE ###
dk_build(${GLEW} glew_s)

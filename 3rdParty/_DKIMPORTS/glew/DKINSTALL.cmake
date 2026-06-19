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


############ glew #############
# https://github.com/nigels-com/glew.git
# http://glew.sourceforge.net
# https://github.com/nigels-com/glew/releases/download/glew-2.2.0/glew-2.2.0.zip

if(Ios OR Iossim OR Android)
	dk_disable(glew)
	dk_return()
endif()


if(Linux OR Raspberry)
	dk_depend(libglu1-mesa-dev)
endif()


dk_import()

dk_copy(${glew}/build/cmake ${glew_Tuple_Dir}/CMakeFiles/Export/lib/cmake/glew OVERWRITE)


dk_define			(GLEW_STATIC)
dk_include			(${glew}/include										GLEW_INCLUDE_DIR)
if(Apple)
	dk_libDebug		(${glew_Config_Dir}/lib/${Debug_Dir}/libGLEWd.a			GLEW_DEBUG_LIBRARY		GLEW_LIBRARY)
	dk_libRelease	(${glew_Config_Dir}/lib/${Release_Dir}/libGLEW.a		GLEW_RELEASE_LIBRARY	GLEW_LIBRARY)
elseif(MSVC)
	dk_libDebug		(${glew_Config_Dir}/lib/${Debug_Dir}/libglew32d.lib		GLEW_DEBUG_LIBRARY		GLEW_LIBRARY)
	dk_libRelease	(${glew_Config_Dir}/lib/${Release_Dir}/libglew32.lib	GLEW_RELEASE_LIBRARY	GLEW_LIBRARY)
elseif(Windows)
	dk_libDebug		(${glew_Debug_Dir}/lib/libglew32d.a						GLEW_DEBUG_LIBRARY		GLEW_LIBRARY)
	dk_libRelease	(${glew_Release_Dir}/lib/libglew32.a					GLEW_RELEASE_LIBRARY	GLEW_LIBRARY)
else()
	dk_libDebug		(${glew_Debug_Dir}/lib/libGLEWd.a						GLEW_DEBUG_LIBRARY		GLEW_LIBRARY)
	dk_libRelease	(${glew_Release_Dir}/lib/libGLEW.a						GLEW_RELEASE_LIBRARY	GLEW_LIBRARY)
endif()


# dk_set(glew_CMAKE
#	-DGLEW_USE_STATIC_LIB=ON
#	-DGLEW=${glew}/${Target_Tuple}/CMakeFiles/Export/lib/cmake/glew
#	-DGLEW_LIBRARY=${GLEW_LIBRARY_DEBUG}
#	-DGLEW_INCLUDE_DIR=${GLEW_INCLUDE_DIR}
#	-DGLEW_SHARED_LIBRARY_DEBUG=${glew}/${Target_Tuple}/lib/${Debug_Dir}/libglew32d.lib
#	-DGLEW_SHARED_LIBRARY_RELEASE=${glew}/${Target_Tuple}/lib/${Release_Dir}/libglew32.lib
#	-DGLEW_STATIC_LIBRARY_DEBUG=${glew}/${Target_Tuple}/lib/${Debug_Dir}/glew32d.lib
#	-DGLEW_STATIC_LIBRARY_RELEASE=${glew}/${Target_Tuple}/lib/${Release_Dir}/glew32.lib
#	-DGLEW_LIBRARIES=${GLEW_LIBRARY_DEBUG} ${GLEW_LIBRARY_RELEASE})
dk_set(glew_CMAKE 
	-DGLEW_INCLUDE_DIR=${GLEW_INCLUDE_DIR}
	-DGLEW_LIBRARY=${GLEW_LIBRARY})
if(MSVC)
	dk_append(glew_CMAKE 
		"-DCMAKE_C_FLAGS=/I${GLEW_INCLUDE_DIR} /DGLEW_STATIC" 
		"-DCMAKE_CXX_FLAGS=/I${GLEW_INCLUDE_DIR} /DGLEW_STATIC")
else()
	dk_append(glew_CMAKE 
		"-DCMAKE_C_FLAGS=-I${GLEW_INCLUDE_DIR} -DGLEW_STATIC" 
		"-DCMAKE_CXX_FLAGS=-I${GLEW_INCLUDE_DIR} -DGLEW_STATIC")
endif()



dk_configure(${glew}/build/cmake)
#dk_copy(${glew}/${Target_Tuple}/lib/${Debug_Dir} ${glew}/${Target_Tuple}/CMakeFiles/Export/lib/ OVERWRITE)
#dk_copy(${glew}/${Target_Tuple}/lib/${Release_Dir} ${glew}/${Target_Tuple}/CMakeFiles/Export/lib/ OVERWRITE)
#dk_copy(${glew}/${Target_Tuple}/bin/${Debug_Dir} ${glew}/${Target_Tuple}/CMakeFiles/Export/bin/ OVERWRITE)
#dk_copy(${glew}/${Target_Tuple}/bin/${Release_Dir} ${glew}/${Target_Tuple}/CMakeFiles/Export/bin/ OVERWRITE)



dk_build(${glew} glew_s)

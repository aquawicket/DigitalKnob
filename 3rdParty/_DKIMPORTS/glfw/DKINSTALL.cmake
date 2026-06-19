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


###### glfw ######
# https://github.com/glfw/glfw.git
# https://www.glfw.org/docs/latest/compile.html
# https://github.com/glfw/glfw/archive/refs/heads/master.zip
# https://github.com/glfw/glfw/archive/b35641f4.zip
if(Android)
	dk_disable(glfw)
	dk_return()
endif()

#dk_depend(wayland)
#dk_depend(x11)

dk_import()

dk_include			(${glfw}/include									GLFW_INCLUDE_DIR)
dk_include			(${glfw_Config_Dir}/include/freetype2				GLFW_INCLUDE_DIR2)
if(MSVC)
	dk_libDebug		(${glfw_Config_Dir}/src/Debug/glfw3.lib				GLFW_LIBRARY_DEBUG		GLFW_LIBRARY)
	dk_libRelease	(${glfw_Config_Dir}/src/Release/glfw3.lib			GLFW_LIBRARY_RELEASE	GLFW_LIBRARY)
elseif(Mac)
	dk_libDebug		(${glfw_Config_Dir}/src/${Debug_Dir}/libglfw3.a		GLFW_LIBRARY_DEBUG		GLFW_LIBRARY)
	dk_libRelease	(${glfw_Config_Dir}/src/${Release_Dir}/libglfw3.a	GLFW_LIBRARY_RELEASE	GLFW_LIBRARY)
else()
	dk_libDebug		(${glfw_Config_Dir}/src/libglfw3.a					GLFW_LIBRARY_DEBUG		GLFW_LIBRARY)
	dk_libRelease	(${glfw_Config_Dir}/src/libglfw3.a					GLFW_LIBRARY_RELEASE	GLFW_LIBRARY)
endif()

dk_set(glfw_CMAKE -Dglfw3_DIR=${glfw}) #-DGLFW_INCLUDE_DIR=${GLFW_INCLUDE_DIR}

dk_configure(${glfw}
	#-DGLFW_BUILD_EXAMPLES=OFF 	# "Build the GLFW example programs" ${GLFW_STANDALONE}
	#-DGLFW_BUILD_TESTS=OFF 	# "Build the GLFW test programs" ${GLFW_STANDALONE}
	#-DGLFW_BUILD_DOCS=OFF 		# "Build the GLFW documentation" ON
	#-DGLFW_INSTALL=OFF			# "Generate installation target" ON
) 			

dk_build(${glfw})# glfw)

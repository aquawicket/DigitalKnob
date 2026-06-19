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


dk_validate(Target_Config  "dk_Target_Config()")
# https://github.com/openframeworks/openFrameworks
# https://github.com/openframeworks/openFrameworks/archive/refs/tags/0.10.0.zip
# https://github.com/openframeworks/openFrameworks/releases/download/0.11.2/of_v0.11.2_vs2017_release.zip  # WINDOWS


### DEPEND ###
dk_depend(glew)
dk_depend(opengl)
dk_depend(opengles)


### IMPORT ###
Android_dk_import	(https://github.com/openframeworks/openFrameworks/releases/download/0.11.2/of_v0.11.2_android_release.tar.gz)
Iossim_dk_import	(https://github.com/openframeworks/openFrameworks/releases/download/0.11.2/of_v0.11.2_ios_release.zip)
Ios_dk_import		(https://github.com/openframeworks/openFrameworks/releases/download/0.11.2/of_v0.11.2_ios_release.zip)
Linux_dk_import		(https://github.com/openframeworks/openFrameworks/releases/download/0.11.2/of_v0.11.2_linux64gcc6_release.tar.gz)
Mac_dk_import		(https://github.com/openframeworks/openFrameworks/releases/download/0.11.2/of_v0.11.2_osx_release.zip)
Raspberry_dk_import	(https://github.com/openframeworks/openFrameworks/releases/download/0.11.2/of_v0.11.2_linuxarmv6l_release.tar.gz)
Windows_dk_import	(https://github.com/openframeworks/openFrameworks/releases/download/0.11.2/of_v0.11.2_vs2017_release.zip PATCH)
#dk_import			(https://github.com/openframeworks/openFrameworks/archive/refs/tags/0.10.0.zip PATCH)
#dk_import			(https://github.com/openframeworks/openFrameworks.git PATCH)


### LINK ###
dk_include(${OPENFRAMEWORKS})
dk_include(${OPENFRAMEWORKS}/libs/cairo/include/cairo)
dk_include(${OPENFRAMEWORKS}/libs/fmodex/include)
dk_include(${OPENFRAMEWORKS}/libs/glew/include)
dk_include(${OPENFRAMEWORKS}/libs/glfw/include)
dk_include(${OPENFRAMEWORKS}/libs/glm/include)
dk_include(${OPENFRAMEWORKS}/libs/glu/include)
dk_include(${OPENFRAMEWORKS}/libs/json/include)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/3d)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/app)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/communication)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/events)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/gl)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/graphics)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/math)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/sound)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/types)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/utils)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/video)
dk_include(${OPENFRAMEWORKS}/libs/poco/include)
dk_include(${OPENFRAMEWORKS}/libs/tess2/include)
dk_include(${OPENFRAMEWORKS}/libs/utf8cpp/include)
dk_include(${OPENFRAMEWORKS}/libs/videoInput/include)
Unix_dk_libDebug	(${OPENFRAMEWORKS}/${Target_Tuple}/lib/${Debug_Dir}/libopenframeworks.a)
Unix_dk_libRelease	(${OPENFRAMEWORKS}/${Target_Tuple}/lib/${Release_Dir}/libopenframeworks.a)
Windows_dk_libDebug		(${OPENFRAMEWORKS}/${Target_Tuple}/lib/${Debug_Dir}/openFrameworks.lib)
Windows_dk_libRelease	(${OPENFRAMEWORKS}/${Target_Tuple}/lib/${Release_Dir}/openFrameworks.lib)


### GENERATE ###
dk_configure(${OPENFRAMEWORKS} -DOF_PATH=${OPENFRAMEWORKS})


### COMPILE ###
dk_build(${OPENFRAMEWORKS} openFrameworks)

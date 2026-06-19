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


if(Android OR Ios OR Iossim)
	dk_depend(opengles)
endif()


if(Emscripten)
	find_package(OpenGL REQUIRED)
	include_directories(${OpenGL_INCLUDE_DIRS})
	link_directories(${OpenGL_LIBRARY_DIRS})
	add_definitions(${OpenGL_DEFINITIONS})
	if(NOT OPENGL_FOUND)
    	dk_fatal("COULD NOT FIND OPENGL")
	endif()
	dk_lib(${OPENGL_LIBRARIES})
endif()


if(Linux OR Raspberry)
	dk_depend(mesa)
	dk_depend(libgl1-mesa-dev)

	find_package(OpenGL REQUIRED)
	include_directories(${OpenGL_INCLUDE_DIRS})
	link_directories(${OpenGL_LIBRARY_DIRS})
	add_definitions(${OpenGL_DEFINITIONS})
	if(NOT OPENGL_FOUND)
    	dk_fatal("COULD NOT FIND OPENGL")
	endif()
	dk_lib(${OPENGL_LIBRARIES})
endif()


if(Mac)
	dk_findLibrary(OpenGL)
endif()


if(Windows)
	dk_lib(opengl32.lib)
endif()

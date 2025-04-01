#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


dk_load(dk_builder)


if(ANDROID OR IOS OR IOSSIM)
	dk_depend(opengles)
endif()


if(EMSCRIPTEN)
	find_package(OpenGL REQUIRED)
	include_directories(${OpenGL_INCLUDE_DIRS})
	link_directories(${OpenGL_LIBRARY_DIRS})
	add_definitions(${OpenGL_DEFINITIONS})
	if(NOT OPENGL_FOUND)
    	dk_fatal("COULD NOT FIND OPENGL")
	endif()
	dk_lib(${OPENGL_LIBRARIES})
endif()


if(LINUX OR RASPBERRY)
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


if(MAC)
	dk_findLibrary(OpenGL)
endif()


if(WIN)
	dk_lib(opengl32.lib)
endif()

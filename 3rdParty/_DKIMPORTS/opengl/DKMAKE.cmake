include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)

WIN_dk_lib(opengl32.lib)


if(MAC)
	dk_findLibrary(OpenGL)
endif()

IOS_dk_depend(opengles)

IOSSIM_dk_depend(opengles)

if(LINUX)
	dk_depend(mesa-common-dev)
	dk_depend(libgl1-mesa-dev)

	find_package(OpenGL REQUIRED)
	include_directories(${OpenGL_INCLUDE_DIRS})
	link_directories(${OpenGL_LIBRARY_DIRS})
	add_definitions(${OpenGL_DEFINITIONS})
	if(NOT OPENGL_FOUND)
    	dk_fatal("COULD NOT FIND OPENGL")
	endif()
	LINUX_dk_lib(${OPENGL_LIBRARIES})
endif()

if(RASPBERRY)
	dk_depend(mesa-common-dev)
	dk_depend(libgl1-mesa-dev)
	
	find_package(OpenGL REQUIRED)
	include_directories(${OpenGL_INCLUDE_DIRS})
	link_directories(${OpenGL_LIBRARY_DIRS})
	add_definitions(${OpenGL_DEFINITIONS})
	if(NOT OPENGL_FOUND)
    	dk_fatal("COULD NOT FIND OPENGL")
	endif()
	RASPBERRY_dk_lib(${OPENGL_LIBRARIES})
endif()

if(EMSCRIPTEN)
	find_package(OpenGL REQUIRED)
	include_directories(${OpenGL_INCLUDE_DIRS})
	link_directories(${OpenGL_LIBRARY_DIRS})
	add_definitions(${OpenGL_DEFINITIONS})
	if(NOT OPENGL_FOUND)
    	dk_fatal("COULD NOT FIND OPENGL")
	endif()
	EMSCRIPTEN_dk_lib(${OPENGL_LIBRARIES})
endif()

ANDROID_dk_depend(opengles)

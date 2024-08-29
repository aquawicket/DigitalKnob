include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)

WIN_TARGET_dk_lib(opengl32.lib)


if(MAC)
	dk_findLibrary(OpenGL)
endif()

IOS_TARGET_dk_depend(opengles)

IOSSIM_TARGET_dk_depend(opengles)

if(LINUX)
	dk_depend(mesa-common-dev)
	dk_depend(libgl1-mesa-dev)

	find_package(OpenGL REQUIRED)
	include_directories(${OpenGL_INCLUDE_DIRS})
	link_directories(${OpenGL_LIBRARY_DIRS})
	add_definitions(${OpenGL_DEFINITIONS})
	if(NOT OPENGL_FOUND)
    	dk_warning("COULD NOT FIND OPENGL")
	endif()
	LINUX_TARGET_dk_lib(${OPENGL_LIBRARIES})
endif()

if(RASPBERRY)
	dk_depend(mesa-common-dev)
	dk_depend(libgl1-mesa-dev)
	
	find_package(OpenGL REQUIRED)
	include_directories(${OpenGL_INCLUDE_DIRS})
	link_directories(${OpenGL_LIBRARY_DIRS})
	add_definitions(${OpenGL_DEFINITIONS})
	if(NOT OPENGL_FOUND)
    	dk_warning("COULD NOT FIND OPENGL")
	endif()
	RASPBERRY_TARGET_dk_lib(${OPENGL_LIBRARIES})
endif()

if(EMSCRIPTEN)
	find_package(OpenGL REQUIRED)
	include_directories(${OpenGL_INCLUDE_DIRS})
	link_directories(${OpenGL_LIBRARY_DIRS})
	add_definitions(${OpenGL_DEFINITIONS})
	if(NOT OPENGL_FOUND)
    	dk_error("COULD NOT FIND OPENGL")
	endif()
	EMSCRIPTEN_dk_lib(${OPENGL_LIBRARIES})
endif()

ANDROID_TARGET_dk_depend(opengles)

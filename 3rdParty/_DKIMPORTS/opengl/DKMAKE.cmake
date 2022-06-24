
WIN_dk_lib(opengl32.lib)


if(MAC)
	FIND_LIBRARY(OpenGL_lib OpenGL)
	if(NOT OpenGL_lib)
		dk_error("Could not locate OpenGL framework")
	endif()
	APPLE_dk_lib(${OpenGL_lib})
endif()

IOS_dk_depend(opengles)

IOSSIM_dk_depend(opengles)

if(LINUX)
	find_package(OpenGL REQUIRED)
	include_directories(${OpenGL_INCLUDE_DIRS})
	link_directories(${OpenGL_LIBRARY_DIRS})
	add_definitions(${OpenGL_DEFINITIONS})
	if(NOT OPENGL_FOUND)
    	dk_error("COULD NOT FIND OPENGL")
	endif()
	LINUX_dk_lib(${OPENGL_LIBRARIES})
endif()

if(RASPBERRY)
	find_package(OpenGL REQUIRED)
	include_directories(${OpenGL_INCLUDE_DIRS})
	link_directories(${OpenGL_LIBRARY_DIRS})
	add_definitions(${OpenGL_DEFINITIONS})
	if(NOT OPENGL_FOUND)
    	dk_error("COULD NOT FIND OPENGL")
	endif()
	RASPBERRY_dk_lib(${OPENGL_LIBRARIES})
endif()	

ANDROID_dk_depend(opengles)


WIN_DKLIB(opengl32.lib)


if(MAC)
	FIND_LIBRARY(OpenGL_lib OpenGL)
	if(NOT OpenGL_lib)
		DKWARN("Could not locate OpenGL framework")
	endif()
	APPLE_DKLIB(${OpenGL_lib})
endif()

IOS_DKDEPEND(opengles)

IOSSIM_DKDEPEND(opengles)

if(LINUX)
	find_package(OpenGL REQUIRED)
	include_directories(${OpenGL_INCLUDE_DIRS})
	link_directories(${OpenGL_LIBRARY_DIRS})
	add_definitions(${OpenGL_DEFINITIONS})
	if(NOT OPENGL_FOUND)
    	DKWARN("COULD NOT FIND OPENGL")
	endif()
	LINUX_DKLIB(${OPENGL_LIBRARIES})
endif()

if(RASPBERRY)
	find_package(OpenGL REQUIRED)
	include_directories(${OpenGL_INCLUDE_DIRS})
	link_directories(${OpenGL_LIBRARY_DIRS})
	add_definitions(${OpenGL_DEFINITIONS})
	if(NOT OPENGL_FOUND)
    	DKWARN("COULD NOT FIND OPENGL")
	endif()
	RASPBERRY_DKLIB(${OPENGL_LIBRARIES})
endif()	

ANDROID_DKDEPEND(opengles)

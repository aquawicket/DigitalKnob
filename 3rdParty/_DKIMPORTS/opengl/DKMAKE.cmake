
# windows
if(WIN)
	LIST(APPEND WIN_LIBS opengl32.lib)
endif()

if(LINUX)
	find_package(OpenGL REQUIRED)
	include_directories(${OpenGL_INCLUDE_DIRS})
	link_directories(${OpenGL_LIBRARY_DIRS})
	add_definitions(${OpenGL_DEFINITIONS})
	if(NOT OPENGL_FOUND)
    	message(FATAL_ERROR "OPENGL not found!")
	endif()
	list(APPEND LINUX_LIBS ${OPENGL_LIBRARIES})
endif()


if(RASPBERRY)
	find_package(OpenGL REQUIRED)
	include_directories(${OpenGL_INCLUDE_DIRS})
	link_directories(${OpenGL_LIBRARY_DIRS})
	add_definitions(${OpenGL_DEFINITIONS})
	if(NOT OPENGL_FOUND)
    	message(FATAL_ERROR "OPENGL not found!")
	endif()
	list(APPEND RASPBERRY_LIBS ${OPENGL_LIBRARIES})
endif()	
	
if(ANDROID)
	DKDEFINE(GL_GLEXT_PROTOTYPES)
	list(APPEND ANDROID_LIBS GLESv1_CM)
	list(APPEND ANDROID_LIBS GLESv2)
endif()
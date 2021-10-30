
if(WIN)
	WIN_LIB(opengl32.lib)
endif()

if(MAC)
	FIND_LIBRARY(opengl_lib OpenGL)
	MAC_LIB(${opengl_lib})
endif()

if(IOS)
	#TODO
endif()

if(IOSSIM)
	#TODO
endif()

if(LINUX)
	find_package(OpenGL REQUIRED)
	include_directories(${OpenGL_INCLUDE_DIRS})
	link_directories(${OpenGL_LIBRARY_DIRS})
	add_definitions(${OpenGL_DEFINITIONS})
	if(NOT OPENGL_FOUND)
    	message(FATAL_ERROR "COULD NOT FIND OPENGL !")
	endif()
	LINUX_LIB(${OPENGL_LIBRARIES})
endif()

if(RASPBERRY)
	find_package(OpenGL REQUIRED)
	include_directories(${OpenGL_INCLUDE_DIRS})
	link_directories(${OpenGL_LIBRARY_DIRS})
	add_definitions(${OpenGL_DEFINITIONS})
	if(NOT OPENGL_FOUND)
    	message(FATAL_ERROR "COULD NOT FIND OPENGL !")
	endif()
	RASPBERRY_LIB(${OPENGL_LIBRARIES})
endif()	
	
if(ANDROID)
	DKDEFINE(GL_GLEXT_PROTOTYPES)
	ANDROID_LIB(GLESv1_CM)
	ANDROID_LIB(GLESv2)
endif()
if(WIN)
	DKDEPEND(opensl)
endif()

if(MAC)
	DKDEPEND(opensl)
endif()

if(IOS)
	FIND_LIBRARY(opensles_lib OpenSLES)
	if(NOT ${opensles_lib})
		#message(FATAL_ERROR "Could not locate OpenSLES framework")
	endif()
	APPLE_LIB(${opensles_lib})
endif()

if(IOSSIM)
	FIND_LIBRARY(opensles_lib OpenSLES)
	APPLE_LIB(${opensles_lib})
endif()

if(LINUX)
	DKDEPEND(opensl)
endif()

if(RASPBERRY)
	DKDEPEND(opensl)
endif()	

if(ANDROID)
	ANDROID_LIB(OpenSLES)
endif()
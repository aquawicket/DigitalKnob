if(NOT ANDROID)
	return()
endif()

# https://developer.apple.com/documentation/AVKit?language=objc

FIND_LIBRARY(dl_Lib dl)
if(NOT dl_Lib)
	DKWARN("Could not locate dl libraries")
endif()
message(STATUS "Found dl libraries ${dl_lib}")
ANDROID_DKLIB(${dl_Lib})

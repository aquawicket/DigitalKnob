# https://developer.apple.com/documentation/AVKit?language=objc

if(NOT ANDROID)
	return()
endif()


FIND_LIBRARY(dl_Lib dl)
if(NOT dl_Lib)
	dk_error("Could not locate dl libraries")
else()
	message(STATUS "Found dl libraries ${dl_lib}")
endif()
ANDROID_dk_lib(${dl_Lib})

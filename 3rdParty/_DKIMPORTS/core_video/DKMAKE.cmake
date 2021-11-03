# https://developer.apple.com/documentation/corevideo

FIND_LIBRARY(core_video_lib CoreVideo)
if(NOT ${core_video_lib})
	message(FATAL_ERROR "Could not locate CoreVideo framework")
endif()
APPLE_LIB(${core_video_lib})

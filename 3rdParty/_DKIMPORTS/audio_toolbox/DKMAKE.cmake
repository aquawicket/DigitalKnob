# https://developer.apple.com/documentation/audiotoolbox

FIND_LIBRARY(audiotoolbox_lib AudioToolbox)
if(NOT ${audiotoolbox_lib})
	message(FATAL_ERROR "Could not locate AudioToolbox framework")
endif()
APPLE_LIB(${audiotoolbox_lib})

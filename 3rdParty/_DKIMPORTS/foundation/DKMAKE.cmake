# https://developer.apple.com/documentation/foundation?language=objc

FIND_LIBRARY(foundation_lib Foundation)
if(NOT foundation_lib)
	message(FATAL_ERROR "Could not location Foundation framework")
endif()
APPLE_LIB(${foundation_lib})

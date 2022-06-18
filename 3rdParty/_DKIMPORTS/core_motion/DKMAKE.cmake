# https://developer.apple.com/documentation/coremotion?language=objc
if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(coremotion_lib CoreMotion)
if(NOT coremotion_lib)
	DKWARN("Could not locate CoreMotion framework")
endif()
APPLE_dk_lib(${coremotion_lib})

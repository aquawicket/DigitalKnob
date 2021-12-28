if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/coremotion?language=objc

FIND_LIBRARY(coremotion_lib CoreMotion)
if(NOT coremotion_lib)
	message(WARNING "Could not locate CoreMotion framework")
endif()
APPLE_DKLIB(${coremotion_lib})

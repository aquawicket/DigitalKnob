# https://developer.apple.com/documentation/coreservices/carbon_core

if(NOT MAC)
	return()
endif()

dk_findLibrary(Carbon)

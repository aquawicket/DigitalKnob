# https://developer.apple.com/documentation/coreservices/carbon_core?language=objc

if(NOT MAC)
	dk_return()
endif()

dk_findLibrary(Carbon)

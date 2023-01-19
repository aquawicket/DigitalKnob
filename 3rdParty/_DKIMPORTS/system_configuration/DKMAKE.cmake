# https://developer.apple.com/documentation/systemconfiguration?language=objc

if(NOT APPLE)
	dk_return()
endif()

dk_findLibrary(SystemConfiguration)

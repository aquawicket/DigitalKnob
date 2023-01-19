# https://developer.apple.com/documentation/systemconfiguration

if(NOT APPLE)
	dk_return()
endif()

dk_findLibrary(SystemConfiguration)

# https://developer.apple.com/documentation/systemconfiguration
if(NOT MAC_HOST)
	return()
endif()

dk_findLibrary(SystemConfiguration)

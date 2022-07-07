# https://developer.apple.com/documentation/corehaptics?language=objc

if(NOT MAC_HOST)
	return()
endif()


dk_findLibrary(CoreHaptics)

# https://developer.apple.com/documentation/quartzcore
if(NOT MAC_HOST)
	return()
endif()


dk_findLibrary(QuartzCore)

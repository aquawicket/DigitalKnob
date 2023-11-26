# https://developer.apple.com/documentation/quartzcore?language=objc

if(NOT APPLE)
	dk_undepend(quartz_core)
	dk_return()
endif()


dk_findLibrary(QuartzCore)

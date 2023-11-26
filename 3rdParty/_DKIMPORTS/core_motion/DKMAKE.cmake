# https://developer.apple.com/documentation/coremotion?language=objc

if(NOT APPLE)
	dk_undepend(core_motion)
	dk_return()
endif()

dk_findLibrary(CoreMotion)

# https://developer.apple.com/documentation/metal?language=objc

if(NOT APPLE)
	dk_undepend(metalkit)
	dk_return()
endif()

dk_findLibrary(MetalKit)
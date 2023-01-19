# https://developer.apple.com/documentation/coregraphics?language=objc

if(NOT APPLE)
	dk_return()
endif()

dk_findLibrary(CoreGraphics)

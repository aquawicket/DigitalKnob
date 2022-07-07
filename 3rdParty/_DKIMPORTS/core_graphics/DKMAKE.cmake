# https://developer.apple.com/documentation/coregraphics?language=objc

if(NOT MAC_HOST)
	return()
endif()

dk_findLibrary(CoreGraphics)

# https://developer.apple.com/documentation/UIKit
if(NOT IOS)
	dk_undepend(uikit)
	dk_return()
endif()

dk_findLibrary(UIKit)

include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaFundamentals/WhatIsCocoa/WhatIsCocoa.html

if(NOT APPLE)
	dk_undepend(cocoa)
	dk_return()
endif()

dk_findLibrary(Cocoa)

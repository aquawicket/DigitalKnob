include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://developer.apple.com/documentation/appkit?language=objc

if(NOT MAC)
	dk_undepend(appkit)
	dk_return()
endif()

dk_findLibrary(Appkit)

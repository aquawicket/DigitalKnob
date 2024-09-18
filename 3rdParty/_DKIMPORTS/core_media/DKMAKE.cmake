include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://developer.apple.com/documentation/coremedia?language=objc

if(NOT APPLE)
	dk_undepend(core_media)
	dk_return()
endif()

dk_findLibrary(CoreMedia)

include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://developer.apple.com/documentation/videotoolbox?language=objc

if(NOT APPLE)
	dk_undepend(video_toolbox)
	dk_return()
endif()

dk_findLibrary(VideoToolbox)

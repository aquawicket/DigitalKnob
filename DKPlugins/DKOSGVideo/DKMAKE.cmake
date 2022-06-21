if(ANDROID)
	return()
endif()

dk_depend(openscenegraph osgdb_ffmpeg)
dk_depend(DKOSGWindow)

dk_generateCmake(DKOSGVideo)
dk_assets(DKOSGVideo)

if(NOT USE_metal)
	return()
endif()

dk_depend(DKAssets)
dk_depend(DKSdlMetalWindow)
dk_depend(DKRml)
dk_depend(sdl_image)
## dk_depend(sdl2_gif) ##Deprecated
## dk_depend(sdl2_giflib_sa-master) ##FIXME

dk_generateCmake(DKSdlMetalRml)
if(NOT USE_metal)
	return()
endif()

DKDEPEND(DKAssets)
DKDEPEND(DKSDLMetalWindow)
DKDEPEND(DKRml)
DKDEPEND(sdl2_image)
## DKDEPEND(sdl2_gif) ##Deprecated
## DKDEPEND(sdl2_giflib_sa-master) ##FIXME

generateCmake(DKSDLMetalRml)
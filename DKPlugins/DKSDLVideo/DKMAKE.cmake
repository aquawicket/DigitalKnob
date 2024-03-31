if(WIN)
	RETURN()
endif()

dk_depend(waave)
dk_depend(DKVideo)
dk_depend(DKSDLWindow)

dk_generateCmake(DKSDLVideo)
dk_assets(DKSDLVideo)

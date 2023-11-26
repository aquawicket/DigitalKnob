IF(WIN)
	RETURN()
ENDIF()

dk_depend(waave)
dk_depend(DKVideo)
dk_depend(DKSDLWindow)

dk_generateCmake(DKSDLVideo)
dk_assets(DKSDLVideo)

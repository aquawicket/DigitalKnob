IF(NOT HAVE_DKCef)
	RETURN()
ENDIF()

IF(ANDROID)
	RETURN()
ENDIF()

IF(IOSSIM)
	RETURN()
ENDIF()

dk_depend(DKSDLWindow)
dk_depend(DKCef)
dk_depend(DKCefChild)
dk_depend(DKAssets)

dk_generateCmake(DKSDLCef)

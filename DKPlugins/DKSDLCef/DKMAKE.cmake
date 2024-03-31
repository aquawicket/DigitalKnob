if(NOT HAVE_DKCef)
	RETURN()
endif()

if(ANDROID)
	RETURN()
endif()

if(IOSSIM)
	RETURN()
endif()

dk_depend(DKSDLWindow)
dk_depend(DKCef)
dk_depend(DKCefChild)
dk_depend(DKAssets)

dk_generateCmake(DKSDLCef)

dk_depend(tesseract)
dk_depend(DKImageMagick)
##dk_depend(podofo)
IF(HAVE_DKDuktape)
	dk_depend(DKDuktape)
ENDIF()
IF(HAVE_DKCef)
	dk_depend(DKCef)
ENDIF()


dk_generateCmake(DKOcr)
dk_assets(DKOcr)

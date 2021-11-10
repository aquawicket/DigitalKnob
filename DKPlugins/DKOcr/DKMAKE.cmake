DKDEPEND(tesseract)
DKDEPEND(DKImageMagick)
##DKDEPEND(podofo)
IF(USE_DKDuktape)
	DKDEPEND(DKDuktape)
ENDIF()
IF(USE_DKCef)
	DKDEPEND(DKCef)
ENDIF()


generateCmake(DKOcr)
DKASSETS(DKOcr)

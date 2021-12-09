DKDEPEND(tesseract)
DKDEPEND(DKImageMagick)
##DKDEPEND(podofo)
IF(HAVE_DKDuktape)
	DKDEPEND(DKDuktape)
ENDIF()
IF(HAVE_DKCef)
	DKDEPEND(DKCef)
ENDIF()


generateCmake(DKOcr)
DKASSETS(DKOcr)
